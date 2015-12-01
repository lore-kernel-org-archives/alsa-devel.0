From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 12/15] drm/edid: Add API to help find
	connection type
Date: Tue,  1 Dec 2015 23:17:08 +0530
Message-ID: <1448992031-8271-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E78E8265D3D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:54 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, David Airlie <airlied@linux.ie>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, patches.audio@intel.com, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

To fill the audio infoframe it is required to identify the connection type
as DP or HDMI. So parse the required bits in ELD to find the connection
type.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@intel.com>
---
 include/drm/drm_edid.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 2af9769..c7595a5 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -403,6 +403,16 @@ static inline int drm_eld_size(const uint8_t *eld)
 	return DRM_ELD_HEADER_BLOCK_SIZE + eld[DRM_ELD_BASELINE_ELD_LEN] * 4;
 }
 
+/**
+ * drm_eld_get_conn_type - Get device type hdmi/dp connected
+ * @eld: pointer to an eld memory structure
+ */
+static inline int drm_eld_get_conn_type(const uint8_t *eld)
+{
+	return (eld[DRM_ELD_SAD_COUNT_CONN_TYPE] & DRM_ELD_CONN_TYPE_MASK) >>
+		DRM_ELD_CONN_TYPE_SHIFT;
+}
+
 struct edid *drm_do_get_edid(struct drm_connector *connector,
 	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
 			      size_t len),
-- 
1.9.1
