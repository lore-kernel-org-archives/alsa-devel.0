From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC v2 09/13] drm/edid: add function to help
	find SADs
Date: Thu, 02 Apr 2015 10:22:01 +0100
Message-ID: <E1YdbK5-00085I-HB@rmk-PC.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1E555265726
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 11:22:20 +0200 (CEST)
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
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
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Add a function to find the start of the SADs in the ELD.  This
complements the helper to retrieve the SAD count.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/drm/drm_edid.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 87d85e81d3a7..c44ad513e0f7 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -346,6 +346,25 @@ static inline int drm_eld_mnl(const uint8_t *eld)
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
