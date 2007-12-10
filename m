From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-kernel: cmipci: disable "Modem"
	control on version 39 or newer	chips
Date: Mon, 10 Dec 2007 14:02:43 +0100
Message-ID: <m2ve768zyk.fsf@vador.mandriva.com>
References: <ALOGGER1197288764.96@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BB88524351
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 14:03:20 +0100 (CET)
In-Reply-To: <ALOGGER1197288764.96@alsa-project.org> (Clemens Ladisch's
	message of "Mon\, 10 Dec 2007 13\:12\:44 +0100 \(CET\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> writes:

> changeset:   5582:5082de4abb26
> tag:         tip
> user:        cladisch
> date:        Mon Dec 10 12:28:52 2007 +0100
> files:       pci/cmipci.c
> description:
> cmipci: disable "Modem" control on version 39 or newer chips
> 
> On version 39 or newer chips, we better remove the "Modem" control
> because this register bit now mutes the front channels of the
> multichannel stream.

shouldn't that deserve a comment in the code?
 
> diff -r eb09731e73d7 -r 5082de4abb26 pci/cmipci.c
> --- a/pci/cmipci.c	Mon Dec 03 17:08:40 2007 +0100
> +++ b/pci/cmipci.c	Mon Dec 10 12:28:52 2007 +0100
> @@ -2651,10 +2651,8 @@ static struct snd_kcontrol_new snd_cmipc
>  };
>  
>  /* card control switches */
> -static struct snd_kcontrol_new snd_cmipci_control_switches[] __devinitdata = {
> -	// DEFINE_CARD_SWITCH("Joystick", joystick), /* now module option */
> -	DEFINE_CARD_SWITCH("Modem", modem),
> -};
> +static struct snd_kcontrol_new snd_cmipci_modem_switch __devinitdata =
> +DEFINE_CARD_SWITCH("Modem", modem);
>  
>  
>  static int __devinit snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
> @@ -2735,9 +2733,9 @@ static int __devinit snd_cmipci_mixer_ne
>  	}
>  
>  	/* card switches */
> -	sw = snd_cmipci_control_switches;
> -	for (idx = 0; idx < ARRAY_SIZE(snd_cmipci_control_switches); idx++, sw++) {
> -		err = snd_ctl_add(cm->card, snd_ctl_new1(sw, cm));
> +	if (cm->chip_version < 39) {
> +		err = snd_ctl_add(cm->card,
> +				  snd_ctl_new1(&snd_cmipci_modem_switch, cm));
>  		if (err < 0)
>  			return err;
>  	}
> 
> 
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Alsa-cvslog mailing list
> Alsa-cvslog@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-cvslog
