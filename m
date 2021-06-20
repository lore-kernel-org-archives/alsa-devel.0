Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9843C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:50:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496136108E
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 16:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496136108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADFFE16CD;
	Sun, 20 Jun 2021 18:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADFFE16CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624207855;
	bh=ZKR5bEo9lAxIPxR2+dKkAJV+zpdnH93y9LQeQ/LPr8I=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=khAm7RaGF9/kKgWIhvEssqiSe5aPXj32VQmXZhp9YacdaAvdAthl6t1m+RBD0uhEu
	 Qusu36xgzu7jPy8Cdi6nBQqx9zJASN8YyLMJ4Eoc+BECz6oM3eHTqdSlYg/c+3UGFe
	 w694NLb7Qm/6gtBItVZiFmhdSMBBRhtUN4NdLHDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10092F80515;
	Sun, 20 Jun 2021 18:46:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5D2FF8026A; Sun, 20 Jun 2021 18:46:46 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3164F804C3
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 18:46:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3164F804C3
Received: by m.b4.vu (Postfix, from userid 1000)
 id 6F6A261E5F1A; Mon, 21 Jun 2021 02:16:41 +0930 (ACST)
Date: Mon, 21 Jun 2021 02:16:41 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/14] ALSA: usb-audio: scarlett2: Add temp variable for
 consistency
Message-ID: <20210620164641.GA9211@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
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
index c1e74918425a..cb8483d3c58a 100644
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

