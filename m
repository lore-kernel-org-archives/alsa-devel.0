Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7464DC2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:02:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC80E20857
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SQ/1SkB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC80E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cetitec.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 542A3167B;
	Wed, 15 Apr 2020 17:01:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 542A3167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586962920;
	bh=/xDqnpy1jBBhwyXDvNNz7csMidna8+HGlQ16lUcxan8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SQ/1SkB/SmSd2DWYJAm1+j56KyYzDBSFzJVWsevx/4iMwPQxQGcyNhVNcrOrvDuSe
	 buVHnQCb5YVzklfvPYa2grP91nVkap5D3iNrrLYKpwqysTyM0UW2rnkbYImdF0pMdL
	 GwDY1YXxXilTYokbUJ4LjE1+Xtz7StJyYEkc6cCQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8B67F802DB;
	Wed, 15 Apr 2020 16:58:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C94FF80245; Wed, 15 Apr 2020 16:11:06 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A9ACF80124
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 16:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A9ACF80124
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MW9zm-1jmSvh2yJ0-00XeCD; Wed, 15 Apr 2020 16:10:43 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
 by mail.cetitecgmbh.com (Postfix) with ESMTP id 13B9E650EE0;
 Wed, 15 Apr 2020 14:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
 by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com
 [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iaMgQKlB-XP9; Wed, 15 Apr 2020 16:10:42 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
 by mail.cetitecgmbh.com (Postfix) with ESMTPS id BABD964C0D9;
 Wed, 15 Apr 2020 16:10:42 +0200 (CEST)
Received: from pflmmbl.corp.cetitec.com (10.8.5.60) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Apr 2020 16:10:42 +0200
From: Matthias Blankertz <matthias.blankertz@cetitec.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: rsnd: Fix HDMI channel mapping for multi-SSI mode
Date: Wed, 15 Apr 2020 16:10:17 +0200
Message-ID: <20200415141017.384017-3-matthias.blankertz@cetitec.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415141017.384017-1-matthias.blankertz@cetitec.com>
References: <20200415141017.384017-1-matthias.blankertz@cetitec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.5.60]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536B647460
X-Provags-ID: V03:K1:0bkCn+Y0mevlv5VttZgpahUL4dKGYZZLQ4y1vvto+7mMavfUh+o
 8JGMv4vZZjzQNhUrBFQ1NJ5bqdFYSn9yLfj6IZYnF4K8i4qGsq0671JsWt8ZgMT0qAUxb4z
 iUw86CuhTpzSWPug0kC7Q0uEs8W+bPnw8jGw4WrtSfdEmcfiMleogPsFKNQ4hDl/yXLkkxr
 6BjIqXo2hOtKSu7et7mCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hIseBVQO+QY=:5enC21lnRILGCyitLuxCKO
 nrxFYTneYV5nnsqfjD3XwMp6PxensbaQmXS+TRUj+DDZx1mNUZq79Y1fvHyoKSbP2m19FnEHP
 6zXUVDRsQqEGYacWsUfhH23Q7c0NvdrOqXt8rxaw2abJyCuk0lPAC/47lXBeUUoM9zjKs25FJ
 upZM8ldpICdQ016k6mxBhkMfhRUZTWvo8bLbLJOHaHDzatN+07BmMG9y51JUNZjuJGJINfO09
 Ma7hFf7tICJGVnGmuRJ2XjCku60J5xTvMrLJKALi2ibsdi5FQxSoWTJJf9Jm/QRCllWdOpWsg
 gWqGHgQ7+yLhbUBbwy9XK/RjsHd//91Y4hF25AYDqGt3P3CfdJBmO38Nf7Yz5HQLEyfmwUvCP
 NDNgRDPMKN8yLkusWQ8X1V3Y1VaUUJyYMB4a1FbVwgHf9j69k2DeFqwQmsrJGNlcLOJZOJGVz
 CX10xmcGqciw2n4Bne85zsNnbSS7cHXsywZMswGEfjtvEK4JI5Y2XNk1VVkPfxRQozW1eTLwD
 HT9w9yKiaKY45UMgLyeMACxRV/TXSLS4I1kKFUNeKpXGtREm9er+DyI1WXnPHQQVB84EBS4tI
 iGjqCsI8tzkhhx8OCi2HF1vuMz7BM9bwqiedyDgVH2lAPCpP+yFrwPFU4AK5PWkyJrTakQCYD
 LUVwmgahT4MguqYCGOu8QRxrob8UB3E+VFsY4uIGtet+W7FQTZ7lJpp41fvQxTUMgHuY1z6b8
 WhP3lng9zG6PIK2bvE37kDlTc+Y24oBDyKCYMTW5vb8obo4IYUvw7amdYKqaVO9a76pHDO15J
 v8xKATPopjrCRDaQo+CsP3Fwla3O5cdcA3WeikuDxsg1qD4oWww7aKv/KLuEVnhG2Bn6bCuI1
 1Ncz9Tm+FGLjw5Ke8AMg==
X-Mailman-Approved-At: Wed, 15 Apr 2020 16:57:55 +0200
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-renesas-soc@vger.kernel.org
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

The HDMI?_SEL register maps up to four stereo SSI data lanes onto the
sdata[0..3] inputs of the HDMI output block. The upper half of the
register contains four blocks of 4 bits, with the most significant
controlling the sdata3 line and the least significant the sdata0 line.

The shift calculation has an off-by-one error, causing the parent SSI to
be mapped to sdata3, the first multi-SSI child to sdata0 and so forth.
As the parent SSI transmits the stereo L/R channels, and the HDMI core
expects it on the sdata0 line, this causes no audio to be output when
playing stereo audio on a multichannel capable HDMI out, and
multichannel audio has permutated channels.

Fix the shift calculation to map the parent SSI to sdata0, the first
child to sdata1 etc.

Signed-off-by: Matthias Blankertz <matthias.blankertz@cetitec.com>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index f35d88211887..9c7c3e7539c9 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -221,7 +221,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			i;
 
 		for_each_rsnd_mod_array(i, pos, io, rsnd_ssi_array) {
-			shift	= (i * 4) + 16;
+			shift	= (i * 4) + 20;
 			val	= (val & ~(0xF << shift)) |
 				rsnd_mod_id(pos) << shift;
 		}
-- 
2.26.0

