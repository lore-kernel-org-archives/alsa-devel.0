Return-Path: <SRS0=TNia=LA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE38C47096
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:48:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E81A61246
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E81A61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFC781749;
	Sun,  6 Jun 2021 19:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFC781749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623001710;
	bh=69wiy1i+pp/18NrJlzJ2QLL+E/PfDCEqe0PWijKrc4I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sJUVi84/6MOra6RhXUWXvGKpe5xyl5a1xCEEJMiiy4SbJrhlasKhZlqQRdj6ggVrR
	 62YRoaenXdBd21kiVnCU3kfu33XJslYN3Q1Q2lE2pt8yS/vIT7XNkeFFS2X7vGakZm
	 bGZ9xGDq4DHcvSbE8QEDEA8rVy1ll26JDTL4q+ic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40610F804CC;
	Sun,  6 Jun 2021 19:46:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E5BDF804C2; Sun,  6 Jun 2021 19:46:49 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9CDFF804AB
 for <alsa-devel@alsa-project.org>; Sun,  6 Jun 2021 19:46:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9CDFF804AB
Received: by m.b4.vu (Postfix, from userid 1000)
 id 66C91612FB14; Mon,  7 Jun 2021 03:16:44 +0930 (ACST)
Date: Mon, 7 Jun 2021 03:16:44 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: usb-audio: scarlett2: Add temp variable for
 consistency
Message-ID: <198b38f091b40e59d40dfafa3024c97a3ea202f0.1622999147.git.g@b4.vu>
References: <cover.1622999147.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622999147.git.g@b4.vu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vladimir Sadovnikov <sadko4u@gmail.com>
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

Add index temporary variable to scarlett2_mixer_ctl_put() for
consistency with the other *_ctl_put() functions.

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 sound/usb/mixer_scarlett_gen2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 81c59463b693..8a4aa16cc364 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1622,18 +1622,19 @@ static int scarlett2_mixer_ctl_put(struct snd_kcontrol *kctl,
 	const struct scarlett2_device_info *info = private->info;
 	const struct scarlett2_ports *ports = info->ports;
 	int oval, val, num_mixer_in, mix_num, err = 0;
+	int index = elem->control;
 
 	mutex_lock(&private->data_mutex);
 
-	oval = private->mix[elem->control];
+	oval = private->mix[index];
 	val = ucontrol->value.integer.value[0];
 	num_mixer_in = ports[SCARLETT2_PORT_TYPE_MIX].num[SCARLETT2_PORT_OUT];
-	mix_num = elem->control / num_mixer_in;
+	mix_num = index / num_mixer_in;
 
 	if (oval == val)
 		goto unlock;
 
-	private->mix[elem->control] = val;
+	private->mix[index] = val;
 	err = scarlett2_usb_set_mix(mixer, mix_num);
 	if (err == 0)
 		err = 1;
-- 
2.31.1

