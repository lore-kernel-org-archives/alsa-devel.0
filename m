Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1FAC004D4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Jan 2023 10:34:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC96A7FE2;
	Thu, 19 Jan 2023 11:33:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC96A7FE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674124458;
	bh=SCw4XKMdSLYLYxNUHr9paSrnTufoXIrIxUNmQkyyHrk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=UVgHZqZIzoRa6qS/QoSwCc6WodNSG+jkTu8w+S5qF4KyZjkh8l3RgVaoH4K++JDCY
	 uLlKF5dqATnZ48/S6PfLS+F2deb7vrDFTn2rhifxcMjIZjf6VCYsAZ6oFz5AxWJrVC
	 lRMOu9zAGRJhMr52VvxJykQmVvmMLTXooGx/KDAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78E31F8025D;
	Thu, 19 Jan 2023 11:33:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 554C7F8047B; Thu, 19 Jan 2023 09:23:28 +0100 (CET)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22484F8024D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2023 09:23:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22484F8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256
 header.s=default header.b=QK9sullm
Received: from ubuntu.localdomain (unknown [46.146.89.18])
 by mail.ispras.ru (Postfix) with ESMTPSA id 582D3406BB55;
 Thu, 19 Jan 2023 08:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 582D3406BB55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1674116601;
 bh=yplRY5vy0IwvvCxj1QobBKOGx3GZDSpgAOeKTO9wQuc=;
 h=From:To:Cc:Subject:Date:From;
 b=QK9sullmZm/qV9iOheODkQeV+m5raFyFrR4nOUQSwrqdGdpIS5MYkK9AflobwBeWO
 y4i3vcJVsgFiJJD7fb01uwmXELwkgw49WH+ADppBaIn7M2ZarlwH35llHN1m+at6sS
 Acy7njboJG67Ke917zMzBWkqP+39aL4fSk/BSb0I=
From: Artemii Karasev <karasev@ispras.ru>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: hda/via: Avoid potential array out-of-bound in
 add_secret_dac_path()
Date: Thu, 19 Jan 2023 00:22:59 -0800
Message-Id: <20230119082259.3634-1-karasev@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Jan 2023 11:33:26 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: lvc-project@linuxtesting.org, alsa-devel@alsa-project.org,
 Xiang wangx <wangxiang@cdjrlc.com>, Artemii Karasev <karasev@ispras.ru>,
 linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

snd_hda_get_connections() can return a negative error code.
It may lead to accessing 'conn' array at a negative index.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artemii Karasev <karasev@ispras.ru>
Fixes: 30b4503378c9 ("ALSA: hda - Expose secret DAC-AA connection of some VIA codecs")
---
 sound/pci/hda/patch_via.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index aea7fae2ca4b..2994f85bc1b9 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -819,6 +819,9 @@ static int add_secret_dac_path(struct hda_codec *codec)
 		return 0;
 	nums = snd_hda_get_connections(codec, spec->gen.mixer_nid, conn,
 				       ARRAY_SIZE(conn) - 1);
+	if (nums < 0)
+		return nums;
+
 	for (i = 0; i < nums; i++) {
 		if (get_wcaps_type(get_wcaps(codec, conn[i])) == AC_WID_AUD_OUT)
 			return 0;
-- 
2.25.1

