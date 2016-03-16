From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [media] sound/usb: Use Media Controller API to
 share media resources
Date: Wed, 16 Mar 2016 07:51:39 -0600
Message-ID: <56E964EB.6090002@osg.samsung.com>
References: <20160316074054.GA12860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by alsa0.perex.cz (Postfix) with ESMTP id F403A26585C
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 14:51:51 +0100 (CET)
In-Reply-To: <20160316074054.GA12860@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Shuah Khan <shuahkh@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

On 03/16/2016 01:40 AM, Dan Carpenter wrote:
> Hello Shuah Khan,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch aebb2b89bff0: "[media] sound/usb: Use Media Controller API 
> to share media resources" from Mar 2, 2016, leads to the following 
> Smatch complaint:
> 
> sound/usb/card.c:615 usb_audio_probe()
> 	 error: we previously assumed 'quirk' could be null (see line 534)
> 
> sound/usb/card.c
>    583		/*
>    584		 * For devices with more than one control interface, we assume the
>    585		 * first contains the audio controls. We might need a more specific
>    586		 * check here in the future.
>    587		 */
>    588		if (!chip->ctrl_intf)
>    589			chip->ctrl_intf = alts;
>    590	
>    591		chip->txfr_quirk = 0;
>    592		err = 1; /* continue */
>    593		if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
>                     ^^^^^
> Old code assumes "quirk" can be NULL.
> 
>    594			/* need some special handlings */
>    595			err = snd_usb_create_quirk(chip, intf, &usb_audio_driver, quirk);
>    596			if (err < 0)
>    597				goto __error;
>    598		}
>    599	
>    600		if (err > 0) {
>    601			/* create normal USB audio interfaces */
>    602			err = snd_usb_create_streams(chip, ifnum);
>    603			if (err < 0)
>    604				goto __error;
>    605			err = snd_usb_create_mixer(chip, ifnum, ignore_ctl_error);
>    606			if (err < 0)
>    607				goto __error;
>    608		}
>    609	
>    610		/* we are allowed to call snd_card_register() many times */
>    611		err = snd_card_register(chip->card);
>    612		if (err < 0)
>    613			goto __error;
>    614	
>    615		if (quirk->media_device) {
>                     ^^^^^^^^^^^^^^^^^^^
> Patch adds an unchecked dereference.

Nicolai Stange sent in a patch to fix this.

thanks,
-- Shuah
> 
>    616			/* don't want to fail when media_snd_device_create() fails */
>    617			media_snd_device_create(chip, intf);
> 
> regards,
> dan carpenter
> 


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
