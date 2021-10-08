Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A825C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 09:55:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F65461038
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 09:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2F65461038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E548D1666;
	Fri,  8 Oct 2021 11:54:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E548D1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633686931;
	bh=o2cj5ufJhZE4EVVAppYfMxMbnnIwR4NTkT8/aAhTXcQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rlcQtyQt7669zJtL1lGj7lQGHH/3lVGYhoSdjRT1Zg4ac5IX7IJQ+C1PRX7qOuzNT
	 pMB5/tZIwgFaVuhydzL8/zu1+SxdQNb6YojxsXyM142etZV3G1wvrnWCKWOCbNXTdw
	 hrL2+HjBfRznXJm5Dj/VWDUJ4jQRh+6Y4UdLgu7w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EEB9F80246;
	Fri,  8 Oct 2021 11:54:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6A81F80249; Fri,  8 Oct 2021 11:54:38 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D2D1F80124
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 11:54:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D2D1F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="kgsLUxAq"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DC8C940007; 
 Fri,  8 Oct 2021 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1633686870;
 bh=tqDPxyLPKVPs4yYbJQLMZF/t1CIh6U8zbhA/lGXkiCY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=kgsLUxAqCevBQM563UQkgq9iuUw3Cw40WCLce7KhIz3s2zgWPuTXia2G0HKjchrWM
 42Mjy9/1QZPAzQWzzqs+Qgv/UGEbyDxhD1IaqWZbg+SKsE3WLWQU2CxE1mOxbiqu90
 SRUC3vFiOR8uY+bQAJbKoIyqJOLy5m8bn/hTXBOHYTITfVVqiBt430xWFvQHuDZCGG
 o9pqGu/X4cVHU1XqHNb9WouSEeAXLntit7xd2vIWlIjA8Dgr6E62KPf1757EmdEW8Z
 5dFpVpSPxVpOlvXvoC65mRjAj00MgHQ4cQY53ZiQ+Waf7QxiWIkzQAsa8r+su63cPC
 hoWf58UOE1IOQ==
From: Colin King <colin.king@canonical.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2][next] ASoC: rockchip: i2s-tdm: Remove call to
 rockchip_i2s_ch_to_io
Date: Fri,  8 Oct 2021 10:54:29 +0100
Message-Id: <20211008095430.62680-1-colin.king@canonical.com>
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

The call to rockchip_i2s_ch_to_io is only useful for its return
value which is not being used. The function call also has no
side effects, the call is effectively useless and can be removed.

Addresses-Coverity: ("Useless call")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index b08b15071993..cc5a2f9d3948 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -848,8 +848,6 @@ static int rockchip_i2s_io_multiplex(struct snd_pcm_substream *substream,
 				to_ch_num(val), usable_chs);
 			return -EINVAL;
 		}
-
-		rockchip_i2s_ch_to_io(val, false);
 	}
 
 	val <<= i2s_tdm->soc_data->grf_shift;
-- 
2.32.0

