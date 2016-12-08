From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] DRM: add help to get ELD speaker allocation
Date: Thu, 8 Dec 2016 17:37:46 +0100
Message-ID: <1481215067-19362-2-git-send-email-arnaud.pouliquen@st.com>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F0B2674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 17:37:55 +0100 (CET)
In-Reply-To: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

Add helper to allow users to retrieve the speaker allocations without
knowledge of the ELD structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/drm/drm_edid.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 919933d..0706cc6 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -245,6 +245,7 @@ struct detailed_timing {
 # define DRM_ELD_AUD_SYNCH_DELAY_MAX	0xfa	/* 500 ms */
 
 #define DRM_ELD_SPEAKER			7
+# define DRM_ELD_SPEAKER_MASK		0x7f
 # define DRM_ELD_SPEAKER_RLRC		(1 << 6)
 # define DRM_ELD_SPEAKER_FLRC		(1 << 5)
 # define DRM_ELD_SPEAKER_RC		(1 << 4)
@@ -412,6 +413,18 @@ static inline int drm_eld_size(const uint8_t *eld)
 }
 
 /**
+ * drm_eld_get_spk_alloc - Get speaker allocation
+ * @eld: pointer to an ELD memory structure
+ *
+ * The returned value is the speakers mask. User has to use %DRM_ELD_SPEAKER
+ * field definitions to identify speakers.
+ */
+static inline u8 drm_eld_get_spk_alloc(const uint8_t *eld)
+{
+	return eld[DRM_ELD_SPEAKER] & DRM_ELD_SPEAKER_MASK;
+}
+
+/**
  * drm_eld_get_conn_type - Get device type hdmi/dp connected
  * @eld: pointer to an ELD memory structure
  *
-- 
1.9.1
