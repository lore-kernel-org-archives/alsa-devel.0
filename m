Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1507C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:59:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F93420881
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hHg+rPB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F93420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B5EA84C;
	Mon,  2 Dec 2019 16:58:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B5EA84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575302375;
	bh=97c20ZSjl090WeL/WBrieksiek9dMsX88txZzeds9O0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hHg+rPB0PsXgBbg9FfeKaKKACSn+JXQj0FdxDkZPO5RkgvYIp6CPzDIKgENjac1SL
	 MsECz6cKlxO6POtv5YF/Z1kVWHG6Turr9MBuVCDq8yT5HHx8YkNTKNBOeEYcrdA/WT
	 tI+JkhQK209n0VrbkA8jXf9etdNXjo5K8Zp3avio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5C12F801D9;
	Mon,  2 Dec 2019 16:58:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE9C1F80214; Mon,  2 Dec 2019 16:58:42 +0100 (CET)
Received: from albert.telenet-ops.be (albert.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:1a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11D53F80090
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 16:58:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11D53F80090
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id Z3yb2100f5USYZQ063ycAD; Mon, 02 Dec 2019 16:58:38 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1ibo5r-0007jA-Rm; Mon, 02 Dec 2019 16:58:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1ibo5r-0005sx-Oc; Mon, 02 Dec 2019 16:58:35 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Date: Mon,  2 Dec 2019 16:58:34 +0100
Message-Id: <20191202155834.22582-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [alsa-devel] [PATCH] ASoC: rsnd: Calculate DALIGN inversion at
	run-time
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

There is no need to store the inverted DALIGN values in the table, as
they can easily be calculated at run-time.  This also protects against
the introduction of inconsistencies between normal and inverted values
by a future table modification.

Reorder the two subexpressions in the AND check, to perform the least
expensive check first.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

Interestingly, this decreases code size on arm64, but increases on arm32
(both gcc version 7.4.0 (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)).

arm32:

       text	   data	    bss	    dec	    hex	filename
      16186	    276	     84	  16546	   40a2	sound/soc/sh/rcar/core.o.orig
      16194	    276	     84	  16554	   40aa	sound/soc/sh/rcar/core.o

arm64:

       text	   data	    bss	    dec	    hex	filename
      17426	    392	    104	  17922	   4602	sound/soc/sh/rcar/core.o.orig
      17414	    392	    104	  17910	   45f6	sound/soc/sh/rcar/core.o
---
 sound/soc/sh/rcar/core.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 399dc6e9bde5b042..d20f03dfdee66643 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -376,20 +376,15 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
  */
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
-	static const u32 dalign_values[8][2] = {
-		{0x76543210, 0x67452301},
-		{0x00000032, 0x00000023},
-		{0x00007654, 0x00006745},
-		{0x00000076, 0x00000067},
-		{0xfedcba98, 0xefcdab89},
-		{0x000000ba, 0x000000ab},
-		{0x0000fedc, 0x0000efcd},
-		{0x000000fe, 0x000000ef},
+	static const u32 dalign_values[8] = {
+		0x76543210, 0x00000032, 0x00007654, 0x00000076,
+		0xfedcba98, 0x000000ba, 0x0000fedc, 0x000000fe,
 	};
-	int id = 0, inv;
+	int id = 0;
 	struct rsnd_mod *ssiu = rsnd_io_to_mod_ssiu(io);
 	struct rsnd_mod *target;
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	u32 dalign;
 
 	/*
 	 * *Hardware* L/R and *Software* L/R are inverted for 16bit data.
@@ -425,15 +420,15 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	if (mod == ssiu)
 		id = rsnd_mod_id_sub(mod);
 
-	/* Non target mod or non 16bit needs normal DALIGN */
-	if ((snd_pcm_format_width(runtime->format) != 16) ||
-	    (mod != target))
-		inv = 0;
-	/* Target mod needs inverted DALIGN when 16bit */
-	else
-		inv = 1;
+	dalign = dalign_values[id];
+
+	if (mod == target && snd_pcm_format_width(runtime->format) == 16) {
+		/* Target mod needs inverted DALIGN when 16bit */
+		dalign = (dalign & 0xf0f0f0f0) >> 4 |
+			 (dalign & 0x0f0f0f0f) << 4;
+	}
 
-	return dalign_values[id][inv];
+	return dalign;
 }
 
 u32 rsnd_get_busif_shift(struct rsnd_dai_stream *io, struct rsnd_mod *mod)
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
