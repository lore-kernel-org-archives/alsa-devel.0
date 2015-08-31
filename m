From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: What is exact definition of "normal/inverted" FSYNC
	signal polarity?
Date: Mon, 31 Aug 2015 09:40:04 -0700
Message-ID: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D241260496
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 18:40:05 +0200 (CEST)
Received: by vkbf67 with SMTP id f67so35976811vkb.0
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 09:40:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, lengo@google.com
List-Id: alsa-devel@alsa-project.org

Hi

I am trying to configure TegraX1 SoC and Realtek5677 codec. These two
drivers have different meaning of FSYNC polarity in TDM mode A format.

* TegraX1 driver thinks that "normal" polarity is when a frame starts
with FSYNC falling edge. TegraX1 applies it to all formats (I2S,
PCM/TDM mode A). And inverted FSYNC means that frame starts with
rising edge of FSYNC.

* RT5677 thinks that "normal" for I2S is "frame starts with falling
edge". And for TMD mode A "normal" means "frame starts with rising
FSYNC edge".

Thus normal/inverted FSYNC in TDM mode A are opposite at these 2
chips. Which one is correct? What is exact definition of
SND_SOC_DAIFMT_xB_yF constants in soc-dai.h?

I tried to google if I2S spec [1] defines FSYNC polarity but no luck.

It worth to clarify definition of BCLK polarity as well. I believe
"normal" BCLK is "line sensing happens at rising edge", "inverted"
BCLK - "line sensing happens at falling edge". Is it correct?

[1] https://web.archive.org/web/20060821114007/http://www.semiconductors.philips.com/acrobat_download/various/I2SBUS.pdf
