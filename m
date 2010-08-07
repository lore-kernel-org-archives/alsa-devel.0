From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/6] ASoC: new
	ADAU1761 codec driver
Date: Sun, 8 Aug 2010 00:10:31 +0100
Message-ID: <0123C8B2-6305-4E8C-AA00-4F3526F3B08C@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-5-git-send-email-vapier@gentoo.org>
	<B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
	<AANLkTinZd8KPqF+6r-sdZKkoSWF4tFVhxNV4B0xzwVqJ@mail.gmail.com>
	<DE733C15-5D63-4470-8124-238563F4629B@opensource.wolfsonmicro.com>
	<AANLkTim0=+ujDOZvGb=F0GtS+UvDpEOroNnddz12uJpv@mail.gmail.com>
	(sfid-20100807_234151_703653_45D683D3)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B000103816
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 01:10:11 +0200 (CEST)
In-Reply-To: <AANLkTim0=+ujDOZvGb=F0GtS+UvDpEOroNnddz12uJpv@mail.gmail.com>
	(sfid-20100807_234151_703653_45D683D3)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 23:41, Mike Frysinger <vapier.adi@gmail.com> wrote:

> yes, that is the current limitation that'll need to be fixed.  not a
> big hassle for us to replace the file when doing initial testing ;).

Sure, which is why I say that if you're going to expose this feature in this manner it should be via debugfs. That's the place for this sort of development only hack.
