Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB73C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Mar 2022 15:49:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 37BE7171A;
	Tue, 22 Mar 2022 16:48:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 37BE7171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647964178;
	bh=k9HdjOm2oLLUm+/TjF+bj2AcjzHOpnumMpBi9ZN5JGo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ns32OZqfKl4PTt/VVBYcKg6y6r2wGL2xdzxa7iui/SZtS1Z54UmDde+1SQonkf91C
	 gaiyV1f4frZTcnZTPXOqyDBEKx1Txr4sER5hlwZn3R5AST1Nvnr0cy+dQqSA8uyEmH
	 k1rGHuZrTE+qEik6rGCXPkWw8oICTlAFG7gKrgKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0AB4F80116;
	Tue, 22 Mar 2022 16:48:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F208F8016C; Tue, 22 Mar 2022 16:48:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37D4BF80116
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2022 16:48:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37D4BF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="zhoXFgCk"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="2Vsyqf9G"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 62D231F388;
 Tue, 22 Mar 2022 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647964112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DTE9I7qa9MhB/J5xvqDekO0wkX+47GMipzGFMyWvaEM=;
 b=zhoXFgCkKhccE03+hc8rMpmTxO+eqUiASra0E9wFqbZ5KkISXLUYUt/7x2HmKJPreYT3VV
 eV6b5lZQUcIs9xBRiH2ILbVASvdHrAJbc5bSpY792D92A3sqT/CdG5dyyhgV4dDe1vnHDS
 AVFmzLiwrEJR/LtWbsbvi8fjMDjkiSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647964112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DTE9I7qa9MhB/J5xvqDekO0wkX+47GMipzGFMyWvaEM=;
 b=2Vsyqf9GDm9lmZmeMWkAS8nFECYDJZUVoWK71hvkjqj53AGpOkRBwX3lNhJPw05OG/b1TK
 UMN+v5TG104YK/AA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 09C84A3B81;
 Tue, 22 Mar 2022 15:48:32 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: intel: atom: Remove superfluous flush_scheduled_work()
Date: Tue, 22 Mar 2022 16:48:26 +0100
Message-Id: <20220322154826.19400-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
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

It seems that flush_scheduled_work() is called without any real
purpose at sst_context_cleanup() (the driver doesn't put works on the
global queue at all).  As the flush_schedule_work() function is going
to be abolished in near future, let's drop it now.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst/sst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index e21e11dac000..3a42d68c0247 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -360,7 +360,6 @@ void sst_context_cleanup(struct intel_sst_drv *ctx)
 	sst_unregister(ctx->dev);
 	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
 	sysfs_remove_group(&ctx->dev->kobj, &sst_fw_version_attr_group);
-	flush_scheduled_work();
 	destroy_workqueue(ctx->post_msg_wq);
 	cpu_latency_qos_remove_request(ctx->qos);
 	kfree(ctx->fw_sg_list.src);
-- 
2.31.1

