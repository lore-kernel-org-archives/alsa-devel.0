From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcpdm: Set constraint for 24 msb
Date: Sun, 15 Jan 2012 03:22:26 -0800
Message-ID: <20120115112224.GB3040@opensource.wolfsonmicro.com>
References: <1326557803-18728-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE290245B3
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 12:22:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326557803-18728-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 14, 2012 at 05:16:43PM +0100, Peter Ujfalusi wrote:
> OMAP McPDM supports 24 msb in the 32 bit sample.
> Make sure that applications get this information.

This is actually a pretty widespread configuration for hardware - I'd
guess most devices that support 32 bit DAI formats don't actually use
all 32 bits.  If this is really useful to applications we should add a
framework feature letting drivers just set a number rather than adding
code individual drivers, I'll send a patch shortly adding a feature for
this.
