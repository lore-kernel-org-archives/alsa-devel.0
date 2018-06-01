From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH] ALSA: pci/hda: Remove unused, broken,
	header file
Date: Fri, 1 Jun 2018 16:32:30 +0100
Message-ID: <20180601153230.gp7wl74xb7bhompn@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id E9B6B2676C6
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 17:32:34 +0200 (CEST)
Received: from [148.252.241.226] (helo=xylophone.i.decadent.org.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1fOm2c-0002fd-7V
 for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2018 16:32:34 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/pci/hda/local.h seems to be an earlier version of
sound/hda/local.h; it was added at the same time but doesn't seem to
have ever been used (within the git history).  Most of its macros
depend on a hdac_read_parm() function which is not defined anywhere.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 sound/pci/hda/local.h | 40 ----------------------------------------
 1 file changed, 40 deletions(-)
 delete mode 100644 sound/pci/hda/local.h

diff --git a/sound/pci/hda/local.h b/sound/pci/hda/local.h
deleted file mode 100644
index 3b8b7d78f9e0..000000000000
--- a/sound/pci/hda/local.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- */
-
-#ifndef __HDAC_LOCAL_H
-#define __HDAC_LOCAL_H
-
-int hdac_read_parm(struct hdac_device *codec, hda_nid_t nid, int parm);
-
-#define get_wcaps(codec, nid) \
-	hdac_read_parm(codec, nid, AC_PAR_AUDIO_WIDGET_CAP)
-/* get the widget type from widget capability bits */
-static inline int get_wcaps_type(unsigned int wcaps)
-{
-	if (!wcaps)
-		return -1; /* invalid type */
-	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
-}
-
-#define get_pin_caps(codec, nid) \
-	hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
-
-static inline
-unsigned int get_pin_cfg(struct hdac_device *codec, hda_nid_t nid)
-{
-	unsigned int val;
-
-	if (snd_hdac_read(codec, nid, AC_VERB_GET_CONFIG_DEFAULT, 0, &val))
-		return -1;
-	return val;
-}
-
-#define get_amp_caps(codec, nid, dir) \
-	hdac_read_parm(codec, nid, (dir) == HDA_OUTPUT ? \
-		       AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP)
-
-#define get_power_caps(codec, nid) \
-	hdac_read_parm(codec, nid, AC_PAR_POWER_STATE)
-
-#endif /* __HDAC_LOCAL_H */
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
