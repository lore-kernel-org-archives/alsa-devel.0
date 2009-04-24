From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Fri, 24 Apr 2009 11:13:08 -0500
Message-ID: <49F1E514.9040204@freescale.com>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
	<49F1DE99.7050104@freescale.com>
	<20090424160807.GI10450@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DD86F243C8
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 18:13:10 +0200 (CEST)
In-Reply-To: <20090424160807.GI10450@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:

> The switch's name is 'Master Capture Switch' which means to me that it
> is a thing that switches the capture on and off, and hence, it should be
> set to 'on' for normal operation. If it was meant to mute the input
> when switched on, the name should be 'Master Caputure Mute Switch' or
> something, right?

Beats me.  I'm the one asking questions!  But you still haven't told me
the difference between "------" and "L    R".  Does "------" mean that
capture should be muted, because it's been switched off?

> Don't know about the alsamixer tool, but with amixer, you can set the
> channels individually with the following syntax:
> 
> $ amixer cset numid=8 on,off
> numid=8,iface=MIXER,name='Master Playback Switch'
>   ; type=BOOLEAN,access=rw------,values=2
>   : values=on,off

I guess it's an alsamixer bug.

-- 
Timur Tabi
Linux kernel developer at Freescale
