From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: tegra: Harmony machine support
Date: Tue, 4 Jan 2011 15:30:20 +0000
Message-ID: <20110104153020.GE24774@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-11-git-send-email-swarren@nvidia.com>
	<20101217222636.GJ25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD7885D@HQMAIL01.nvidia.com>
	<20101217230618.GA28364@sirena.org.uk>
	<20101220211131.GG14986@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78E6C@HQMAIL01.nvidia.com>
	<20101223021916.GB25886@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD79220@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E31A22432E
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 16:31:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD79220@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 11:39:32AM -0800, Stephen Warren wrote:
> Mark Brown wrote:

> > It might be interesting to try having the CODEC master the I2S bus - it
> > might not change anything, but it sometimes shows up if one of the clock
> > lines is misconfigured.

> Having the codec be master of the bit and frame clocks appears to completely
> solve the noise issues. I do notice that different sample rates play the same
> audio at different pitches though, so something is still wrong, but it's most
> likely to be incorrect codec MCLK input right now; I'll keep investigating...

That's progress; with the CODEC as master all the clocks within the
CODEC will be configured correctly in relation to one another which will
help with the noise - probably the MCLK rate does have issues like you
say, with the CODEC as master pitch variations are a likely symptom.
