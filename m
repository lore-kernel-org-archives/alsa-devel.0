From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add Harmony sound
	platform data type
Date: Fri, 21 Jan 2011 23:41:40 +0000
Message-ID: <20110121234140.GA20247@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-1-git-send-email-swarren@nvidia.com>
	<1295556731-25165-3-git-send-email-swarren@nvidia.com>
	<AANLkTimx3Co9HjpBoB07G8YnQG8LAukxMqLdCMgDf1j+@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03109559DF@HQMAIL01.nvidia.com>
	<AANLkTi=t0c4kCziPg=b0nqNRSw4od2U7__NwMu=dhW3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4311524442
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 00:41:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=t0c4kCziPg=b0nqNRSw4od2U7__NwMu=dhW3Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Cross <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 02:41:08PM -0800, Colin Cross wrote:

> Could the same platform_data patch go into both ASoC and Tegra?  It
> would fall out in the merge, no matter who gets pulled first.  If we
> go that route, whichever place you put the header, one of the trees
> will have an include file that is in the other tree's directory.

The usual thing here would be a branch that gets merged into both trees
(to avoid the commit getting duplicated) or to only apply in one tree
and let things sort themselves out in -next and the merge window.

> I still think the header makes more sense in include/sound than
> mach-tegra, but if the ASoC maintainers prefer it in mach-tegra,
> consider the patch Acked-by: Colin Cross <ccross@android.com> for
> inclusion in the ASoC tree.

The general style for architecture specific headers is that they get
included in architecture specific directories to avoid general namespace
pollution.
