From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC DSP and related status
Date: Thu, 1 Sep 2011 13:58:21 +0100
Message-ID: <20110901125821.GG14976@sirena.org.uk>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
	<20110827093656.GA2984@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A191@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7060B10380D
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 14:58:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A191@HQMAIL01.nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 31, 2011 at 04:14:43PM -0700, Stephen Warren wrote:

> +------------+  (dai 1)  +--------------+  (dai 2)  +----------------+
> | Tegra I2S  |<--------->| AHUB (codec) |<--------->| WM8903 (codec) |
> +------------+           +--------------+           +----------------+

> I think I may have asked this before, but how would we represent that to
> ASoC; I don't think there's any way to squash both those two DAIs into a
> single snd_soc_dai_link structure, whereas I think I recall you saying
> that using two separate snd_soc_dai_links wouldn't really work; I'm not
> sure what we'd put in dai2's "platform" field, and IIRC the second DAI
> would end up instantiating extra PCM devices to user-space. Am I way off
> base here, or would be need to do some extra infra-structure work to get
> this all working?

More infrastructure is needed but we really need it anyway (it's the
same infrastructure as we need for baseband type links).  The DAI 2
platform would just be left empty as there's no DMA going on.

We should probably also make sure that there's a way we can configure
the Tegra-internal links without requiring every single board to do it
and then have the board only configure the DAI 2 links otherwise it'll
just get repetitive.
