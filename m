From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 2/4] drm/i915: Remove superfluous NULL check
Date: Thu, 12 Nov 2015 17:20:12 +0100
Message-ID: <1447345214-7212-3-git-send-email-tiwai@suse.de>
References: <1447345214-7212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B902D265A1B
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 17:20:25 +0100 (CET)
In-Reply-To: <1447345214-7212-1-git-send-email-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

to_intel_crtc() always returns a non-NULL pointer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/i915/intel_audio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index ec81f8481d25..dc8141324fcd 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -658,10 +658,6 @@ static int i915_audio_component_sync_audio_rate(struct device *dev,
 		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
 		if (port == intel_dig_port->port) {
 			crtc = to_intel_crtc(intel_encoder->base.crtc);
-			if (!crtc) {
-				DRM_DEBUG_KMS("%s: crtc is NULL\n", __func__);
-				continue;
-			}
 			pipe = crtc->pipe;
 			break;
 		}
-- 
2.6.3
