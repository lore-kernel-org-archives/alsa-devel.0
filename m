Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14679C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 14:49:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABCDF16E0;
	Tue, 19 Jul 2022 16:48:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABCDF16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658242183;
	bh=EG9zfsMOzqG79IebV8OtZnSRWgl5xJkdBOPe7oy1sas=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FXu2OhgxMXwNyhRqbKQDvX5WaW6T0x2XwW9AVXA6DFvklXHmOIvRpZipqc/CSg4U0
	 jcIRWi4ePA0576mbAny8Twkt26t4Eq7PHpKY9P1GaSFFR+2yluVQKxJzbgix0JmJId
	 16oUlt+8aj+UzQi9UwjUT9TwKqohqzj6rcgCIclc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3994DF80125;
	Tue, 19 Jul 2022 16:48:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E74DF80118; Tue, 19 Jul 2022 16:48:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D26A3F80118
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 16:48:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D26A3F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="M4LBTZOI"
Received: from localhost.localdomain (unknown [10.101.196.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 600193F3BD; 
 Tue, 19 Jul 2022 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658242122;
 bh=AvYcZcToBAAnfmFM45alM5FvVGJ3gSm105Dq6wUqcmw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=M4LBTZOIWTCzLkUwctVzsSbya8Nmf+Nic/k9snJH1tKr8hXrbajBgCf4e/GDxL2BZ
 YQdiyZ6ce2YAY9N9ToM5sWMqPsfXP93sDzGImIP+u4erSCxL/evPkfO9UHGfPfnm08
 9vJc9C93fZHH9SW2oCoT+XitJVQRnI9s9n+bYwHx5iz1Pm9kDxYqV2teZmygxf7389
 z7bmtF/hum06CSaqay9jFHFBIOiCK+hsAFKE7xGC8IUs4YRYbfN363mwYus/5q52zI
 w8MZRXbI9vti0BJ+nojXYWRfcti5II6ws4mlLIEUpZP8vUbeljxSPfL+z8dwHD4kjH
 Xqz3AOh8ahnpA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda: Skip creating captures in SOF context
Date: Tue, 19 Jul 2022 22:47:52 +0800
Message-Id: <20220719144753.252231-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
topology: use new sound control LED layer").

The micmute LED itself is still working via sysfs, but it doesn't follow
mute anymore. That's because unlike vendors like Dell and Lenovo, HP
laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
laptops, both SOF and HDA create captures with
SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
there are two different kcontrols and one of them is not muted.

So skip creating captures for HDA when it's called from SOF, the
captures are already handled by SOF.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fc114e5224806..2a6c1a77c49ac 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5075,10 +5075,14 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 			return err;
 	}
 
-
-	err = create_capture_mixers(codec);
-	if (err < 0)
-		return err;
+	/* Skip creating capture on SOF which creates captures based on
+	 * topology file.
+	 */
+	if (codec->core.type != HDA_DEV_ASOC) {
+		err = create_capture_mixers(codec);
+		if (err < 0)
+			return err;
+	}
 
 	err = parse_mic_boost(codec);
 	if (err < 0)
-- 
2.36.1

