From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] drm/i915: Drop port_mst_index parameter
	from pin/eld callback
Date: Thu,  3 Sep 2015 11:51:34 +0200
Message-ID: <1441273895-31153-2-git-send-email-david.henningsson@canonical.com>
References: <1441273895-31153-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BEBD26570A
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 11:51:34 +0200 (CEST)
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

The port_mst_index parameter was reserved for future use, but
maintainers prefer to add it later when it is actually used.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 drivers/gpu/drm/i915/intel_audio.c | 4 ++--
 include/drm/i915_component.h       | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 969835d..2d52d96 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -424,7 +424,7 @@ void intel_audio_codec_enable(struct intel_encoder *intel_encoder)
 		dev_priv->display.audio_codec_enable(connector, intel_encoder, mode);
 
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
-		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr, (int) port, 0);
+		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr, (int) port);
 }
 
 /**
@@ -447,7 +447,7 @@ void intel_audio_codec_disable(struct intel_encoder *intel_encoder)
 		dev_priv->display.audio_codec_disable(intel_encoder);
 
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify)
-		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr, (int) port, 0);
+		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr, (int) port);
 }
 
 /**
diff --git a/include/drm/i915_component.h b/include/drm/i915_component.h
index ab5bde37..b2d56dd 100644
--- a/include/drm/i915_component.h
+++ b/include/drm/i915_component.h
@@ -42,9 +42,8 @@ struct i915_audio_component {
 		 * pin sense and/or ELD information has changed.
 		 * @audio_ptr:		HDA driver object
 		 * @port:		Which port has changed (PORTA / PORTB / PORTC etc)
-		 * @port_mst_index:	Index within that port, for DisplayPort multistreaming
 		 */
-		void (*pin_eld_notify)(void *audio_ptr, int port, int port_mst_index);
+		void (*pin_eld_notify)(void *audio_ptr, int port);
 	} *audio_ops;
 };
 
-- 
1.9.1
