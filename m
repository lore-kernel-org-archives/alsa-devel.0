From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: add build dependency to spi
Date: Sat, 18 Oct 2014 03:15:54 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F2A5EC@RTITMBSV03.realtek.com.tw>
References: <1413572202-18646-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BD642604AF
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 05:15:58 +0200 (CEST)
In-Reply-To: <1413572202-18646-1-git-send-email-anatol.pomozov@gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Anatol Pomozov [mailto:anatol.pomozov@gmail.com]
> Sent: Saturday, October 18, 2014 2:57 AM
> To: broonie@kernel.org
> Cc: Oder Chiou; alsa-devel@alsa-project.org; Anatol Pomozov
> Subject: [PATCH] ASoC: rt5677: add build dependency to spi
> 
> Since 9cb715a9d4c the codec has a hardcoded dependency to spi.
> Add this dependency to Kconfig. It fixes buildbot compilation failure:
> 
>    sound/built-in.o: In function `spi_write':
> >> rt5677-spi.c:(.text+0x8265f): undefined reference to `spi_sync'
>    sound/built-in.o: In function `rt5677_spi_driver_init':
> >> rt5677-spi.c:(.init.text+0x17db): undefined reference to `spi_register_driver'
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

Oder Chiou <oder_chiou@realtek.com>
