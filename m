From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 8/8] ALSA: firewire-tascam: deleyed
 registration of sound card
Date: Sun, 24 Apr 2016 21:50:52 +0900
Message-ID: <571CC12C.7090006@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
 <1459381629-24189-9-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8363E2608CF
 for <alsa-devel@alsa-project.org>; Sun, 24 Apr 2016 14:51:19 +0200 (CEST)
In-Reply-To: <1459381629-24189-9-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Iwai-san,

On Mar 31 2016 08:47, Takashi Sakamoto wrote:
> When some tascam units are connected sequentially, userspace
> applications are involved at bus-reset state on IEEE 1394 bus. In the
> state, any communications can be canceled. Therefore, sound card
> registration should be delayed till the bus gets calm.
> 
> This commit achieves it.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/firewire/tascam/tascam.c | 118 ++++++++++++++++++++++++++++-------------
>  sound/firewire/tascam/tascam.h |   2 +
>  2 files changed, 84 insertions(+), 36 deletions(-)

As of today, this patch is missing in 'for-next' branch of sound.git
reporitory[1], Would you please take it again?


Regards

Takashi Sakamoto

> diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
> index e281c33..9dc93a7 100644
> --- a/sound/firewire/tascam/tascam.c
> +++ b/sound/firewire/tascam/tascam.c
> @@ -85,10 +85,8 @@ static int identify_model(struct snd_tscm *tscm)
>  	return 0;
>  }
>  
> -static void tscm_card_free(struct snd_card *card)
> +static void tscm_free(struct snd_tscm *tscm)
>  {
> -	struct snd_tscm *tscm = card->private_data;
> -
>  	snd_tscm_transaction_unregister(tscm);
>  	snd_tscm_stream_destroy_duplex(tscm);
>  
> @@ -97,44 +95,36 @@ static void tscm_card_free(struct snd_card *card)
>  	mutex_destroy(&tscm->mutex);
>  }
>  
> -static int snd_tscm_probe(struct fw_unit *unit,
> -			   const struct ieee1394_device_id *entry)
> +static void tscm_card_free(struct snd_card *card)
>  {
> -	struct snd_card *card;
> -	struct snd_tscm *tscm;
> +	tscm_free(card->private_data);
> +}
> +
> +static void do_registration(struct work_struct *work)
> +{
> +	struct snd_tscm *tscm = container_of(work, struct snd_tscm, dwork.work);
>  	int err;
>  
> -	/* create card */
> -	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
> -			   sizeof(struct snd_tscm), &card);
> +	err = snd_card_new(&tscm->unit->device, -1, NULL, THIS_MODULE, 0,
> +			   &tscm->card);
>  	if (err < 0)
> -		return err;
> -	card->private_free = tscm_card_free;
> -
> -	/* initialize myself */
> -	tscm = card->private_data;
> -	tscm->card = card;
> -	tscm->unit = fw_unit_get(unit);
> -
> -	mutex_init(&tscm->mutex);
> -	spin_lock_init(&tscm->lock);
> -	init_waitqueue_head(&tscm->hwdep_wait);
> +		return;
>  
>  	err = identify_model(tscm);
>  	if (err < 0)
>  		goto error;
>  
> -	snd_tscm_proc_init(tscm);
> -
> -	err = snd_tscm_stream_init_duplex(tscm);
> +	err = snd_tscm_transaction_register(tscm);
>  	if (err < 0)
>  		goto error;
>  
> -	err = snd_tscm_create_pcm_devices(tscm);
> +	err = snd_tscm_stream_init_duplex(tscm);
>  	if (err < 0)
>  		goto error;
>  
> -	err = snd_tscm_transaction_register(tscm);
> +	snd_tscm_proc_init(tscm);
> +
> +	err = snd_tscm_create_pcm_devices(tscm);
>  	if (err < 0)
>  		goto error;
>  
> @@ -146,35 +136,91 @@ static int snd_tscm_probe(struct fw_unit *unit,
>  	if (err < 0)
>  		goto error;
>  
> -	err = snd_card_register(card);
> +	err = snd_card_register(tscm->card);
>  	if (err < 0)
>  		goto error;
>  
> -	dev_set_drvdata(&unit->device, tscm);
> +	/*
> +	 * After registered, tscm instance can be released corresponding to
> +	 * releasing the sound card instance.
> +	 */
> +	tscm->card->private_free = tscm_card_free;
> +	tscm->card->private_data = tscm;
> +	tscm->registered = true;
>  
> -	return err;
> +	return;
>  error:
> -	snd_card_free(card);
> -	return err;
> +	snd_tscm_transaction_unregister(tscm);
> +	snd_tscm_stream_destroy_duplex(tscm);
> +	snd_card_free(tscm->card);
> +	dev_info(&tscm->unit->device,
> +		 "Sound card registration failed: %d\n", err);
> +}
> +
> +static int snd_tscm_probe(struct fw_unit *unit,
> +			   const struct ieee1394_device_id *entry)
> +{
> +	struct snd_tscm *tscm;
> +
> +	/* Allocate this independent of sound card instance. */
> +	tscm = kzalloc(sizeof(struct snd_tscm), GFP_KERNEL);
> +	if (tscm == NULL)
> +		return -ENOMEM;
> +
> +	/* initialize myself */
> +	tscm->unit = fw_unit_get(unit);
> +	dev_set_drvdata(&unit->device, tscm);
> +
> +	mutex_init(&tscm->mutex);
> +	spin_lock_init(&tscm->lock);
> +	init_waitqueue_head(&tscm->hwdep_wait);
> +
> +	/* Allocate and register this sound card later. */
> +	INIT_DEFERRABLE_WORK(&tscm->dwork, do_registration);
> +	snd_fw_schedule_registration(unit, &tscm->dwork);
> +
> +	return 0;
>  }
>  
>  static void snd_tscm_update(struct fw_unit *unit)
>  {
>  	struct snd_tscm *tscm = dev_get_drvdata(&unit->device);
>  
> +	/* Postpone a workqueue for deferred registration. */
> +	if (!tscm->registered)
> +		snd_fw_schedule_registration(unit, &tscm->dwork);
> +
>  	snd_tscm_transaction_reregister(tscm);
>  
> -	mutex_lock(&tscm->mutex);
> -	snd_tscm_stream_update_duplex(tscm);
> -	mutex_unlock(&tscm->mutex);
> +	/*
> +	 * After registration, userspace can start packet streaming, then this
> +	 * code block works fine.
> +	 */
> +	if (tscm->registered) {
> +		mutex_lock(&tscm->mutex);
> +		snd_tscm_stream_update_duplex(tscm);
> +		mutex_unlock(&tscm->mutex);
> +	}
>  }
>  
>  static void snd_tscm_remove(struct fw_unit *unit)
>  {
>  	struct snd_tscm *tscm = dev_get_drvdata(&unit->device);
>  
> -	/* No need to wait for releasing card object in this context. */
> -	snd_card_free_when_closed(tscm->card);
> +	/*
> +	 * Confirm to stop the work for registration before the sound card is
> +	 * going to be released. The work is not scheduled again because bus
> +	 * reset handler is not called anymore.
> +	 */
> +	cancel_delayed_work_sync(&tscm->dwork);
> +
> +	if (tscm->registered) {
> +		/* No need to wait for releasing card object in this context. */
> +		snd_card_free_when_closed(tscm->card);
> +	} else {
> +		/* Don't forget this case. */
> +		tscm_free(tscm);
> +	}
>  }
>  
>  static const struct ieee1394_device_id snd_tscm_id_table[] = {
> diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
> index 30ab77e..1f61011 100644
> --- a/sound/firewire/tascam/tascam.h
> +++ b/sound/firewire/tascam/tascam.h
> @@ -51,6 +51,8 @@ struct snd_tscm {
>  	struct mutex mutex;
>  	spinlock_t lock;
>  
> +	bool registered;
> +	struct delayed_work dwork;
>  	const struct snd_tscm_spec *spec;
>  
>  	struct fw_iso_resources tx_resources;
> 
