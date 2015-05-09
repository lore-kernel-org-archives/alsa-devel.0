From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 09/13] drm/edid: add function to help find SADs
Date: Sat, 09 May 2015 11:26:37 +0100
Message-ID: <E1Yr1xt-0006l4-D0@rmk-PC.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150509102501.GO2067@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add a function to find the start of the SADs in the ELD.  This
complements the helper to retrieve the SAD count.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/drm/drm_edid.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 799050198323..53c53c459b15 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -348,6 +348,25 @@ static inline int drm_eld_mnl(const uint8_t *eld)
 }
 
 /**
+ * drm_eld_sad - Get ELD SAD structures.
+ * @eld: pointer to an eld memory structure with sad_count set
+ */
+static inline const uint8_t *drm_eld_sad(const uint8_t *eld)
+{
+	unsigned int ver, mnl;
+
+	ver = (eld[DRM_ELD_VER] & DRM_ELD_VER_MASK) >> DRM_ELD_VER_SHIFT;
+	if (ver != 2 && ver != 31)
+		return NULL;
+
+	mnl = drm_eld_mnl(eld);
+	if (mnl > 16)
+		return NULL;
+
+	return eld + DRM_ELD_CEA_SAD(mnl, 0);
+}
+
+/**
  * drm_eld_sad_count - Get ELD SAD count.
  * @eld: pointer to an eld memory structure with sad_count set
  */
-- 
1.8.3.1
