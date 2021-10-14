Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA7C60EDF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 13:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2EA7C60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 956E71670;
	Thu, 14 Oct 2021 15:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 956E71670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634216908;
	bh=awXYklvmQy06hOlOOxE6GiEdBIeTO5kJrIgzg2PplLY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iTw17Z0XpBXrTdOuftZJFdrmPNeEjy+dX1rVoA/ZfcN01lQhUlXRA9M38vKfXuOG7
	 RkcFUm/ngLyMHiwgBfWM9LsW0BkHP2qv/h9XaqZZglLphq8VzimQ67Nvo6E8jy4lN7
	 7owH1Fix2trx5ihbwZJlKBwzx2CI9NSHxQ55uxec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 719B9F804E5;
	Thu, 14 Oct 2021 15:06:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 094ECF804E5; Thu, 14 Oct 2021 15:06:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1315BF80212
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 15:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1315BF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="O4UkwUoj"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="aGJ+pd6V"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0F84E1FD34;
 Thu, 14 Oct 2021 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634216799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMvjta8MHpfGK0frByts4+GBZ5P/weVUGM1+n/rpj00=;
 b=O4UkwUojLLYH31iA0dqv9Hyf32Jypoi3tTzw+tlPG7jbuxCj7lpPpjkeb4kTr+u8oTTNtU
 olLqQv1v0TbiYQkD39T3MzCauxaaySEsqFTPrwj8b2+UE2U0owkrAl5ZTxkT1ug1MvORwz
 cylX5DgPerzjQKD/LA3WI9NguweHM1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634216799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMvjta8MHpfGK0frByts4+GBZ5P/weVUGM1+n/rpj00=;
 b=aGJ+pd6V6ZDk5yG00YTz6Uh1Fm6kpgd/sdfcW4pjEKdBYuCc1+l07VxVO+gts2YwLfgYjs
 P6/A0A/gXCJMD6AA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id F3990A3B85;
 Thu, 14 Oct 2021 13:06:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/3] ALSA: usb-audio: Downgrade error message in
 get_ctl_value_v2()
Date: Thu, 14 Oct 2021 15:06:34 +0200
Message-Id: <20211014130636.17860-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211014130636.17860-1-tiwai@suse.de>
References: <20211014130636.17860-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

The error message in get_ctl_value_v2() (for UAC2/3) is shown via
KERN_ERR level but it was intended to be rather a debug message as
seen in get_ctl_value_v1() (for UAC1).  This patch downgrade the
printk level.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a2ce535df14b..a20af9243155 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -373,7 +373,7 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 
 	if (ret < 0) {
 error:
-		usb_audio_err(chip,
+		usb_audio_dbg(chip,
 			"cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, type = %d\n",
 			request, validx, idx, cval->val_type);
 		return ret;
-- 
2.26.2

