From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert WM8903 MICBIAS to a supply
 widget
Date: Mon, 28 Nov 2011 18:10:52 +0000
Message-ID: <20111128181052.GA16133@sirena.org.uk>
References: <1322396517-7122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF174FDAF7D1@HQMAIL01.nvidia.com>
	<20111128170029.GD18958@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 02C582433D
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 19:10:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111128170029.GD18958@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 05:00:29PM +0000, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 08:58:32AM -0800, Stephen Warren wrote:
> > Mark Brown wrote at Sunday, November 27, 2011 5:22 AM:

> > > -SND_SOC_DAPM_MICBIAS("Mic Bias", WM8903_MIC_BIAS_CONTROL_0, 0, 0),
> > > +SND_SOC_DAPM_SUPPLY("MICBIAS", WM8903_MIC_BIAS_CONTROL_0, 0, 0, NULL, 0),

> > For my education, why is this better modeled as a supply instead of a
> > mic bias? Thanks.

> The wiring in the DAPM map is *much* more comprehensible.

Oh, and the other thing is that it means that your device tree wiring
doesn't need to do any Linux-specific stuff to do with the funny way
the widgets needed to be wired up or jump through hoops otherwise and
can just talk about the pin being connected.
