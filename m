From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH 2/2 v2] ASoC:
	SSM2602: convert	to soc-cache
Date: Sun, 27 Mar 2011 11:36:09 +0100
Message-ID: <20110327103609.GA11148@opensource.wolfsonmicro.com>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
	<1301124975-2963-1-git-send-email-vapier@gentoo.org>
	<20110326124812.GG28537@opensource.wolfsonmicro.com>
	<AANLkTim8HH5PPA-d6cCqCfB2QqoP4O6825qSqyevTUr1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9661B10381A
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 12:36:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim8HH5PPA-d6cCqCfB2QqoP4O6825qSqyevTUr1@mail.gmail.com>
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

On Sun, Mar 27, 2011 at 12:09:16AM -0400, Mike Frysinger wrote:

> is there an existing codec driver you can highlight that does what
> you're saying here ?

$ grep snd_soc_cache_sync sound/soc/codecs/*.c 
sound/soc/codecs/cs4271.c:	ret = snd_soc_cache_sync(codec);
sound/soc/codecs/max9850.c:			ret = snd_soc_cache_sync(codec);
sound/soc/codecs/wm8737.c:			snd_soc_cache_sync(codec);
sound/soc/codecs/wm8991.c:			snd_soc_cache_sync(codec);
sound/soc/codecs/wm8994.c:	ret = snd_soc_cache_sync(codec);
sound/soc/codecs/wm8995.c:			ret = snd_soc_cache_sync(codec);
