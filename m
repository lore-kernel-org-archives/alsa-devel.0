Return-Path: <SRS0=jhkO=NU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E5C432BE
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 17:08:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D72D60F3A
	for <alsa-devel@archiver.kernel.org>; Sun, 29 Aug 2021 17:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D72D60F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dnyon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D176416B1;
	Sun, 29 Aug 2021 19:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D176416B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630256906;
	bh=K7WOQRGdrSf+PbNjqY1YtmWTU3lNTVPtvBKbaWcq284=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VBacOfsoWCac1TYMvspHLjJ5C1Rj+WGBt2Cdy7j79IRgcYTUp/B31tX1sQ/UxvIk0
	 EIl5QjpJ2OkZquOcFjZ4A9JXhZ/CwCBKJDizCQWjM6NGhEkg/Z8C0xJvx04v5h++TH
	 Ig6Hg2Wjs1xwwyN8Gi5CenzL1RilmROqNLUvPa7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA31F80254;
	Sun, 29 Aug 2021 19:07:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E9C7F8025B; Sun, 29 Aug 2021 19:07:34 +0200 (CEST)
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01DEDF80246
 for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2021 19:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01DEDF80246
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=dnyon.com header.i=@dnyon.com
 header.b="Ue4Xpfz8"
Received: from dnyon.com (45.74.222.87.dynamic.jazztel.es [87.222.74.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by dnyon.com (Postfix) with ESMTPSA id A3C6740442;
 Sun, 29 Aug 2021 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
 t=1630256848; bh=K7WOQRGdrSf+PbNjqY1YtmWTU3lNTVPtvBKbaWcq284=;
 h=From:To:Cc:Subject:Date:From;
 b=Ue4Xpfz8jQCWWVN5n1TB79rkzw7GeTblHz3Mr4X4/4W81m1sFw8zbcuspenzoxfYS
 WjNSu00M2iSKGG+vBv7CFuNh9xvKYS46QOq7FTFpzWP2fvI6walzTC5roLkGcmdFy/
 iCh33lZJkjeepo73AscnNqYk1MdIwzZpeaVzrnL7EvQA8h+GL6rZBaxz4jFOh8lgAq
 7rinpQieKKLeX4dlDIaiWLs16JvA6IGUvMfzJUHPQgOTwsnbQQUobn1j+CADxyGAVf
 JmSgw3uuQr9S7EMXTFhjQQLlDnZWYmNA/WtteHWEIwwAxwXrTZfsyCZm/xYMAvzQa1
 dXQUn6mvRZo+Q==
From: Alejandro Tafalla <atafalla@dnyon.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org
Subject: [PATCH RESEND 0/2] Add reset-gpios handling for max98927
Date: Sun, 29 Aug 2021 19:00:15 +0200
Message-Id: <20210829170019.384632-1-atafalla@dnyon.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Alejandro Tafalla <atafalla@dnyon.com>
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

The max98927 codec on some devices (i.e. Xiaomi Mi A2 Lite phone) require
hardware-resetting the codec by driving a reset-gpio. This series add
support for it through an optional reset-gpios property.

Alejandro Tafalla (2):
  ASoC: max98927: Handle reset gpio when probing i2c
  dt-bindings: sound: max98927: Add reset-gpios optional property

 .../devicetree/bindings/sound/max9892x.txt       |  3 +++
 sound/soc/codecs/max98927.c                      | 16 ++++++++++++++++
 sound/soc/codecs/max98927.h                      |  1 +
 3 files changed, 20 insertions(+)

-- 
2.32.0

