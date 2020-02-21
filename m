Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A0C35646
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:37:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E2F208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P3RVQl2f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lzzPLOpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E2F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FFF016B1;
	Fri, 21 Feb 2020 16:36:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FFF016B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582299430;
	bh=e4DPUsEu13h0dvS3e2EZa0sKYoncHQSryomLR1+qziw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P3RVQl2f6c5NSkQDDXESbXx94Dm/wv4QdbkfclyYPYps7ORCTgciNNnpTXX/oVczA
	 m3im4gT5Yajt+qjwYQPYwsI7gKc73Lp51R6iVYE2dG3lT/gS4b4AFxqxYEs8leMKN7
	 M2JS4+y+yum7HJ6N7kuU5Sch4fZV2lY8VceygqJ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3BD1F8025F;
	Fri, 21 Feb 2020 16:36:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4505EF80273; Fri, 21 Feb 2020 16:36:18 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2588FF8011D
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 16:36:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2588FF8011D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="lzzPLOpa"
Received: by mail-wm1-x342.google.com with SMTP id n3so2226743wmk.4
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UNHEwFigMTNc7YIRkUZl+5v4Xtz4VgLarV7EC/Mxw3I=;
 b=lzzPLOpa00IdY058idG1naAWzavEyCoj9ZAwXmLXwzaop7ZYtD6FCA7/Tf+u9wizE2
 +QxpIzWLnPu+dVn5KZNt1nAGYXhZ4ztaqy8mL/My88k0srIG6rRqr0alTBwdFVXMNmuH
 vEwKcvHsq8xwJTW5yyOZ+9QZ58aW+16RkHwKPgNUTU+oMh3S9hjGqkcB+mV1w6Cv3BZT
 8vT8pg8d6Y2vduJCtbT3ZWNlw5adXT1EyCNVG9oXVLxSmlsgFSnrfR5KWSK92AtNmzEn
 qIo4lSIdYXBLXURdlh6n41O0Q8QD8BPrtCNl/3BW0RmY9seoAerFYelvoS3oFAfpFOa+
 Rk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UNHEwFigMTNc7YIRkUZl+5v4Xtz4VgLarV7EC/Mxw3I=;
 b=ShSwHSFmbke0bHEhSGRQv5EpusbHaknZlKolFugMEW3InseeGoh4yWX8Zbjg7EDKG2
 IK00BTNAkf6Ang3pSExH5j+EGOJOEGUqwGBcs6uSLZxT6f/PPw5Tza/68tVbGuFXjZMp
 /GoBs04pVjcYkc+qS5/l8/aZhOFq9B9cParMbiJAW/t/SUqi0JdcH1pDspYhOv0uHNG+
 aVJHyGpyMHCtksZX3CYqcfmzGMnUCp0pQwMrVzWLyy+YNFNoB86MSYI6QHnTZ7zSweSg
 kAAbhZEiEkWJeMHHsF9BdXt2K8ZnHGTbTvQgZ54urAsE5xAhH7jvx1SotdI4PfmcGYA6
 qZsQ==
X-Gm-Message-State: APjAAAWCSx4GzdC3MrX/ORp5LXKWFEeRpnxvbfySUJle+AcsXPtqIXpo
 EciLqehCoX+HlIyQwSt1zgY+Cg==
X-Google-Smtp-Source: APXvYqyCqkZR3zDNG4VAxXvdw9Zekulra1RORCfv3lpKLj9dzld+yh6yJQE1+skfazo6TA4dUBZmJQ==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr4286552wmi.45.1582299374128;
 Fri, 21 Feb 2020 07:36:14 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id z25sm4198782wmf.14.2020.02.21.07.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 07:36:13 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 0/3] ASoC: meson: g12a: add internal audio DAC support
Date: Fri, 21 Feb 2020 16:36:04 +0100
Message-Id: <20200221153607.1585499-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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

Like the gxl, the Amlogic g12a and sm1 SoC families have a t9015 internal
audio DAC. On these more recent SoCs, any of the 3 TDM outputs can be
routed to the internal DAC. This routing is done by a small glue device
called 'toacodec'. This patchset adds support for it.

This was tested on the amlogic reference design g12a-u200.

Changes since v1 [0]:
 * Fixup patch 2 which was left in an intermediate state
   after rebasing, missing part of the changes.
   Thanks to Sergey Bolshakov for reporting it.

[0]: https://lore.kernel.org/r/20200221122242.1500093-1-jbrunet@baylibre.com

Jerome Brunet (3):
  ASoC: meson: g12a: add toacodec dt-binding documentation
  ASoC: meson: g12a: add internal DAC glue driver
  ASoC: meson: axg-card: add toacodec support

 .../bindings/sound/amlogic,g12a-toacodec.yaml |  51 ++++
 .../dt-bindings/sound/meson-g12a-toacodec.h   |  10 +
 sound/soc/meson/Kconfig                       |   9 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-card.c                    |   3 +-
 sound/soc/meson/g12a-toacodec.c               | 252 ++++++++++++++++++
 6 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
 create mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
 create mode 100644 sound/soc/meson/g12a-toacodec.c

-- 
2.24.1

