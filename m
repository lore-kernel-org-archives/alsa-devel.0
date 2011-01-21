From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 10:36:42 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4255@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>,
	<20110121182725.GD22414@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 3410E103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:36:54 +0100 (CET)
In-Reply-To: <20110121182725.GD22414@opensource.wolfsonmicro.com>
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
> > Sorry, I don't follow. Possibly not what? Are you saying:
> 
> > a) Possibly not the only dependency? It's certainly the only one I know of.
> 
> > b) Possibly not that it needs to be checked into the ASoC git repo, even though
> > the header is located somewhere the Tegra git repo owns?
> 
> You said in <74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>:
> 
> | The other arch/arm patches won't apply anywhere yet since they build
> | on top of various other patches that haven't been submitted for or
> | applied to the linux-tegra tree yet.
> 
> referring to patches 2 and 3 of the series.  To me that says that these
> patches won't apply to either the Tegra or ASoC trees as they stand as
> they depend on patches you have not yet submitted.

Patch 1 (wm8903 GPIO support) has no dependencies.

Patch 2 (add header to define Harmony ASoC driver's platform_data)
doesn't depend on anything else, but is required by patches 3 and 4.

This is the patch which is in a path owned by the Tegra tree, but needs to
be checked into the ASoC tree to enable patch 4 to be checked in there.

Patch 3 (Adds various platform data to arch/arm/mach-tegra) depends
on patch 2, and should be checked into the Tegra for-next tree at some
later time. You can ignore this patch; I presented it simply to show a
complete set of patches. Sorry if the cover letter wasn't clear on this point.

Patch 4 (Adds internal speaker support to ASoC driver) depends on patch 2
being in the ASoC tree somehow. Hence, why you asked the Tegra maintainers
to sign off on checking patch 2 into the ASoC tree, as I understand it.

-- 
nvpublic
