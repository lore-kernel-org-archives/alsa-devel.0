From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20160531 build: 0 failures 3 warnings (next-20160531)
Date: Tue, 31 May 2016 12:44:30 +0200
Message-ID: <6205928.96cQKykR0D@wuerfel>
References: <E1b7d6Z-0007G5-AH@optimist>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <E1b7d6Z-0007G5-AH@optimist>
Sender: linux-next-owner@vger.kernel.org
To: kernel-build-reports@lists.linaro.org
Cc: Build bot for Mark Brown <broonie@kernel.org>, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 31, 2016 7:24:43 AM CEST Build bot for Mark Brown wrote:

> -------------------------------------------------------------------------------
> arm64-allmodconfig : PASS, 0 errors, 3 warnings, 0 section mismatches
> 
> Warnings:
> 	../sound/soc/codecs/cs47l24.c:1091:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> 	../sound/soc/codecs/wm5110.c:2246:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

These got introduced by 7baa7e2490e1 ("ASoC: arizona: Add event notification
on voice trigger events").

	Arnd
