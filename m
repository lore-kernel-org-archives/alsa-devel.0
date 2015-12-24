From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2/4] ALSA: dice: postpone card registration
Date: Thu, 24 Dec 2015 16:12:34 +0100
Message-ID: <20151224161234.39828fc7@kant>
References: <1450911310-15507-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450911310-15507-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 934B12605F2
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 16:12:35 +0100 (CET)
In-Reply-To: <1450911310-15507-3-git-send-email-o-takashi@sakamocchi.jp>
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

On Dec 24 Takashi Sakamoto wrote:
[...]
> Between bootstrap, firmware loading and post configuration, some bus resets
> are observed.
> 
> This commit offloads most processing of probe function into workqueue and
> schedules the workqueue after successive bus resets. This has an effect to
> get correct hardware information and avoid involvement to bus reset storm.
> 
> For code simplicity, this change effects all of Dice-based models, i.e.
> Dice II, Dice Jr., Dice Mini and Dice III. Due to the same reason, sound
> card instance is kept till card free function even if some errors are
> detected in the workqueue.
[...]
> --- a/sound/firewire/dice/dice.c
> +++ b/sound/firewire/dice/dice.c
> @@ -18,6 +18,8 @@ MODULE_LICENSE("GPL v2");
>  #define WEISS_CATEGORY_ID	0x00
>  #define LOUD_CATEGORY_ID	0x10
>  
> +#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
> +
>  static int check_dice_category(struct fw_unit *unit)
>  {
>  	struct fw_device *device = fw_parent_device(unit);
> @@ -185,6 +187,9 @@ static void dice_card_free(struct snd_card *card)
>  {
>  	struct snd_dice *dice = card->private_data;
>  
> +	/* The workqueue for registration uses the memory block. */
> +	cancel_work_sync(&dice->dwork.work);

According to the kerneldoc comment at cancel_work_sync, this should
actually be cancel_delayed_work_sync(&dice->dwork);.

> +
>  	snd_dice_stream_destroy_duplex(dice);
>  	snd_dice_transaction_destroy(dice);
>  	fw_unit_put(dice->unit);
> @@ -192,6 +197,66 @@ static void dice_card_free(struct snd_card *card)
>  	mutex_destroy(&dice->mutex);
>  }
>  
> +static void do_registration(struct work_struct *work)
> +{
> +	struct snd_dice *dice = container_of(work, struct snd_dice, dwork.work);
> +	int err;
> +
> +	mutex_lock(&dice->mutex);

So the worker needs to obtain &dice->mutex.  But...

[...]
> @@ -263,14 +307,25 @@ static void dice_remove(struct fw_unit *unit)
>  {
>  	struct snd_dice *dice = dev_get_drvdata(&unit->device);
>  
> +	/* For a race condition of struct snd_card.shutdown. */
> +	mutex_lock(&dice->mutex);
> +
>  	/* No need to wait for releasing card object in this context. */
>  	snd_card_free_when_closed(dice->card);
> +
> +	mutex_unlock(&dice->mutex);
>  }

...if I read snd_card_free_when_closed() and its surrounding code
correctly, then dice_card_free() is called from within this, which can
cause a deadlock.  Right?

If so, then it seems to me that cancel_delayed_work_sync(&dice->dwork)
should be moved out of dice_card_free() and be put at the beginning of
dice_remove().
-- 
Stefan Richter
-=====-===== ==-- ==---
http://arcgraph.de/sr/
