From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Allow arbitrary block
	read/write via SPI
Date: Mon, 24 Aug 2015 02:49:56 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F90387@RTITMBSV03.realtek.com.tw>
References: <1440217020-24365-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 961932605D4
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 04:50:03 +0200 (CEST)
In-Reply-To: <1440217020-24365-1-git-send-email-benzh@chromium.org>
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
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dylan Reid <dgreid@chromium.org>, Anatol Pomozov <anatol@google.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Ben Zhang [mailto:benzh@chromium.org]
> Sent: Saturday, August 22, 2015 12:17 PM
> To: Mark Brown
> Cc: alsa-devel@alsa-project.org; Liam Girdwood; Bard Liao; Oder Chiou; Anatol
> Pomozov; Dylan Reid; Ben Zhang
> Subject: [PATCH] ASoC: rt5677: Allow arbitrary block read/write via SPI
> 
> Added rt5677_spi_read() and refactored rt5677_spi_write() so that an arbitrary
> block in the DSP address space can be read/written via SPI. For example, this
> allows us to load an ELF DSP firmware with sparse sections, and stream audio
> samples from DSP ring buffer.
> 
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> ---

Acked-by: Oder Chiou <oder_chiou@realtek.com>

Thanks
