From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 18:39:30 +0000
Message-ID: <20110121183930.GG22414@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
	<20110121182725.GD22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4255@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F094103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:39:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4255@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Erik Gilling (konkers@google.com)" <konkers@google.com>, "Colin Cross (ccross@google.com)" <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 10:36:42AM -0800, Stephen Warren wrote:

> Patch 3 (Adds various platform data to arch/arm/mach-tegra) depends
> on patch 2, and should be checked into the Tegra for-next tree at some
> later time. You can ignore this patch; I presented it simply to show a
> complete set of patches. Sorry if the cover letter wasn't clear on this point.

I've no problem carrying that in ASoC if Colin is happy with it, it
seems much easier to do that than to have to remember to apply it to the
Tegra tree after the 2.6.39 merge window.

> Patch 4 (Adds internal speaker support to ASoC driver) depends on patch 2
> being in the ASoC tree somehow. Hence, why you asked the Tegra maintainers
> to sign off on checking patch 2 into the ASoC tree, as I understand it.

Yes.  It was your subsequent reply about stuff not having been submitted
that made me think that there were still more dependencies I wasn't
aware of.
