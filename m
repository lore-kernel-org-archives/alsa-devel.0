From: <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sun, 13 Feb 2011 09:48:00 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0274A46C9@008-AM1MPN1-027.mgdnok.nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>,
	<20110213112501.c23c3548.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 0858D24584
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 10:52:30 +0100 (CET)
In-Reply-To: <20110213112501.c23c3548.jhnikula@gmail.com>
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
To: jhnikula@gmail.com, ylin@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
> ________________________________________
> From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of ext Jarkko Nikula [jhnikula@gmail.com]
> Sent: Sunday, February 13, 2011 11:25
> To: ylin@mail.com
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Channel swapping issue on TI OMAP3/TWL4030
> 
> On Sat, 12 Feb 2011 11:16:42 -0500
> ylin@mail.com wrote:
> 
> > We are using a customized TI OMAP3 with TWL4030, similar to OMAP3EVM
> > board.  We noticed occasionally (after bring up few hours) the mic
> > channel  audio is swapped.  Has anyone seen similar problem? Any
> > suggestion where the problem might be?
> >
> Is this with recent kernels? There were this channel swapping problem
> before but it got fixed by Eero Nurkkala for the 2.6.32 kernel by
> following commits:

This is something different.
The channel swapping/shifting issue was affecting the playback
stream only.

Peter 
