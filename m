From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 17 May 2009 00:52:51 +0400
Message-ID: <20090517005251.9ade4602.baz@irc.msk.ru>
References: <s5h4ovovtwe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [217.112.17.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 494C1246A4
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 22:52:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id ED2FDAE06
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 00:52:52 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAm-dN6iwL9A for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 00:52:52 +0400 (MSD)
Received: from firefly.flat.yume.ru (cicada.yume.ru [217.172.19.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTPSA
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 00:52:52 +0400 (MSD)
In-Reply-To: <s5h4ovovtwe.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 May 2009 12:52:17 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Once after I get positive feedbacks (or fix after negative ones), I'm
> going to merge it to the main tree so that it'll be in the next
> kernel.  So, a quick test report would be greatly appreciated.
As for me:

aplay works fine with 16bit samples (doesn't tested 24bit)

mplayer plays first open stream glitchy, but if i open one more mplayer, and
then close the first - it plays fine but prints error:
[AO_ALSA] alsa-lib: pcm_hw.c:1321:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Invalid argument
[AO_ALSA] alsa-lib: pcm_dmix.c:1058:(snd_pcm_dmix_open) unable to open slave
[AO_ALSA] Playback open error: Invalid argument

Also ac3-passthrough works with this driver (finally!), but prints errors too:
mplayer -ac hwac3 -ao alsa:device=hw=0.4 test.ac3
[AO_ALSA] alsa-lib: conf.c:3843:(parse_args) Unknown parameter AES0
[AO_ALSA] alsa-lib: conf.c:3969:(snd_config_expand) Parse arguments error: No such file or directory
[AO_ALSA] alsa-lib: pcm.c:2196:(snd_pcm_open_noupdate) Unknown PCM hw:0,4,AES0=6

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
