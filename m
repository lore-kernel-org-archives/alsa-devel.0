Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6ACA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:05:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42637222C6
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kKrzH9fI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnHLb1Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42637222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 363444E;
	Fri, 18 Oct 2019 22:05:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 363444E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571429154;
	bh=h6a2JN1DvpeSg3Z7SFkx+HmlkdjsAV4ev3H0s52eZIg=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kKrzH9fIcSKd6nkrJqfv4ykzSWT00hfF1W2MfMJCijXBfx2Z8ZV5YwV1VXhnwqFWs
	 nhy6FHvEtGJpC/NXgEWGm775vzIPAyzxd5b5q5y7L2cLMZFXxpHw+qzL+TP5iLM1an
	 /oMyHK/Dk5FK4sI7yr0hZyV5qjIXzn/UWsP0+q4k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADD8EF80322;
	Fri, 18 Oct 2019 22:05:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 218FCF80362; Fri, 18 Oct 2019 22:05:01 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CAC3F800F3
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 22:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CAC3F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="HnHLb1Qy"
Received: by mail-pg1-x543.google.com with SMTP id f14so3920145pgi.9
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ONWNl/MOpUcL47FjD89cTXsNpRQ5J+dRoEkZC2nUB8A=;
 b=HnHLb1QyQjR7dQpUiPIu77keRl5yzu9q5+xyo1ZbgHme0b5w77R/+wk7/ywETg09CF
 DJ0ru/JmbRa2SG1y6p4RuxQveurImlUl1FCFpKH5rntPD6Tgbwzy2cYwrB/YK72hvP8b
 AJJyka4f6FYkQN4yW2MYG+dAtaVUZ6e6eKk+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ONWNl/MOpUcL47FjD89cTXsNpRQ5J+dRoEkZC2nUB8A=;
 b=b14eSxRy/viA/8UsO4brHleZL1XoCxOa3oliA+kfGcp/kdgeFuaeenEVDgSX3gY4BT
 XwcmluPnTKDGd9aLjftK9pZJc3SmoLpjoLpHRf/ZbJt3Qa8pionrFAajEkIr8h4L8A3p
 oJIA2nKQjL5YSr8hMYmAI46mjVJ38t13MnzTST6E8+WiRFKWhe33Vuze/QcWDfxjpsEN
 YTvtWStCkgb1RGQSrtRqY9rkU0nPzhipUVkYCRuDSZRVZd61J0QKZbIm8oJUVpMy+xg/
 uJPS+eYtmAWT0wv3MHPAWqkfOEx38jFMDod3xLKK7e3CCDwEAdk0h6rfGIIAgbExPYbV
 9x0A==
X-Gm-Message-State: APjAAAXv/1pwZvzNR5B2gneM/a3rZ/yHMwVy2gMeObQVkRwhNTeQHoBH
 d/6bQ50H8vF43HbdkFSlrCCDRwQZuXL9
X-Google-Smtp-Source: APXvYqyZpns6zZIjnR+fVngc404NCxm7IL48GLQ8IfN1yH6bFrlmnLNfedySXm2fSMRJIFxKKgUvtg==
X-Received: by 2002:a17:90a:d141:: with SMTP id
 t1mr13002464pjw.103.1571429095366; 
 Fri, 18 Oct 2019 13:04:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c87a:31ae:9107:f63d])
 by smtp.gmail.com with ESMTPSA id h6sm10564646pfg.123.2019.10.18.13.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 13:04:54 -0700 (PDT)
From: Curtis Malainey <cujomalainey@chromium.org>
To: alsa-devel@alsa-project.org
Date: Fri, 18 Oct 2019 13:04:37 -0700
Message-Id: <20191018200449.141123-1-cujomalainey@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Cc: Ben Zhang <benzh@chromium.org>, Curtis Malainey <cujomalainey@chromium.org>,
 Dylan Reid <dgreid@chromium.org>
Subject: [alsa-devel] [PATCH v2 00/12] Add Samus Hotwording for RT5677
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch series adds the hotwording implementation used in the
Pixelbook on the RT5677 driver.

Known Issues:
There is a known issue where the system will fail to detect a hotword if
suspended while the stream is open. This is due to the fact that the
haswell-dsp suspends its I2S MCLK before the RT5677 suspends which
causes the writes and reads to become corrupted as a result. Any
recommendations to correct this behaviour would be appreciated.

Changes since v1:
* Addressed Mark's and Kuninori's comments
  * Adjusted DAI Links
  * Squashed related patches
  * Removed all kcontrol writes
* Addressed race condition with dapm
* Added firmware boot check
* Moved all clocking to driver API
* Moved DAPM routes that spanned drivers to machine driver

Cc: Dylan Reid <dgreid@chromium.org>
Cc: Ben Zhang <benzh@chromium.org>

Ben Zhang (8):
  ASoC: rt5677: Add a PCM device for streaming hotword via SPI
  ASoC: rt5677: Load firmware via SPI using delayed work
  ASoC: bdw-rt5677: Add a DAI link for rt5677 SPI PCM device
  ASoC: rt5677: Enable jack detect while DSP is running
  ASoC: rt5677: Add DAPM audio path for hotword stream
  ASoC: rt5677: Mark reg RT5677_PWR_ANLG2 as volatile
  ASoC: rt5677: Stop and restart DSP over suspend/resume
  ASoC: rt5677: Disable irq at suspend

Curtis Malainey (4):
  ASoC: rt5677: Allow VAD to be shut on/off at all times
  ASoC: bdw-rt5677: Turn on MCLK1 for DSP via DAPM
  ASoC: rt5677: Set ADC clock to use PLL and enable ASRC
  ASoC: rt5677: Wait for DSP to boot before loading firmware

 sound/soc/codecs/rt5677-spi.c       | 397 ++++++++++++++++++++++++
 sound/soc/codecs/rt5677-spi.h       |   1 +
 sound/soc/codecs/rt5677.c           | 447 +++++++++++++++++++++++-----
 sound/soc/codecs/rt5677.h           |  11 +-
 sound/soc/intel/boards/bdw-rt5677.c |  51 ++++
 5 files changed, 834 insertions(+), 73 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
