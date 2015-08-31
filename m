From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] reset: Add (devm_)reset_control_get stub functions
Date: Mon, 31 Aug 2015 17:22:23 +0800
Message-ID: <1441012943.22251.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

So the drivers can be compiled with CONFIG_RESET_CONTROLLER disabled.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 include/linux/reset.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index da5602b..cd42c1b 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -74,6 +74,18 @@ static inline int device_reset_optional(struct device *dev)
 	return -ENOSYS;
 }
 
+static inline struct reset_control *reset_control_get(
+					struct device *dev, const char *id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct reset_control *devm_reset_control_get(
+					struct device *dev, const char *id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline struct reset_control *reset_control_get_optional(
 					struct device *dev, const char *id)
 {
-- 
2.1.0
