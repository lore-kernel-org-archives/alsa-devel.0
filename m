From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add Harmony sound
	platform data type
Date: Fri, 21 Jan 2011 21:34:15 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310955A8B@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-1-git-send-email-swarren@nvidia.com>
	<1295556731-25165-3-git-send-email-swarren@nvidia.com>
	<AANLkTimx3Co9HjpBoB07G8YnQG8LAukxMqLdCMgDf1j+@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03109559DF@HQMAIL01.nvidia.com>
	<AANLkTi=t0c4kCziPg=b0nqNRSw4od2U7__NwMu=dhW3Q@mail.gmail.com>
	<20110121234140.GA20247@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310955A2F@HQMAIL01.nvidia.com>
	<AANLkTi=XQ7ATDOH8NDbXk4Fgs4D8rnDTR6LokExuo+gP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id EE52224395
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 06:34:31 +0100 (CET)
In-Reply-To: <AANLkTi=XQ7ATDOH8NDbXk4Fgs4D8rnDTR6LokExuo+gP@mail.gmail.com>
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
To: Olof Johansson <olof@lixom.net>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Colin Cross <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Olof Johansson wrote on Friday, January 21, 2011 10:15 PM:
>
> On Fri, Jan 21, 2011 at 3:49 PM, Stephen Warren wrote:
> > Mark Brown wrote on Sent: Friday, January 21, 2011 4:42 PM:
> >> The usual thing here would be a branch that gets merged into both trees
> >> (to avoid the commit getting duplicated) or to only apply in one tree and
> >> let things sort themselves out in -next and the merge window.
> >
> > Ah yes, I do remember you mentioning that before. Now I realize exactly
> > what you mean.
> 
> Sounds overly complicated to me since you don't already have a tree
> hosted somewhere.

Well, I did push a kernel repo to my personal server, which would do
fine for this purpose assuming there's no requirement for it to stick
around for any specific amount of time etc.

-- 
nvpublic
