From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 02/11] fireface: postpone sound card
 registration
Date: Thu, 24 Dec 2015 20:21:35 +0100
Message-ID: <20151224202135.71363ef6@kant>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450614523-9367-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CD22260686
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:21:36 +0100 (CET)
In-Reply-To: <1450614523-9367-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Dec 20 Takashi Sakamoto wrote:
> Just after appearing on IEEE 1394 bus, this unit generates several bus
> resets. This is due to loading firmware from on-board flash memory and
> initialize hardware. It's better to postpone sound card registration.
> 
> This commit schedules workqueue to process actual probe processing
> 1 seconds after the last bus-reset. The card instance is kept at unit
> probe callback and released at card free callback. Therefore, when the
> actual probe processing fails, the memory block is wasted. This is due to
> simplify driver implementation.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/firewire/fireface/fireface.c | 59 ++++++++++++++++++++++++++++++++++----
>  sound/firewire/fireface/fireface.h |  3 ++
>  2 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
> index c8b7fe7..cf10e97 100644
> --- a/sound/firewire/fireface/fireface.c
> +++ b/sound/firewire/fireface/fireface.c
> @@ -10,6 +10,8 @@
>  
>  #define OUI_RME	0x000a35
>  
> +#define PROBE_DELAY_MS		(1 * MSEC_PER_SEC)
> +
>  MODULE_DESCRIPTION("RME Fireface series Driver");
>  MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
>  MODULE_LICENSE("GPL v2");
> @@ -32,16 +34,47 @@ static void ff_card_free(struct snd_card *card)
>  {
>  	struct snd_ff *ff = card->private_data;
>  
> +	/* The workqueue for registration uses the memory block. */
> +	cancel_work_sync(&ff->dwork.work);
> +
>  	fw_unit_put(ff->unit);
>  
>  	mutex_destroy(&ff->mutex);
>  }

The same comments apply as to patch "ALSA: dice: postpone card
registration":

  - use cancel_delayed_work_sync(&ff->dwork);

  - ff_card_free() is called via snd_card_free_when_closed() at
    snd_ff_remove() while &ff->mutex is held.  On the other hand, the
    worker do_probe() attempts to take the mutex too.  Hence this can
    deadlock.

    cancel_delayed_work_sync(&ff->dwork) needs to be called outside a
    ff->mutex protected section, certainly at the beginning of
    snd_ff_remove().

  - mutex_destroy(&ff->mutex); cannot be called here.
    snd_ff_remove() is still holding the mutex.

[No further comments below, only quoting the patch.]

> +static void do_probe(struct work_struct *work)
> +{
> +	struct snd_ff *ff = container_of(work, struct snd_ff, dwork.work);
> +	int err;
> +
> +	mutex_lock(&ff->mutex);
> +
> +	if (ff->card->shutdown || ff->probed)
> +		goto end;
> +
> +	err = snd_card_register(ff->card);
> +	if (err < 0)
> +		goto end;
> +
> +	ff->probed = true;
> +end:
> +	mutex_unlock(&ff->mutex);
> +
> +	/*
> +	 * It's a difficult work to manage a race condition between workqueue,
> +	 * unit event handlers and processes. The memory block for this card
> +	 * is released as the same way that usual sound cards are going to be
> +	 * released.
> +	 */
> +}
> +
>  static int snd_ff_probe(struct fw_unit *unit,
>  			   const struct ieee1394_device_id *entry)
>  {
> +	struct fw_card *fw_card = fw_parent_device(unit)->card;
>  	struct snd_card *card;
>  	struct snd_ff *ff;
> +	unsigned long delay;
>  	int err;
>  
>  	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
> @@ -60,26 +93,40 @@ static int snd_ff_probe(struct fw_unit *unit,
>  
>  	name_card(ff);
>  
> -	err = snd_card_register(card);
> -	if (err < 0) {
> -		snd_card_free(card);
> -		return err;
> -	}
> +	/* Register this sound card later. */
> +	INIT_DEFERRABLE_WORK(&ff->dwork, do_probe);
> +	delay = msecs_to_jiffies(PROBE_DELAY_MS) +
> +				fw_card->reset_jiffies - get_jiffies_64();
> +	schedule_delayed_work(&ff->dwork, delay);
>  
>  	return 0;
>  }
>  
>  static void snd_ff_update(struct fw_unit *unit)
>  {
> -	return;
> +	struct snd_ff *ff = dev_get_drvdata(&unit->device);
> +	struct fw_card *fw_card = fw_parent_device(unit)->card;
> +	unsigned long delay;
> +
> +	/* Postpone a workqueue for deferred registration. */
> +	if (!ff->probed) {
> +		delay = msecs_to_jiffies(PROBE_DELAY_MS) -
> +				(get_jiffies_64() - fw_card->reset_jiffies);
> +		mod_delayed_work(ff->dwork.wq, &ff->dwork, delay);
> +	}
>  }
>  
>  static void snd_ff_remove(struct fw_unit *unit)
>  {
>  	struct snd_ff *ff = dev_get_drvdata(&unit->device);
>  
> +	/* For a race condition of struct snd_card.shutdown. */
> +	mutex_lock(&ff->mutex);
> +
>  	/* No need to wait for releasing card object in this context. */
>  	snd_card_free_when_closed(ff->card);
> +
> +	mutex_unlock(&ff->mutex);
>  }
>  
>  static const struct ieee1394_device_id snd_ff_id_table[] = {
> diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
> index ab596c7..74877ef 100644
> --- a/sound/firewire/fireface/fireface.h
> +++ b/sound/firewire/fireface/fireface.h
> @@ -35,5 +35,8 @@ struct snd_ff {
>  	struct snd_card *card;
>  	struct fw_unit *unit;
>  	struct mutex mutex;
> +
> +	bool probed;
> +	struct delayed_work dwork;
>  };
>  #endif

-- 
Stefan Richter
-=====-===== ==-- ==---
http://arcgraph.de/sr/
