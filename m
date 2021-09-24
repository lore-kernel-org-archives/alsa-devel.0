Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70209C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 23:13:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F5B6125F
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 23:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17F5B6125F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97B301614;
	Sat, 25 Sep 2021 01:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97B301614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632525221;
	bh=WfCSoGp6wffETXisUXm+qUL5WeZbTKs+Njeo7GHOdSc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=byn2pDPQ61xcK53U4OMZzCSU14P9mVEAtU9Yo8uBv6pxyVPy7XDGc9KuL85d9NpFO
	 1TZgMTUnZDa3ZvJzz/O9ZfdX1BazcRIk1BA7Kms2GskMb58pd2ie3G/0CQ0Ncl6o0c
	 VJH+UcEBpqj6xYFNFN0lgp8OfN20iU8vCVKFDQFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32ABAF8025D;
	Sat, 25 Sep 2021 01:12:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 564C7F802A0; Sat, 25 Sep 2021 01:12:50 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10224F8013F
 for <alsa-devel@alsa-project.org>; Sat, 25 Sep 2021 01:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10224F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="N9L52LHK"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CAB6540189; 
 Fri, 24 Sep 2021 23:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1632525162;
 bh=tN3HRU0OzmhV6dgn+LtnaYkAOlXirG8kC8RmA1sdV9Y=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=N9L52LHKq1rdOqh9YigHzUlVpJItzEVS5nvj7EoDu2CRT79tXWjXSaxFWyr/2Wwt3
 TEziT8Lr/mWxgSY6oNk0t5hw/k2jMTUEWFpiD+AHp5+a7wb/w5CYPPXiRcEDaJGBjM
 PXE7vcEAlbIP463nYQ5diD6lDiR1ZESaKMzni1wSZqJ5pe6JNPePKddYOVV84fSHR4
 ++xyD0y3oxqM9U2U1+J2aOdSAY0PJ4ZpBhoG9CWInRLbKoGalFfk1nqvo6fuo3yRzo
 b6C1Ue/bjfhEy1DefWEEriA07PhVe8GEnIbGVtIPVNyXVijyKrrR3dryJ4d+yMrN07
 3/qII+187lHFQ==
From: Colin King <colin.king@canonical.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <narmstrong@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: aiu: Fix spelling mistake "Unsupport" ->
 "Unsupported"
Date: Sat, 25 Sep 2021 00:12:42 +0100
Message-Id: <20210924231242.144692-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/meson/aiu-encoder-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/aiu-encoder-spdif.c b/sound/soc/meson/aiu-encoder-spdif.c
index de850913975f..97da60db2c4d 100644
--- a/sound/soc/meson/aiu-encoder-spdif.c
+++ b/sound/soc/meson/aiu-encoder-spdif.c
@@ -113,7 +113,7 @@ static int aiu_encoder_spdif_hw_params(struct snd_pcm_substream *substream,
 		val |= AIU_958_MISC_MODE_32BITS;
 		break;
 	default:
-		dev_err(dai->dev, "Unsupport physical width\n");
+		dev_err(dai->dev, "Unsupported physical width\n");
 		return -EINVAL;
 	}
 
-- 
2.32.0

