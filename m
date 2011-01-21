From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add Harmony sound
	platform data type
Date: Fri, 21 Jan 2011 15:49:10 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955A2F@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-1-git-send-email-swarren@nvidia.com>
	<1295556731-25165-3-git-send-email-swarren@nvidia.com>
	<AANLkTimx3Co9HjpBoB07G8YnQG8LAukxMqLdCMgDf1j+@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03109559DF@HQMAIL01.nvidia.com>
	<AANLkTi=t0c4kCziPg=b0nqNRSw4od2U7__NwMu=dhW3Q@mail.gmail.com>
	<20110121234140.GA20247@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id F3A6A2444F
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 00:49:24 +0100 (CET)
In-Reply-To: <20110121234140.GA20247@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Colin Cross <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote on Sent: Friday, January 21, 2011 4:42 PM:
>
> On Fri, Jan 21, 2011 at 02:41:08PM -0800, Colin Cross wrote:
> 
> > Could the same platform_data patch go into both ASoC and Tegra?  It
> > would fall out in the merge, no matter who gets pulled first.  If we
> > go that route, whichever place you put the header, one of the trees
> > will have an include file that is in the other tree's directory.
> 
> The usual thing here would be a branch that gets merged into both trees
> (to avoid the commit getting duplicated) or to only apply in one tree and
> let things sort themselves out in -next and the merge window.

Ah yes, I do remember you mentioning that before. Now I realize exactly
what you mean.

I'm quite happy to create a branch for this, cherry-pick my change onto it,
and tell you where it is, so you can merge from it.

What should I base the branch off; since it's a simple file add, I guess
the current mainline tree would be fine.

I assume there are no specific requirements for where the branch is hosted;
i.e. something you can git clone over HTTP from my personal server would
be fine?

Thanks!

-- 
nvpublic
