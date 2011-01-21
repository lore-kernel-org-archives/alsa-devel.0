From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 10:06:33 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>,
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 50A861037EA
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:06:48 +0100 (CET)
In-Reply-To: <20110121175034.GC6200@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Erik Gilling (konkers@google.com)" <konkers@google.com>, "Colin Cross
	(ccross@google.com)" <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote on Friday, January 21, 2011 10:50:
> On Fri, Jan 21, 2011 at 09:45:56AM -0800, Stephen Warren wrote:
> 
> > > I'm happy with this version of the series, I guess Liam will be too.
> > > Ideally someone from the Tegra side should sign off on the arch/arm
> > > side - that'll need to go through the same tree as the ASoC side for
> > > build dependencies.
> 
> > I assume you're only talking about:
> 
> > a882c75eadfcdc56f47962dd3f7870d6def62847
> > ARM: tegra: Add Harmony sound platform data type
> 
> That and the addition of the defines for function codes IIRC.

The wm8903 GPIO function defines? They're in wm8903.h and don't rely
on anything else. The arch/arm patches don't rely on these defines.

> > The other arch/arm patches won't apply anywhere yet since they build
> > on top of various other patches that haven't been submitted for or
> > applied to the linux-tegra tree yet.
> 
> Oh, I see.  I hadn't realised there wer eother dependencies, please
> ensure you mention any such dependencies in the changlogs so we avoid
> introducing breakage.

That was the intent of what I wrote in the "cover letter" "patch".

To be explicit, the only dependency is that the patch quoted above, which
adds some platform data types, needs to be checked in to te ASoC tree
rather than the usual ARM tree, before the following ASoC patch is
applied:

ASoC: tegra: Harmony: Support th internal speaker

Every other ASoC patch I've submitted doesn't rely on anything outside
the ASoC tree to compile, although actually running it usefully obviously
requires the arch/arm changes.

Hope this clears things up!

--
nvpublic
