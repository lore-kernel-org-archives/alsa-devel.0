From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH 2/2 v2] ASoC:
	SSM2602: convert	to soc-cache
Date: Sun, 27 Mar 2011 19:18:12 +0100
Message-ID: <20110327181811.GA29715@opensource.wolfsonmicro.com>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
	<1301124975-2963-1-git-send-email-vapier@gentoo.org>
	<20110326124812.GG28537@opensource.wolfsonmicro.com>
	<AANLkTim8HH5PPA-d6cCqCfB2QqoP4O6825qSqyevTUr1@mail.gmail.com>
	<20110327103609.GA11148@opensource.wolfsonmicro.com>
	<AANLkTik63pnEueSr4QgH+Cf+1pqydSGt1bz_7R5ePmiX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B60B2436B
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 20:18:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTik63pnEueSr4QgH+Cf+1pqydSGt1bz_7R5ePmiX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2011 at 11:07:10AM -0400, Mike Frysinger wrote:

> so i could drop the whole for loop in favor of this one call ?

Yes.
