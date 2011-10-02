From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/3] ASoC: davinci-pcm: add cpu-dai health
	callbacks
Date: Sun, 2 Oct 2011 19:54:35 +0100
Message-ID: <20111002185434.GH2857@opensource.wolfsonmicro.com>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
	<beb331a90431ab4dfefedc45f53e686df3bc3f61.1317417232.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 18FD510384B
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 20:54:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <beb331a90431ab4dfefedc45f53e686df3bc3f61.1317417232.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 05:23:02PM -0400, Ben Gardiner wrote:
> The CPU DAIs available to the davinci-pcm driver have the capability of
> detecting and reporting errors.

> Add callbacks to the struct davinci_pcm_dma_params passed to davinci-pcm
> from the CPU DAI.

This looks like something we should be doing at the subsystem level, the
DaVinci is far from unique in having the ability to detect errors at the
DAI level.

> This has several shortcomings:
> 1) It bubbles up to the user as underruns, not a fatal error -- some may prefer
> the former, I realize but the latter is more attractive to me. Same problem
> as with the previous patch in this series.

Why do you prefer a fatal error, and how do you distinguish a fatal
error from a glitch?
