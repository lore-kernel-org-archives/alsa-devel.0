From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 10:51:15 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4257@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
	<20110121182725.GD22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4255@HQMAIL01.nvidia.com>,
	<20110121183930.GG22414@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ABF8103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:51:34 +0100 (CET)
In-Reply-To: <20110121183930.GG22414@opensource.wolfsonmicro.com>
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

Mark Brown wrote:
> On Fri, Jan 21, 2011 at 10:36:42AM -0800, Stephen Warren wrote:
> 
> > Patch 3 (Adds various platform data to arch/arm/mach-tegra) depends
> > on patch 2, and should be checked into the Tegra for-next tree at some
> > later time. You can ignore this patch; I presented it simply to show a
> > complete set of patches. Sorry if the cover letter wasn't clear on this point.
> 
> I've no problem carrying that in ASoC if Colin is happy with it, it
> seems much easier to do that than to have to remember to apply it to the
> Tegra tree after the 2.6.39 merge window.

I'd like to get everything, or at least most of this, into 2.6.39 if at all possible.
I guess getting just the basic driver (i.e. before this addition of internal speaker
support) would be OK though, since none of the patches for the basic driver
have any cross-subsystem dependencies.

For the basic driver: Everything is already in the ASoC tree. I'll be pushing
patches to support it (i.e. add the required platform_data, and possibly various
Tegra infra-structure such as clock configuration additions and fixes etc.) to the
Tegra for-next tree once it's open to accept patches:

The problem is that the Tegra for-next branch isn't yet open for submissions,
(I was originally directed to provide patches against linux-tegra-2.6.36 and
just recently directed to provided patches against linux-tegra-2.6.37)
so I've been queueing up all the arch/arm-mach-tegra patches for submission
once Tegra for-next opens. Colin and Erik have said offline that this will be soon.

Hence, the arch/arm-mach-tegra changes in this patchset (excluding the simple
standalone addition of that one new header) build on code that is neither in ASoC's nor
Tegra's for-next branch. Hence, you won't be able to carry that patch yourself
since it won't apply, even with manual merging I suspect.

Sorry the situation is so confusing. I hope this explains some of the background.

-- 
nvpublic
