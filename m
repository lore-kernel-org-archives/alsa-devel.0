From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: improve asynchronous mode
 support in the fsl_ssi driver
Date: Fri, 16 Sep 2011 00:06:15 +0100
Message-ID: <20110915230613.GE3218@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-3-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97AC510381C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:06:17 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2011 at 12:59:37PM -0500, Timur Tabi wrote:
> The Freescale SSI audio controller supports "synchronous" and "asynchronous"
> modes.  In synchronous mode, playback and capture use the same input clock,
> so sample rates must be the same during simultaneous playback and capture.
> Unfortunately, the code which supports asynchronous mode is just broken in
> various ways.  In particular, it was constraining sample sizes as well as
> the sample rate.

Applied, thanks.
