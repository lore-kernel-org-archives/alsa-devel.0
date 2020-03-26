Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32020C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:31:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02EE20663
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gT67RUzI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSXkChKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02EE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 156C01672;
	Fri, 27 Mar 2020 00:30:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 156C01672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585265508;
	bh=SZawdQI40sboV8ru38/GjGrBnwBOqz+ZRaoetvhWniA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gT67RUzID5MGs3GjMTxWyxLPc05mG/bxhGNTppK9phMlMQHoHoddG1GfaMMfbcJEB
	 iLWUVudP7+AYri4tnf4lHZret/YyB8tsEyoGQmdAcuQnYHRsoHiMQnOjfOxwdbMJkv
	 DhaW9rEIt/L+rwJqmd1PFPVAKIgwKK3FB2kb710U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37B6FF80303;
	Fri, 27 Mar 2020 00:25:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEBD0F802F9; Fri, 27 Mar 2020 00:25:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDAD2F802EC
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 00:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDAD2F802EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WSXkChKH"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CAFD0214DB;
 Thu, 26 Mar 2020 23:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585265111;
 bh=SZawdQI40sboV8ru38/GjGrBnwBOqz+ZRaoetvhWniA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WSXkChKHceb0ofsiYSaFml4A5GfNcNqXuQH/jbID1mereD/UK20dkrSvXQzhwxdwG
 fYqe5OqkNNQdMRZ5WhKshOwVhT3sTojs8OwA86wS9n0GeEQUnfh3cZKg9J62bJInW2
 BaLCv7RBYipZw/0uQds3cE997ZSUNXV1FxTnQBwo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/15] ALSA: pcm: oss: Remove WARNING from
 snd_pcm_plug_alloc() checks
Date: Thu, 26 Mar 2020 19:24:54 -0400
Message-Id: <20200326232455.8029-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232455.8029-1-sashal@kernel.org>
References: <20200326232455.8029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org,
 syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5461e0530c222129dfc941058be114b5cbc00837 ]

The return value checks in snd_pcm_plug_alloc() are covered with
snd_BUG_ON() macro that may trigger a kernel WARNING depending on the
kconfig.  But since the error condition can be triggered by a weird
user space parameter passed to OSS layer, we shouldn't give the kernel
stack trace just for that.  As it's a normal error condition, let's
remove snd_BUG_ON() macro usage there.

Reported-by: syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312155730.7520-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/pcm_plugin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 9b588c6a6f099..732bbede7ebfd 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -111,7 +111,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->next) {
 			if (plugin->dst_frames)
 				frames = plugin->dst_frames(plugin, frames);
-			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
+			if ((snd_pcm_sframes_t)frames <= 0)
 				return -ENXIO;
 			plugin = plugin->next;
 			err = snd_pcm_plugin_alloc(plugin, frames);
@@ -123,7 +123,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->prev) {
 			if (plugin->src_frames)
 				frames = plugin->src_frames(plugin, frames);
-			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
+			if ((snd_pcm_sframes_t)frames <= 0)
 				return -ENXIO;
 			plugin = plugin->prev;
 			err = snd_pcm_plugin_alloc(plugin, frames);
-- 
2.20.1

