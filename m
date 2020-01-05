Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545ECC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:58:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AB521582
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NGeukjTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AB521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E292A1755;
	Sun,  5 Jan 2020 15:57:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E292A1755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578236316;
	bh=xwqN5Z4Mgu5ClbFxcVgMxPo+JTtx4L5+07tJjcNSoQ0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NGeukjTd4LWwDP+cablqohJOs+HImWCEqTMeaE8y8M9hRGmgJB/0HTlRmYlCugeVP
	 Otdi1oWn3P33rHmjyc53XG+5B1W9jzuJeVg+QhRwWGfI0xeAsZwwq8xTuT9yLy+WXg
	 guFfP/bb3Dc58a5U95h1Qq/ALy5cL5Xj+5fCQBCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F696F80367;
	Sun,  5 Jan 2020 15:49:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98D34F8032A; Sun,  5 Jan 2020 15:48:56 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BC97F80116
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BC97F80116
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A77EAB22A
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:35 +0100
Message-Id: <20200105144823.29547-21-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 20/68] ALSA: rme9652: More constifications
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

Apply const prefix to the channel map tables.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/rme9652.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 2cb5b03f84d3..c20e590eb570 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -229,7 +229,7 @@ struct snd_rme9652 {
 	int last_spdif_sample_rate;	/* so that we can catch externally ... */
 	int last_adat_sample_rate;	/* ... induced rate changes            */
 
-        char *channel_map;
+	const char *channel_map;
 
 	struct snd_card *card;
 	struct snd_pcm *pcm;
@@ -246,12 +246,12 @@ struct snd_rme9652 {
    where the data for that channel can be read/written from/to.
 */
 
-static char channel_map_9652_ss[26] = {
+static const char channel_map_9652_ss[26] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
 	18, 19, 20, 21, 22, 23, 24, 25
 };
 
-static char channel_map_9636_ss[26] = {
+static const char channel_map_9636_ss[26] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
 	/* channels 16 and 17 are S/PDIF */
 	24, 25,
@@ -259,7 +259,7 @@ static char channel_map_9636_ss[26] = {
 	-1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static char channel_map_9652_ds[26] = {
+static const char channel_map_9652_ds[26] = {
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,
 	/* channels 12 and 13 are S/PDIF */
@@ -268,7 +268,7 @@ static char channel_map_9652_ds[26] = {
 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static char channel_map_9636_ds[26] = {
+static const char channel_map_9636_ds[26] = {
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15,
 	/* channels 8 and 9 are S/PDIF */
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
