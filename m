From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH for-3.2 1/2] ASoC: omap-mcbsp: Fix FS
 polarity for LEFT_J, DSP_A and DSP_B formats
Date: Fri, 30 Sep 2011 12:51:34 +0100
Message-ID: <20110930115134.GF5366@opensource.wolfsonmicro.com>
References: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0DA6103B69
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 13:51:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 10:55:32AM +0300, Jarkko Nikula wrote:
> Commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the dai_link")
> changed DAI format flag values and we cannot simply invert anymore e.g.
> frame-sync with ^= SND_SOC_DAIFMT_NB_IF (which was anyway misuse) as there
> is no anymore fixed bit position for bit-clock or frame-sync inversion.

Applied, thanks.
