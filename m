Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02011C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 17:21:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A75C6143F
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A75C6143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5122A1764;
	Fri, 14 May 2021 19:20:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5122A1764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621012858;
	bh=zUBRBbGs/7fGYV3zd6jkLXspieDE8QOcW5MB0XffSM8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OenqWiLVnFVDu4GhwoPhTyDAyvv0Vwj5d07R2cuDDos++Xambrx6svXb1jbBZZ5xd
	 iM3gdPrqdYvfH0vEXNnaPQmshNWOGEtnTBCxpRpPg3iPoq02iOcQhFnpcr2+qb10VC
	 8bZqKN3Pjxbr9phGHnUAP/9Kk7RII6LXDKqaW0Yc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8949F8012A;
	Fri, 14 May 2021 19:20:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B7F7F8026B; Fri, 14 May 2021 19:20:06 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD980F8012A
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 19:19:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD980F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Dwh3atl/"
Received: by mail-ot1-x32b.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so5911829otp.4
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xbWNyumSaakRF5+I6Q4pxoTvTeel3gGdC/C0gEVAsbs=;
 b=Dwh3atl/PTSoQ9H/H6a4cNIEThJZNPerQ/tXcinbE0bdgxFqsgtR4mDIVyHWQfpqkY
 xyYiaAxBFmQpDsRfiAgy5/Gojr+l9GFDoLHGrVtts6zQPc361s8FuuW8vRtSPq/d5Gbb
 wXFleeaW6uF49icg9V0zwivLUghj1VBU08G+iXJ2w2sG1/XOWtnEnlAk0pLlR3hljbA1
 lX84pynsasB32TLHxeOQSJ/eBG1DT0ZchbXlMpuoi5GzN4EvN+Z8Hu5FPprMArWzWvS7
 01Q0FVdxIcXacYkRo+0THJxQfkPjHJT6bw4Yl01DQMI0ed6BtkkJYcBitt+XRtd9xQWU
 rw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xbWNyumSaakRF5+I6Q4pxoTvTeel3gGdC/C0gEVAsbs=;
 b=pl2/ae8Q2lvSbSi92Utx4bOyMQokQ+fci+GwtKsaXBuegV77J4majySgvcU9fHLLDQ
 TRXmMLQu4HlZHcM1cBG0varNlqecznpFX4IDjceXrzUcjAYaKTLjfOT8RRlOA50Zq76F
 n8HB7PSsnAS4gABxG7msqedJ6KXrp1CSg86ua0xlvZZGxbzM9BEbsh3PTHKFFgzWWIS9
 sRTUl7Rzt2Hg+YpLYrr/e9Un78XWUHTuf0Zh2G8fghw9TBhup8sf5tiqdjGdqpPLdPq6
 hd4xR7cT63kqLzqLXTQA3PlAS+Nz0glemBCTq8GGtOPxwd7PFdqLsULj7FWjpalowmGR
 5lHA==
X-Gm-Message-State: AOAM530V+UTEAgUOVapfvxoBu1xNJj3ro3tW24fXZHxLAd9U+fsgJQcQ
 4erOKWF+sP1h/geZkndmuqFmM6HXkT4=
X-Google-Smtp-Source: ABdhPJz8lMS4CDvotbsdOQuc1xfRx11VPyOBYz3m8DpVxMvPMreE9czwFp9QfdXU1nZqX/SyzbqqNQ==
X-Received: by 2002:a9d:5a10:: with SMTP id v16mr40663546oth.187.1621012795795; 
 Fri, 14 May 2021 10:19:55 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com.
 [76.183.134.35])
 by smtp.gmail.com with ESMTPSA id x14sm1302547oic.3.2021.05.14.10.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 10:19:55 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v10 0/4] ASoC: codecs: add rk817 support
Date: Fri, 14 May 2021 12:19:36 -0500
Message-Id: <20210514171940.20831-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, heiko@sntech.de,
 devicetree@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, broonie@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 lee.jones@linaro.org, maccraft123mc@gmail.com
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Chris Morgan <macromorgan@hotmail.com>

This series is to add support for the Rockchip rk817 audio codec which
is present in all Rockchip rk817 MFD chips.

Changes in v10:
 - Correct order of test/ack/signed-off to chronological order.
 - Removed ifdef from mfd driver keep cell from being added when the
   codec was not to be built.
 - Changed codec DT parsing messages from error to debug to prevent
   errors in dmesg log in the rare but valid case a user has the rk817
   PMIC but does not use the codec.
Changes in v9:
 - Add cover letter.
 - Remove documentation for interrupt parent per Rob Herring's request.
 - Remove unused MODULE_DEVICE_TABLE to fix a bug identified by kernel test
   robot.
Changes in v8:
 - Added additional documentation for missing properties of
   #sound-dai-cells, interrupt-parent, and wakeup-source for mfd
   documentation.
 - Corrected order of elements descriptions in device tree documentation.
 - Changed name of "mic-in-differential" to
   "rockchip,mic-in-differential".
 - Changed name of sound card from "rockchip,rk817-codec" to "Analog".
 - Removed unused resets and reset-names from the i2s1_2ch node.
Changes in v7:
 - Removed ifdef around register definitions for MFD.
 - Replaced codec documentation with updates to MFD documentation.
 - Reordered elements in example to comply with upstream rules.
 - Added binding update back for Odroid Go Advance as requested.
 - Submitting patches from gmail now.
Changes in v6:
 - Included additional project maintainers for correct subsystems.
 - Removed unneeded compatible from DT documentation.
 - Removed binding update for Odroid Go Advance (will do in separate
   series).
Changes in v5:
 - Move register definitions from rk817_codec.h to main rk808.h register
   definitions.
 - Add volatile register for codec bits.
 - Add default values for codec bits.
 - Removed of_compatible from mtd driver (not necessary).
 - Switched to using parent regmap instead of private regmap for codec.
Changes in v4:
 - Created set_pll() call.
 - Created user visible gain control in mic.
 - Check for return value of clk_prepare_enable().
 - Removed duplicate clk_prepare_enable().
 - Split DT documentation to separate commit.
Changes in v3:
 - Use DAPM macros to set audio path.
 - Updated devicetree binding (as every rk817 has this codec chip).
 - Changed documentation to yaml format.
 - Split MFD changes to separate commit.
Changes in v2:
 - Fixed audio path registers to solve some bugs.

Chris Morgan (4):
  mfd: Add Rockchip rk817 audio CODEC support
  ASoC: Add Rockchip rk817 audio CODEC support
  dt-bindings: Add Rockchip rk817 audio CODEC support
  arm64: dts: rockchip: add rk817 codec to Odroid Go

 .../devicetree/bindings/mfd/rk808.txt         | 186 ++++++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  36 +-
 drivers/mfd/rk808.c                           |  83 +++
 include/linux/mfd/rk808.h                     |  81 +++
 sound/soc/codecs/Kconfig                      |   6 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/rk817_codec.c                | 558 ++++++++++++++++++
 7 files changed, 950 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/rk817_codec.c

-- 
2.25.1

