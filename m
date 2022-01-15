Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC7DC433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Jan 2022 01:25:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF4C71FBA;
	Sat, 15 Jan 2022 02:24:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF4C71FBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642209899;
	bh=/5Ua/xSkATE0MmgluOqNKOkwms8PD+hVxfOiPEfK1JQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJdgKh5Pwn5ms6kBzIbrovMk876HRUQ706WeRjlMCKtshnqCgeFoENdcC4NeJ7w4M
	 nM+h9lXuAlvOLZg9nxYWZDOkLWV4XLB3NZZ/vBvJ8v/GDGhf5asVcWzkaxfH7piohy
	 DUZ1+yut1hIlz0Bcwaj2RTqXhJq3VFMJLUc8CzKI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9D2FF80507;
	Sat, 15 Jan 2022 02:23:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 731E5F800CE; Sat, 15 Jan 2022 02:23:31 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 54B27F80141
 for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2022 02:23:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54B27F80141
X-IronPort-AV: E=Sophos;i="5.88,290,1635174000"; d="scan'208";a="107116846"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2022 10:23:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9B5B5417EAC4;
 Sat, 15 Jan 2022 10:23:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 3/5] ASoC: sh: rz-ssi: Drop ssi parameter from
 rz_ssi_stream_init()
Date: Sat, 15 Jan 2022 01:23:01 +0000
Message-Id: <20220115012303.29651-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Pavel Machek <pavel@denx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>
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

ssi parameter is unused in rz_ssi_stream_init() so just drop it.

While at it, change the return type of rz_ssi_stream_init() to void
instead of int.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2
* No change
---
 sound/soc/sh/rz-ssi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 89428945d48b..50699e94772b 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -201,9 +201,8 @@ static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 	return ret;
 }
 
-static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
-			      struct rz_ssi_stream *strm,
-			      struct snd_pcm_substream *substream)
+static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
+			       struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -219,8 +218,6 @@ static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
 
 	/* fifo init */
 	strm->fifo_sample_size = SSI_FIFO_DEPTH;
-
-	return 0;
 }
 
 static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
@@ -723,9 +720,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
 		udelay(5);
 
-		ret = rz_ssi_stream_init(ssi, strm, substream);
-		if (ret)
-			goto done;
+		rz_ssi_stream_init(strm, substream);
 
 		if (ssi->dma_rt) {
 			bool is_playback;
-- 
2.17.1

