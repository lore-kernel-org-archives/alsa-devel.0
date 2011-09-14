From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 3/3] ASoC: improve asynchronous mode
 support in the fsl_ssi driver
Date: Wed, 14 Sep 2011 13:37:21 +0100
Message-ID: <1316003841.3229.16.camel@odin>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-3-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DC6E1039A1
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 14:37:27 +0200 (CEST)
Received: by mail-ww0-f50.google.com with SMTP id 3so2094792wwe.31
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 05:37:24 -0700 (PDT)
In-Reply-To: <1315936777-27994-3-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 12:59 -0500, Timur Tabi wrote:
> The Freescale SSI audio controller supports "synchronous" and "asynchronous"
> modes.  In synchronous mode, playback and capture use the same input clock,
> so sample rates must be the same during simultaneous playback and capture.
> Unfortunately, the code which supports asynchronous mode is just broken in
> various ways.  In particular, it was constraining sample sizes as well as
> the sample rate.
> 
> The fix also allows us to simplify the code by eliminating the 'asynchronous',
> 'playback', and 'capture' variables that were used to keep track of playback
> and capture streams.
> 
> Unfortunately, it turns out that simulataneous playback and record does not
> actually work on the only platform that supports asynchronous mode: the
> Freescale P1022DS reference board.  If a second stream is started, the SSI
> grinds to halt for both streams.  This is true even if the P1022 is configured
> for synchronous mode, so it's likely a hardware problem that needs to be
> worked around.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@ti.com>
