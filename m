From: linux@audioscience.com
Subject: [PATCH 15/21] Add autofade query.
Date: Thu, 22 Dec 2011 13:38:45 +1300
Message-ID: <1324514331-22570-16-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D894A103C32
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:16 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:30 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi.h     |    3 +++
 sound/pci/asihpi/hpifunc.c |   10 ++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 867c144..f2f1d98 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -1347,6 +1347,9 @@ u16 hpi_volume_auto_fade_profile(u32 h_control,
 	short an_stop_gain0_01dB[HPI_MAX_CHANNELS], u32 duration_ms,
 	u16 profile);
 
+u16 hpi_volume_query_auto_fade_profile(const u32 h_control, const u32 i,
+	u16 *profile);
+
 /*****************/
 /* Level control */
 /*****************/
diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index ebb568d..510e56c 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -2826,6 +2826,16 @@ u16 hpi_volume_auto_fade(u32 h_control,
 		duration_ms, HPI_VOLUME_AUTOFADE_LOG);
 }
 
+u16 hpi_volume_query_auto_fade_profile(const u32 h_volume, const u32 i,
+	u16 *profile)
+{
+	u16 e;
+	u32 u;
+	e = hpi_control_query(h_volume, HPI_VOLUME_AUTOFADE, i, 0, &u);
+	*profile = (u16)u;
+	return e;
+}
+
 u16 hpi_vox_set_threshold(u32 h_control, short an_gain0_01dB)
 {
 	struct hpi_message hm;
-- 
1.7.0.4
