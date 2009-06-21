From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Sun, 21 Jun 2009 01:13:39 +0100
Message-ID: <982CEEB9-22E6-4CE6-833F-806D31E8D6B8@opensource.wolfsonmicro.com>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
	<A40FAF28-889C-4322-A114-098EEA56FCE6@opensource.wolfsonmicro.com>
	<200906201915.39935.rgetz@blackfin.uclinux.org>
	(sfid-20090621_001240_652537_BCBB3B6E)
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EE7C245A1
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 02:13:55 +0200 (CEST)
In-Reply-To: <200906201915.39935.rgetz@blackfin.uclinux.org>
	(sfid-20090621_001240_652537_BCBB3B6E)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Barry Song <21cnbao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Frysinger <vapier.adi@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


On 21 Jun 2009, at 00:15, Robin Getz <rgetz@blackfin.uclinux.org> wrote:

> Any reason why platform/board specific things are in sound/soc/arch  
> rather
>>>
>>
> than arch/xxxx/boards - like the majority of drivers?

Partly because the APIs are sufficiently fluid to make the cross tree  
merge issues unmanageable, partly because non trivial boards really do  
need an entire driver for the board. I'd also say that at the minute  
I'm catching enough errors on review of machine drivers to make it  
worthwhile.
>
