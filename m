From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 02/11] fireface: postpone sound card
 registration
Date: Thu, 24 Dec 2015 22:02:00 +0100
Message-ID: <20151224220200.52a0b75e@kant>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
 <1450614523-9367-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id C08CC260642
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 22:02:01 +0100 (CET)
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
> --- a/sound/firewire/fireface/fireface.c
> +++ b/sound/firewire/fireface/fireface.c
> @@ -10,6 +10,8 @@
>  
>  #define OUI_RME	0x000a35
>  
> +#define PROBE_DELAY_MS		(1 * MSEC_PER_SEC)
[...]
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

Obviously the same concerns about overflow as in Takashi Iwai's comment on
patch "ALSA: dice: postpone card registration" apply here too.

This makes me wonder:  What if you simply use a fixed delay here without
subtraction of the time between "now" and "last reset"?  This would make
the code simpler, but would of course result in varying and less
predictable scheduling of your deferred function.
-- 
Stefan Richter
-=====-===== ==-- ==---
http://arcgraph.de/sr/
