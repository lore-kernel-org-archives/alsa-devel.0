Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D77C33CB7
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805EF246AA
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="czAwWV94";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JacH2PLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805EF246AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D52941752;
	Thu, 16 Jan 2020 18:42:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D52941752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579196572;
	bh=NViBPDaefPNqO+7egz35GyEsYsj8hp/NvRPnGuQ3D60=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czAwWV94QtObkKl09AorYbf3AKXvHY6s2VVOoDoVhAoqXaG/v47W4ByhlCl+RKUEI
	 vgiNfBif5jsFMnioCFm9gly/LXyIPeSvjNPvLI0Kjk2lOf4juvE/PuUiQabR1xtfbN
	 vm8PUJ/NIxGAOASE2e6AqlV9IEMKVcplnDHXT3X0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AC9AF80274;
	Thu, 16 Jan 2020 18:38:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8FBFF80276; Thu, 16 Jan 2020 18:38:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D704F80271
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 18:38:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D704F80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JacH2PLq"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11883246F2;
 Thu, 16 Jan 2020 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579196317;
 bh=vGBL1imLSbmqR+6eJCLZvfNMR/2j+V+YokWAhVLP25k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JacH2PLqUQIcVeoTub7XQiu88hqQlkqGLWepO6RJ6LkBDKlds9HWv8gcY+TtyZJc0
 jTkU64Z7hanQmbMtS9S+sacAOnox7Cm0JjzIjcSvkfaUzQFcaO6GWMbW3Vxu6UPW/Z
 O19BqKinhMqzx/LdIE9bE9HC5ObyMYiAB6jjFMK0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 16 Jan 2020 12:34:31 -0500
Message-Id: <20200116173641.22137-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH AUTOSEL 4.9 122/251] ALSA: usb-audio: Handle
	the error from snd_usb_mixer_apply_create_quirk()
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 328e9f6973be2ee67862cb17bf6c0c5c5918cd72 ]

The error from snd_usb_mixer_apply_create_quirk() is ignored in the
current usb-audio driver code, which will continue the probing even
after the error.  Let's take it more serious.

Fixes: 7b1eda223deb ("ALSA: usb-mixer: factor out quirks")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 64fa1bbf0acb..54011f8543a7 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2626,7 +2626,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	    (err = snd_usb_mixer_status_create(mixer)) < 0)
 		goto _error;
 
-	snd_usb_mixer_apply_create_quirk(mixer);
+	err = snd_usb_mixer_apply_create_quirk(mixer);
+	if (err < 0)
+		goto _error;
 
 	err = snd_device_new(chip->card, SNDRV_DEV_CODEC, mixer, &dev_ops);
 	if (err < 0)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
