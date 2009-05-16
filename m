From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 17 May 2009 00:57:35 +0400
Message-ID: <20090517005735.fc382819.baz@irc.msk.ru>
References: <s5h4ovovtwe.wl%tiwai@suse.de>
	<20090517005251.9ade4602.baz@irc.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [217.112.17.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD5D246AC
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 22:57:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id 61A97AE06
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 00:57:36 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XkA0WWBXDiE for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 00:57:35 +0400 (MSD)
Received: from firefly.flat.yume.ru (cicada.yume.ru [217.172.19.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTPSA
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 00:57:35 +0400 (MSD)
In-Reply-To: <20090517005251.9ade4602.baz@irc.msk.ru>
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

On Sun, 17 May 2009 00:52:51 +0400
Alexey Bazhin <baz@irc.msk.ru> wrote:

> mplayer plays first open stream glitchy, but if i open one more
> mplayer, and then close the first - it plays fine but prints error:
> [AO_ALSA] alsa-lib: pcm_hw.c:1321:(snd_pcm_hw_open)
> open /dev/snd/pcmC0D0p failed: Invalid argument [AO_ALSA] alsa-lib:
> pcm_dmix.c:1058:(snd_pcm_dmix_open) unable to open slave [AO_ALSA]
> Playback open error: Invalid argument
disregard this part - buggy dmix configuration was left from previous
experiments...

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
