Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E30C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:16:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C5424683
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c36+5931"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C5424683
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4667584F;
	Fri, 20 Dec 2019 17:16:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4667584F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576858613;
	bh=OC9aAchKfZtD6LECOIpVXxSC3jO0Bj5URA9TzXiX+k8=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c36+5931TcyqumFj0/u5vyA9caFMS1nCXhV146luOgWYYJeIMuoWG7MUWS88333Tw
	 u25ReiH1w+yRXFzDjgMLkX2ZhQFqt2fQMz08ZZYR+8No9PdsrpSvMpuMikX/0cTfE5
	 mZIO+4dOufxLwxR7Z83R6HOuNMhbgik9ufpn6m24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C19E1F8014F;
	Fri, 20 Dec 2019 17:16:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A476F8015A; Fri, 20 Dec 2019 17:16:02 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 263D6F8014C
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 17:15:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 263D6F8014C
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D40A9AE2C
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 16:15:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 20 Dec 2019 17:15:55 +0100
Message-Id: <20191220161555.20232-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: uapi: Drop unneeded typedefs
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

We kept some typedefs in uapi/sound/*.h so that the programs in
alsa-tools can be built.  Now that alsa-lib takes these and applies
the workarounds in its own, we don't need these typedefs any longer in
the kernel uapi side.  Let's drop them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/emu10k1.h | 10 ----------
 include/uapi/sound/hdsp.h    |  9 ---------
 include/uapi/sound/hdspm.h   |  8 --------
 3 files changed, 27 deletions(-)

diff --git a/include/uapi/sound/emu10k1.h b/include/uapi/sound/emu10k1.h
index c1150e4d0231..6bcd76f64c1c 100644
--- a/include/uapi/sound/emu10k1.h
+++ b/include/uapi/sound/emu10k1.h
@@ -382,14 +382,4 @@ struct snd_emu10k1_fx8010_pcm_rec {
 #define SNDRV_EMU10K1_IOCTL_SINGLE_STEP	_IOW ('H', 0x83, int)
 #define SNDRV_EMU10K1_IOCTL_DBG_READ	_IOR ('H', 0x84, int)
 
-#ifndef __KERNEL__
-/* typedefs for compatibility to user-space */
-typedef struct snd_emu10k1_fx8010_info emu10k1_fx8010_info_t;
-typedef struct snd_emu10k1_fx8010_control_gpr emu10k1_fx8010_control_gpr_t;
-typedef struct snd_emu10k1_fx8010_code emu10k1_fx8010_code_t;
-typedef struct snd_emu10k1_fx8010_tram emu10k1_fx8010_tram_t;
-typedef struct snd_emu10k1_fx8010_pcm_rec emu10k1_fx8010_pcm_t;
-typedef struct emu10k1_ctl_elem_id emu10k1_ctl_elem_id_t;
-#endif
-
 #endif /* _UAPI__SOUND_EMU10K1_H */
diff --git a/include/uapi/sound/hdsp.h b/include/uapi/sound/hdsp.h
index 88c92a3fb477..7ac2d3f2a9b3 100644
--- a/include/uapi/sound/hdsp.h
+++ b/include/uapi/sound/hdsp.h
@@ -97,13 +97,4 @@ struct hdsp_9632_aeb {
 
 #define SNDRV_HDSP_IOCTL_GET_9632_AEB _IOR('H', 0x45, struct hdsp_9632_aeb)
 
-/* typedefs for compatibility to user-space */
-typedef enum HDSP_IO_Type HDSP_IO_Type;
-typedef struct hdsp_peak_rms hdsp_peak_rms_t;
-typedef struct hdsp_config_info hdsp_config_info_t;
-typedef struct hdsp_firmware hdsp_firmware_t;
-typedef struct hdsp_version hdsp_version_t;
-typedef struct hdsp_mixer hdsp_mixer_t;
-typedef struct hdsp_9632_aeb hdsp_9632_aeb_t;
-
 #endif /* __SOUND_HDSP_H */
diff --git a/include/uapi/sound/hdspm.h b/include/uapi/sound/hdspm.h
index 2d91f90eb5e1..3fbfd9dc5f51 100644
--- a/include/uapi/sound/hdspm.h
+++ b/include/uapi/sound/hdspm.h
@@ -219,12 +219,4 @@ struct hdspm_mixer_ioctl {
 /* use indirect access due to the limit of ioctl bit size */
 #define SNDRV_HDSPM_IOCTL_GET_MIXER _IOR('H', 0x44, struct hdspm_mixer_ioctl)
 
-/* typedefs for compatibility to user-space */
-typedef struct hdspm_peak_rms hdspm_peak_rms_t;
-typedef struct hdspm_config_info hdspm_config_info_t;
-typedef struct hdspm_version hdspm_version_t;
-typedef struct hdspm_channelfader snd_hdspm_channelfader_t;
-typedef struct hdspm_mixer hdspm_mixer_t;
-
-
 #endif
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
