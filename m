From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: Fwd: [PATCH] sound working on the macbook pro
Date: Fri, 9 Mar 2007 21:57:45 -0800
Message-ID: <564d96fb0703092157t5b7f171cr1f94125cac32b782@mail.gmail.com>
References: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
	<s5hps8674an.wl%tiwai@suse.de>
	<564d96fb0702200140u7aee7dfbt271ed3818ed92366@mail.gmail.com>
	<s5hhcthrq3c.wl%tiwai@suse.de>
	<564d96fb0702201205i11beca64g11ca9602a53ad433@mail.gmail.com>
	<s5hy7mq5h5n.wl%tiwai@suse.de>
	<564d96fb0702221201o54468523k20976544157c99c8@mail.gmail.com>
	<s5hd5417xmx.wl%tiwai@suse.de>
	<564d96fb0702262134t438dd480t45c83e556f315e2e@mail.gmail.com>
	<s5h8xe8bqu8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xe8bqu8.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 > Then it means that stac92xx_hp_detect() isn't called properly, or the
> pin-detection doesn't work with your hardware.  Otherwise
> stac92xx_auto_init_multiout() should enable this pin.  Could you check
> whether stac92xx_hp_detect() is called and how is it processed
> (e.g. by adding printk's)?  Also, add a printk in
> stac92xx_auto_init_multiout() to make sure that this isn't called.

all tests performed with the new pin config.
 with the fix-up enabled:
*) stac92xx_auto_init_multi_out is not called
*) stac92xx_hp_detect is called:
 cfg->hp_outs = 1
 presence = 0 after the first loop
  cfg->line_outs = 3
  cfg->speaker_outs = 0
*) speakers don't work

 with the fix-up disabled:
*) stac92xx_auto_init_multi_out in not called
*) stac92xx_hp_detect is called:
 cfg->hp_outs = 1
 presense = 0 after the first loop
 cfg->line_outs = 0
 cfg->speaker_outs = 1
*) speakers work

> Takashi
>
Thanks,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
