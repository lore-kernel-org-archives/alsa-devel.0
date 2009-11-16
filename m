From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Sound: MSM soc : imported alsa for the MSM
 from codeaurora
Date: Mon, 16 Nov 2009 11:25:21 +0000
Message-ID: <20091116112521.GB24114@rakim.wolfsonmicro.main>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
	<20091113145050.GC30966@sirena.org.uk>
	<1258315600.3690.4.camel@gnutoo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E347244FF
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 12:25:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258315600.3690.4.camel@gnutoo-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: GNUtoo <GNUtoo@no-log.org>
Cc: alsa-devel@alsa-project.org, pavel@ucw.cz
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 15, 2009 at 09:06:40PM +0100, GNUtoo wrote:

> About the debugging:
> *I noticed that if I change the .buffer_bytes_max to 4800 aplay doesn't
> work anymore...I'll try to find the good values...
> *I also noticed that aplay doesn't use the SNDRV_PCM_IOCTL_STATUS which
> would explain why aplay works and not mplayer... so I'll try to fix that
> too...

These both sound like the code for managing pushing of the buffers to
the DSP - like I said, it looks suspect on reading too so I'd not be
surprised if fixing the comprehensibility issues also make things work
better.
