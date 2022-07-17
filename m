Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D416CC43334
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jul 2022 07:23:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6553B18C4;
	Sun, 17 Jul 2022 09:22:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6553B18C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658042610;
	bh=Zay9uSrH/KNgMzkoiqTNi4ZkdePthfHoTkFMqn/PI2Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pUIPPphKqBWg2cSuHKM4KEg8wa1u1BaJd+aylGsKkKGuoIV4Zzg0DwYDIIRoBpd8R
	 6+0kXhjYvLXN2YP5seiUkPKR5z22MwJfs/zz1FU82kkrj8Tb2NKDArGIuxjZazZ7mU
	 hApo/uqztNDtWNyelmsaCLM5N0dS3C2hpHjtXWVs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE437F8012A;
	Sun, 17 Jul 2022 09:22:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B008CF8015B; Sun, 17 Jul 2022 09:22:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1FDDF800FB
 for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2022 09:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1FDDF800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="zdaJqF28"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="DZMWDza0"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 470711F983;
 Sun, 17 Jul 2022 07:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658042550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8IMq1CWm7Sl3KTzbDJnletc4VqKqos7Te6QhNY4uB1w=;
 b=zdaJqF28wMEWWz3qYPoS0cs4Nyq0tANXlwifE+UylUA0KXh0IiZKnsNpjzvpUvKXj659MF
 HhvK1/xiwXi2LwKY8EmgQqzrDy9CC56KzlJooWn2xV5XYcjugE2yhyPHKuKz6RcDnqJRm5
 IPGDtixcWJysDE/blr3fHibaTlcHSKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658042550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8IMq1CWm7Sl3KTzbDJnletc4VqKqos7Te6QhNY4uB1w=;
 b=DZMWDza07jsIQysMQfGILGTZjkIm/X10xAQNR+Edih+VwGpvewef2q9lUMIvkeoeMQdeFn
 SJpslcVRJnoNF4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2035813A89;
 Sun, 17 Jul 2022 07:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GlMRB7a402LfbwAAMHmgww
 (envelope-from <tiwai@suse.de>); Sun, 17 Jul 2022 07:22:30 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: DPCM: Don't pick up BE without substream
Date: Sun, 17 Jul 2022 09:22:27 +0200
Message-Id: <20220717072227.6716-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alex Natalsson <harmoniesworlds@gmail.com>,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

When DPCM tries to add valid BE connections at dpcm_add_paths(), it
doesn't check whether the picked BE actually supports for the given
stream direction.  Due to that, when an asymmetric BE stream is
present, it picks up wrongly and this may result in a NULL dereference
at a later point where the code assumes the existence of a
corresponding BE substream.

This patch adds the check for the presence of the substream for the
target BE for avoiding the problem above.

Note that we have already some fix for non-existing BE substream at
commit 6246f283d5e0 ("ASoC: dpcm: skip missing substream while
applying symmetry").  But the code path we've hit recently is rather
happening before the previous fix.  So this patch tries to fix at
picking up a BE instead of parsing BE lists.

Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
Reported-by: Alex Natalsson <harmoniesworlds@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/CADs9LoPZH_D+eJ9qjTxSLE5jGyhKsjMN7g2NighZ16biVxsyKw@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a827cc3c158a..0c1de5624842 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1318,6 +1318,9 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		if (!be->dai_link->no_pcm)
 			continue;
 
+		if (!snd_soc_dpcm_get_substream(be, stream))
+			continue;
+
 		for_each_rtd_dais(be, i, dai) {
 			w = snd_soc_dai_get_widget(dai, stream);
 
-- 
2.35.3

