From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Mon, 14 Feb 2011 12:58:35 -0500
Message-ID: <8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-ma02.mx.aol.com (imr-ma02.mx.aol.com [64.12.206.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 95819244A8
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 18:58:59 +0100 (CET)
Received: from imo-ma03.mx.aol.com (imo-ma03.mx.aol.com [64.12.78.138])
	by imr-ma02.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1EHwjVJ015258
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:58:45 -0500
Received: from ylin@mail.com
	by imo-ma03.mx.aol.com  (mail_out_v42.9.) id 5.eb5.fd42f1d (45455)
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 12:58:43 -0500 (EST)
In-Reply-To: <CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
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


> I have not experienced with channel swapping during capture..
> It would help, if I know:
> what is your kernel version
> Source of the recording (digimic, HS, main mic, etc)

We are using 2.6.32.  The source of the recording is using Analog Mic.  
The Left Main mic is always on, and Right Sub mic can be either on or 
off when this occurs.  We are not using AUX or digimic.

> To clarify:
> you experience sudden channel switch during active recording, when
> the recording was running for few hours?
> Or is it that you start/stop the recording, and sometimes the channels
> are swapped?

It is sudden channel switch during active recording.  There is no XRUN 
or any noticeable error when this happens.

This is a VoIP app, we have duplex audio when this happens.  Both 
capture and playback are setup to run at 48kHz, 2 channel, S16_LE, with 
period size 10 mSec.

For playing, the left and right are the same data, we could not tell if 
the channel switch happens to playback as well.

Thanks,
Ying
