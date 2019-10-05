Return-Path: <SRS0=ok5v=X6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D49C47404
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:23:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293F6222C8
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PzIDiFfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293F6222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A42331679;
	Sat,  5 Oct 2019 23:22:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A42331679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570310583;
	bh=8Ki7Bvsa/R8Vp6tCNrnk/CvYlNhzgVYo5Trm/EVCtQ0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PzIDiFfm5Di5DVywagpU+bwkP08NQVBBdVWGoxU02UrpuE2HVUiLHscKkDHllari+
	 6dNPfk5o2+PldfNoM6V8UskgDlq8pk9yClVrci+oITWqfFqf3uO8d1EJ9bRYzSvZdj
	 Nu5ritXuCEX4tub9NWqmtR4mMaiwdVF1bXTCrdSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30A7AF800DE;
	Sat,  5 Oct 2019 23:22:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B56CF80506; Sat,  5 Oct 2019 23:22:11 +0200 (CEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 959A9F800DE
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2019 23:22:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 959A9F800DE
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1565A3082E10;
 Sat,  5 Oct 2019 21:22:06 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-21.ams2.redhat.com
 [10.36.116.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB5245D717;
 Sat,  5 Oct 2019 21:22:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Date: Sat,  5 Oct 2019 23:22:02 +0200
Message-Id: <20191005212202.5206-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 05 Oct 2019 21:22:06 +0000 (UTC)
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
Subject: [alsa-devel] [PATCH] ASoC: core: Fix pcm code debugfs error
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

We can have 2 dcpm-s with the same backend and frontend name
(capture + playback pair), this causes the following debugfs error
on Intel Bay Trail systems:

[  298.969049] debugfs: Directory 'SSP2-Codec' with parent 'Baytrail Audio Port' already present!

This commit adds a ":playback" or ":capture" postfix to the debugfs dir
name fixing this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/soc-pcm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e163dde5eab1..2e723012eb52 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1146,6 +1146,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 {
 	struct snd_soc_dpcm *dpcm;
 	unsigned long flags;
+	char *name;
 
 	/* only add new dpcms */
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -1171,9 +1172,15 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "<-" : "->", be->dai_link->name);
 
 #ifdef CONFIG_DEBUG_FS
-	dpcm->debugfs_state = debugfs_create_dir(be->dai_link->name,
-						 fe->debugfs_dpcm_root);
-	debugfs_create_u32("state", 0644, dpcm->debugfs_state, &dpcm->state);
+	name = kasprintf(GFP_KERNEL, "%s:%s", be->dai_link->name,
+			 stream ? "capture" : "playback");
+	if (name) {
+		dpcm->debugfs_state = debugfs_create_dir(name,
+							 fe->debugfs_dpcm_root);
+		debugfs_create_u32("state", 0644, dpcm->debugfs_state,
+				   &dpcm->state);
+		kfree(name);
+	}
 #endif
 	return 1;
 }
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
