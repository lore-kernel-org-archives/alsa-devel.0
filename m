Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6025AC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Jan 2022 11:19:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCCB31820;
	Sun, 16 Jan 2022 12:18:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCCB31820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642331965;
	bh=p+HG0FJJ/7lJPreOOuEDDDzXwgdvFMagXeh6pQC+eqk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tPsX009LTOoLliWLmqp1sWaR9GwaLqq+5IwnDq+BreOraWmgJ3v/BkOR7UP5S8bNO
	 mAj4APqGh05IDXrcJlneLS16ALkGu9VCzaGEQmaYzixNSDqpeqSjmdxRngNtVyiN2A
	 THemf/tqP7L1TA8FXkst5RFJcchnFiz5pUSEosaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6668FF8047D;
	Sun, 16 Jan 2022 12:18:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 604C2F80117; Sun, 16 Jan 2022 12:18:32 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08BD4F80117
 for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2022 12:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08BD4F80117
Received: from pop-os.home ([90.126.236.122]) by smtp.orange.fr with ESMTPA
 id 93YEngVhBZQwW93YFnBe69; Sun, 16 Jan 2022 12:18:25 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 16 Jan 2022 12:18:25 +0100
X-ME-IP: 90.126.236.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: soc-pcm: use GFP_ATOMIC in dpcm_create_debugfs_state()
Date: Sun, 16 Jan 2022 12:18:17 +0100
Message-Id: <ed322b8821fa787907c1a4cce879564d1281b69d.1642331884.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

The commit below states that dpcm_be_connect() may be called from atomic
context. It changes a GFP_KERNEL into a GFP_ATOMIC to deal with it.

Another memory allocation is done in dpcm_create_debugfs_state() which is
called by dpcm_be_connect(). Also use GFP_ATOMIC there to be consistent
and be compliant with atomic context.

Fixes: d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not clear to me how dpcm_be_connect() can be called from an atomic context,
though. But better safe than sorry.
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7abfc48b26ca..1a536a2b9dc3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -212,7 +212,7 @@ static void dpcm_create_debugfs_state(struct snd_soc_dpcm *dpcm, int stream)
 {
 	char *name;
 
-	name = kasprintf(GFP_KERNEL, "%s:%s", dpcm->be->dai_link->name,
+	name = kasprintf(GFP_ATOMIC, "%s:%s", dpcm->be->dai_link->name,
 			 stream ? "capture" : "playback");
 	if (name) {
 		dpcm->debugfs_state = debugfs_create_dir(
-- 
2.32.0

