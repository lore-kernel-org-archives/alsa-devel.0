Return-Path: <SRS0=ok5v=X6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2ABC47404
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 05:59:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599D8222C9
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 05:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KJXvIlOk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uq4kBMRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599D8222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11E8B1677;
	Sat,  5 Oct 2019 07:58:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11E8B1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570255171;
	bh=mtv84IB43OKxpv6u/ZPQbrPOk90iF0VFZFjLBxVyNWI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KJXvIlOkxeuDUZrkWjeJdXwH5STUtLWqD5b+g9CHPuTXFIgZJpEReXx/5THVgkhwA
	 ovFK6p28rJ60eJOiWGhZZ2CKP141xt2km1OeFAo3vR/Ys64dQhsxjd5c+vtI9VlQeh
	 8MyqVdXwxAMV7rvzgNViFTIhfV977zFZtE+dFtmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BCBFF800D2;
	Sat,  5 Oct 2019 07:58:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB16CF80506; Sat,  5 Oct 2019 07:58:37 +0200 (CEST)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11C5EF800D2
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2019 07:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11C5EF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="uq4kBMRi"
Received: by mail-qt1-x849.google.com with SMTP id m20so8954396qtq.16
 for <alsa-devel@alsa-project.org>; Fri, 04 Oct 2019 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=u/HhHshiebt7qdyy/0fT8eo/n7HLU5nGMpl4dQQloPE=;
 b=uq4kBMRiAoFm4f6IBiCLfwNOLhnTIDboKRnPsAqYRbLdvQClbP8TdLxQm1+MjQppIq
 hdZHLoIvxg0XxpoFN+s1dCElRZOwes4ttUoe3yjBJMQ5PCMLa4mGwpuvlYW6jRH8S3kP
 GQi0UwVzCXcjimxErBq80X1etw4ko4G7rLshAeP9/mOHK8jWHOTwfbNmoJuA3o4DmgxH
 v0Nzaoz10laVBwGzYVtDI7f8UcpPJmwGxh1VqYzfrVkSpv+6vUoxUzmy3e6BFmB41b/y
 cZFYQ4ragHp6zTKAdTjoT6cHwsP46dcFP0eFx45oN3/zN5gknYKM7rikRuzoasjAdzZ/
 AyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=u/HhHshiebt7qdyy/0fT8eo/n7HLU5nGMpl4dQQloPE=;
 b=emH2fodxf8sNBD3wB2ZvVJsU8tb4dIUeYQxGuPHUhfgBOy2DW0IBMW+UGev64I6bVo
 jVBy1280iYmRoECDTqjgzsPj/RNiOIBjNnzc3f1C5PCzQbKCD8T1lWOtf09lRE77MXTT
 7APHfw4YUeCw4yCiZgnauBft+V2F7QN+kEO3lbCesgl20KsKbQVYMYys7kzmG0pU1nNp
 /g73/I6bU3NRv95GjEJkStyiDn1YiOXJIkZpREODMHrxAQgOhHPSqOw6RqIE7ZLKAjKY
 fvu5ZPLw+cWoUqqbSwVB8/JsSUqS1djKLjsgRjcG9EGzU25T0EhDEWTWIV0vN618Y7Us
 rNFA==
X-Gm-Message-State: APjAAAVBSlmm6YkoTaj0NBj+xWkHcrICb2t9nrHg81dgivO0lXRir3gQ
 IgNz+X9eqARz0ZEK5VzB0ZD/dnmCtawo
X-Google-Smtp-Source: APXvYqwB3BWb6tkEHECO3/JQ/ejewohrwxyg4ZtcONUEqpOq6AIa0rSPEjwhOuLrLwotENvn2FvaLQAwZ+5f
X-Received: by 2002:ae9:de84:: with SMTP id
 s126mr13701003qkf.245.1570255112606; 
 Fri, 04 Oct 2019 22:58:32 -0700 (PDT)
Date: Sat,  5 Oct 2019 13:57:58 +0800
Message-Id: <20191005055808.249089-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, tzungbi@google.com,
 robh+dt@kernel.org, enric.balletbo@collabora.com, bleung@google.com,
 dgreid@google.com
Subject: [alsa-devel] [PATCH 00/10] ASoC: mediatek:
	mt8183-mt6358-ts3a227-max98357: support WoV
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

This series makes mt6358, cros_ec_codec, and mt8183-mt6358-ts3a227-max98357
support WoV (wake on voice).

The first 3 commits are some cleanups and refactors.  It looks like breaking
the existing interface.  But please be noticed that, the cros_ec_codec has
not used by any real device yet.  The refactor is very necessary to keep
the style consistent and for easier to further extend and maintain.
  platform/chrome: cros_ec: remove unused EC feature
  ASoC: cros_ec_codec: refactor I2S RX
  ASoC: cros_ec_codec: extract DMIC EC command from I2S RX

The 4th commit extends the feature offered from EC codec.
  platform/chrome: cros_ec: add common commands for EC codec

The 5th commit changes the behavior of setting and getting DMIC gains.
  ASoC: cros_ec_codec: read max DMIC gain from EC codec

The 6th and 7th commit make cros_ec_codec support WoV.
  ASoC: dt-bindings: cros_ec_codec: add SHM bindings
  ASoC: cros_ec_codec: support WoV

The 8th commit sets necessary registers on mt6358 to support WoV.
  ASoC: mediatek: mt6358: support WoV

The last 2 commit make machine driver mt8183-mt6358-ts3a227-max98357 support
WoV if ec-codec is in DTS.
  ASoC: dt-bindings: mt8183: add ec-codec
  ASoC: mediatek: mt8183: support WoV

Tzung-Bi Shih (10):
  platform/chrome: cros_ec: remove unused EC feature
  ASoC: cros_ec_codec: refactor I2S RX
  ASoC: cros_ec_codec: extract DMIC EC command from I2S RX
  platform/chrome: cros_ec: add common commands for EC codec
  ASoC: cros_ec_codec: read max DMIC gain from EC codec
  ASoC: dt-bindings: cros_ec_codec: add SHM bindings
  ASoC: cros_ec_codec: support WoV
  ASoC: mediatek: mt6358: support WoV
  ASoC: dt-bindings: mt8183: add ec-codec
  ASoC: mediatek: mt8183: support WoV

 .../bindings/sound/google,cros-ec-codec.txt   |   24 +-
 .../sound/mt8183-mt6358-ts3a227-max98357.txt  |    3 +
 drivers/platform/chrome/cros_ec_trace.c       |    5 +-
 .../linux/platform_data/cros_ec_commands.h    |  285 ++++-
 sound/soc/codecs/cros_ec_codec.c              | 1125 +++++++++++++----
 sound/soc/codecs/mt6358.c                     |  105 ++
 sound/soc/mediatek/Kconfig                    |    1 +
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   70 +-
 8 files changed, 1292 insertions(+), 326 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
