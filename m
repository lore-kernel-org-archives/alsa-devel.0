From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 14:41:30 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03109559E7@HQMAIL01.nvidia.com>
References: <20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
	<20110121182725.GD22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4255@HQMAIL01.nvidia.com>
	<20110121183930.GG22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4257@HQMAIL01.nvidia.com>
	<20110121185750.GH22414@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 391AE243FB
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 23:41:46 +0100 (CET)
In-Reply-To: <20110121185750.GH22414@opensource.wolfsonmicro.com>
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

Mark Brown wrote on Friday, January 21, 2011 11:58 AM:
> On Fri, Jan 21, 2011 at 10:51:15AM -0800, Stephen Warren wrote:
> 
> > Hence, the arch/arm-mach-tegra changes in this patchset (excluding the
> > simple standalone addition of that one new header) build on code that
> > is neither in ASoC's nor Tegra's for-next branch. Hence, you won't be
> > able to carry that patch yourself since it won't apply, even with manual
> > merging I suspect.
> 
> So just to be absolutely clear, there really are external dependencies for
> the arch/arm bits of this patch series that go beyond the patch series
> itself?  That's the information I was asking to be flagged on future
> submissions.

Yes, the arch/arm bits (except that standalone patch to add the new header)
depend on a variety of other patches from before this patchset. Those other
patches fix a few missing things in the mainline Tegra support and/or simply
add platform devices and platform data for the new ASoC driver. At least
some of those patches will have to be reworked a little once Tegra's for-next
comes on line.

The sound/soc bits don't depend on anything except what's already in the
ACoC for-2.6.39 branch.

-- 
nvpublic
