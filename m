From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: fix initialization of DMA
	buffers
Date: Thu, 9 Jun 2011 11:52:46 +0100
Message-ID: <20110609105246.GD12865@opensource.wolfsonmicro.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
	<1307563376-13055-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 502F9103B20
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 12:52:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307563376-13055-2-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 08, 2011 at 03:02:56PM -0500, Timur Tabi wrote:
> The DMA (PCM) driver used by some Freescale PowerPC supports separate DAIs
> for playback and capture, so DMA buffers should be allocated only for the
> initialized streams.  Instead of checking for the number of active channels,
> which apparently is not reliable, check to see if the actual stream object
> exists.

I'll apply this but...

> Also provide a better name for the DMA interrupt.

...this doesn't overlap with the bugfix at all.  Why have you sent it as
part of the same patch?
