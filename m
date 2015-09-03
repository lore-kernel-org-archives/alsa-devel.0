From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] drm/i915: Add locks around audio component
	bind/unbind
Date: Thu,  3 Sep 2015 11:51:35 +0200
Message-ID: <1441273895-31153-3-git-send-email-david.henningsson@canonical.com>
References: <1441273895-31153-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB45265721
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 11:51:36 +0200 (CEST)
In-Reply-To: <1441273895-31153-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This will make sure that audio callbacks do not race with
component bind/unbind.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 drivers/gpu/drm/i915/intel_audio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 2d52d96..678a34f 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -543,9 +543,11 @@ static int i915_audio_component_bind(struct device *i915_dev,
 	if (WARN_ON(acomp->ops || acomp->dev))
 		return -EEXIST;
 
+	drm_modeset_lock_all(dev_priv->dev);
 	acomp->ops = &i915_audio_component_ops;
 	acomp->dev = i915_dev;
 	dev_priv->audio_component = acomp;
+	drm_modeset_unlock_all(dev_priv->dev);
 
 	return 0;
 }
@@ -556,9 +558,11 @@ static void i915_audio_component_unbind(struct device *i915_dev,
 	struct i915_audio_component *acomp = data;
 	struct drm_i915_private *dev_priv = dev_to_i915(i915_dev);
 
+	drm_modeset_lock_all(dev_priv->dev);
 	acomp->ops = NULL;
 	acomp->dev = NULL;
 	dev_priv->audio_component = NULL;
+	drm_modeset_unlock_all(dev_priv->dev);
 }
 
 static const struct component_ops i915_audio_component_bind_ops = {
-- 
1.9.1
