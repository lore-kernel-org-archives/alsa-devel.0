Return-Path: <SRS0=nB+M=KS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B7DC47080
	for <alsa-devel@archiver.kernel.org>; Sun, 23 May 2021 09:12:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29DE610CB
	for <alsa-devel@archiver.kernel.org>; Sun, 23 May 2021 09:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29DE610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F276E16C3;
	Sun, 23 May 2021 11:11:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F276E16C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621761126;
	bh=MesJWl1lTNcB6DxAtLtzENQUfDOR88KDL3QVDpmBPvg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mt0EsCR8mKzGrkMxo8qXkr45TiVPWNfGHBPJpA3UySVkNtSrEFOFQKVAFisWE9Nm9
	 mza2OG1jzWlMjM+a02eR1pPFJi8wjqiuywtWd+ypvU18WEVijGq79x3rcbmfhPTGnu
	 SfXfHGQmwoVgvXK+JY28uB/V7MyceqGsVHeVwjlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFE68F804A9;
	Sun, 23 May 2021 11:09:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49C10F80482; Sun, 23 May 2021 11:09:36 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A21EF801F5
 for <alsa-devel@alsa-project.org>; Sun, 23 May 2021 11:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A21EF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="cgOn5U/Z"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="xp602NnP"
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621760963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UscbJca1IeLwZXOFGJXO2U1hD0N4CB1ik8LtEI0gRKk=;
 b=cgOn5U/ZTBn0dirmwUaURz/igKOqncbGzrcOAP83U+eACitZKXhUEz7Ys2iRXeHTgZ0STx
 p3KZfHomPeiihYcwtCShfkA/KZnoiAyDyqxxu40UBPBoaBeI8W2uA1PZ4dKwbGi/8F2ItI
 w+roYjx1L5EuWOfbD4R/34c7LhkYt4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621760963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UscbJca1IeLwZXOFGJXO2U1hD0N4CB1ik8LtEI0gRKk=;
 b=xp602NnPmnCUTH0mbTmMDwDhO+vs+f+MfQdUArkFP9taXwmm21pQslOvBxp7ePrm9ZdG/6
 uI4XwMKixeFhPkBQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 10ED0AC85;
 Sun, 23 May 2021 09:09:23 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 3/6] ALSA: control: Drop superfluous snd_power_wait() calls
Date: Sun, 23 May 2021 11:09:17 +0200
Message-Id: <20210523090920.15345-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210523090920.15345-1-tiwai@suse.de>
References: <20210523090920.15345-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

Now we have more fine-grained power controls in each kcontrol ops, the
coarse checks of snd_power_wait() in a few control ioctls became
superfluous.  Let's drop them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c        | 11 -----------
 sound/core/control_compat.c |  9 ---------
 2 files changed, 20 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 638da34605ba..7fe901384c9c 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1045,9 +1045,6 @@ static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
 
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
-	result = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		return result;
 	result = snd_ctl_elem_info(ctl, &info);
 	if (result < 0)
 		return result;
@@ -1119,10 +1116,6 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		goto error;
-
 	down_read(&card->controls_rwsem);
 	result = snd_ctl_elem_read(card, control);
 	up_read(&card->controls_rwsem);
@@ -1192,10 +1185,6 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 		return PTR_ERR(control);
 
 	card = file->card;
-	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		goto error;
-
 	result = snd_ctl_elem_write(card, file, control);
 	if (result < 0)
 		goto error;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 19133ee076c5..470dabc60aa0 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -96,9 +96,6 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
 		goto error;
 
-	err = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_info(ctl, data);
 	if (err < 0)
 		goto error;
@@ -301,9 +298,6 @@ static int ctl_elem_read_user(struct snd_card *card,
 	if (err < 0)
 		goto error;
 
-	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_read(card, data);
 	if (err < 0)
 		goto error;
@@ -329,9 +323,6 @@ static int ctl_elem_write_user(struct snd_ctl_file *file,
 	if (err < 0)
 		goto error;
 
-	err = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_write(card, file, data);
 	if (err < 0)
 		goto error;
-- 
2.26.2

