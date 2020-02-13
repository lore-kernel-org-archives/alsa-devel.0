Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE33C3B18C
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:54:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E301724676
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lBUn4Eu7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LYTr/jwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E301724676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EE8516B3;
	Thu, 13 Feb 2020 16:53:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EE8516B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581609238;
	bh=Xpp+4zIlhiVOGj+65znIof9SJ2On9dUa11/DIG+2LL8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lBUn4Eu7QuqUMtoTw1lWX+A2q22c4v+qWKPShs0Sdv+8tCy63zb3v2D8fxjFX54Vt
	 H0/y/UuiEwlRBx1Sn4VcoJMgUK1Ei2r3NmKGRFuCGQrvrnr7SnH9YCCS76J3nV6NbV
	 dqq1bZxidpcOoJYcz07XUKQY0bB/EEDvkcN6fM8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9064DF80260;
	Thu, 13 Feb 2020 16:52:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80586F80146; Thu, 13 Feb 2020 16:52:12 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DEB9F800F0
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 16:52:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DEB9F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="LYTr/jwn"
Received: by mail-wr1-x441.google.com with SMTP id g3so7274245wrs.12
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aB1AiCkdQEWl25o0CFyQmEuSLs3mwyleNLQ7q44t8HY=;
 b=LYTr/jwnIP7xB41uk/g/SVYjXm/Nywl7CqihGSb6gmVFQuEoDKE+M6yeLtXBuxzSDV
 WSSiblX+7cKEZrMWY2arxWYNZs2uanjtjOd+R/yUTEMfW9J33ZT633LPckPXELjES10Y
 Aw8ZBK7NcNiN9jxHEIKAUsv3sAXzaBPkttp4Zf6trbnjHLj5fnXmyXOrUZL45qj2ssGU
 GnuX/g7Hhi6cCKYgZwWfl0kXt6jC7LA9LBGTwFzOU3OSPGWRVbd3/jvNcy2c28hqmfKB
 nNEVuHcu1cXqvVGTIH5fetzbCx7zyvwiZMeRE4ET5ZeNlolaqQALDjFF+9l21K1IDFee
 UTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aB1AiCkdQEWl25o0CFyQmEuSLs3mwyleNLQ7q44t8HY=;
 b=LAd8Xptiz4mAGVHGR/huXXlMwbJdaR/y7lkLNR5xWBxYwLzR/AUZggoO7jApxnKa/T
 yyjNIqPMzbKYGihH8sjzygSxQJtDj0OPU0d3XZcSB/cxYz6JoZxdoY6XopIKOn7ct/Wv
 dM+6zEYcDztsftIpC3KUrDQ1/l7WbCzv7UGWbNISK6WxppW2/www3B+pzYKhlHJKdQ+T
 U+TkYF010+sBTzSGXsbTCIyKMkuXYZ1kES0pbAs/VLneDTHxZ480E17pQNF0YGwN4+8M
 FXZ8oLcP1OAIH0ipyhueU1O7cG7zzvpn4xvu0ahBYHPi3yZ0S99XlLe8kkxJrnrIbjqs
 bIqg==
X-Gm-Message-State: APjAAAWUp8kiioo4MUfoWMyAFREG23XB/+4tN4KUffgWw0NXrU/Oi+0v
 zYrc2OlM014bgTgZe6uOP4SoYw==
X-Google-Smtp-Source: APXvYqyEvLneyxVeHuI/0pBQCYZi5+WLlVqFWpfGuTvBL5p6xmOWK7iqZ4/PQzBDgirZhGC884Aaew==
X-Received: by 2002:adf:f850:: with SMTP id d16mr21763639wrq.161.1581609128618; 
 Thu, 13 Feb 2020 07:52:08 -0800 (PST)
Received: from starbuck.baylibre.local
 (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id e1sm3319814wrt.84.2020.02.13.07.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 07:52:07 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Date: Thu, 13 Feb 2020 16:51:51 +0100
Message-Id: <20200213155159.3235792-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155159.3235792-1-jbrunet@baylibre.com>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: [alsa-devel] [PATCH 1/9] ASoC: core: allow a dt node to provide
	several components
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

At the moment, querying the dai_name will stop of the first component
matching the dt node. This does not allow a device (single dt node) to
provide several ASoC components which could then be used through DT.

This change let the search go on if the xlate function of the component
returns an error, giving the possibility to another component to match
and return the dai_name.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 068d809c349a..03b87427faa7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3102,6 +3102,14 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			*dai_name = dai->driver->name;
 			if (!*dai_name)
 				*dai_name = pos->name;
+		} else if (ret) {
+			/*
+			 * if another error than ENOTSUPP is returned go on and
+			 * check if another component is provided with the same
+			 * node. This may happen if a device provides several
+			 * components
+			 */
+			continue;
 		}
 
 		break;
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
