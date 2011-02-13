From: <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sun, 13 Feb 2011 09:51:59 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 90731245A3
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 11:23:14 +0100 (CET)
In-Reply-To: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ylin@mail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
> ________________________________________
> From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of ext ylin@mail.com [ylin@mail.com]
> Sent: Saturday, February 12, 2011 18:16
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] Channel swapping issue on TI OMAP3/TWL4030
> 
> Hi,
> 
> We are using a customized TI OMAP3 with TWL4030, similar to OMAP3EVM
> board.  We noticed occasionally (after bring up few hours) the mic
> channel  audio is swapped.  Has anyone seen similar problem? Any
> suggestion where the problem might be?

I have not experienced with channel swapping during capture..
It would help, if I know:
what is your kernel version
Source of the recording (digimic, HS, main mic, etc)

To clarify:
you experience sudden channel switch during active recording, when
the recording was running for few hours?
Or is it that you start/stop the recording, and sometimes the channels
are swapped?

Peter
