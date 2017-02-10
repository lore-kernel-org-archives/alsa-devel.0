From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] ALSA: x86: Ensure VLV bitwise operations are
	SOC specific
Date: Fri, 10 Feb 2017 14:33:33 +1100
Message-ID: <CAFXWsS86Bc7LZfFzT6Wa_z1LDiZk1S2ArbOApa+dE9fmB0hdcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 9572926680F
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 04:33:35 +0100 (CET)
Received: by mail-yw0-f194.google.com with SMTP id l16so1743273ywb.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 19:33:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The function vlv_display_irq_postinstall is used by both valleyview
and cherryview irq handling. I915_LPE_PIPE_C_INTERRUPT is specific
to cherryview so should be excluded from any valleyview associated
bitwise operations.

Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
---
 drivers/gpu/drm/i915/i915_irq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_irq.c
b/drivers/gpu/drm/i915/i915_irq.c
index f0880af..ee61808 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -2940,9 +2940,10 @@ static void vlv_display_irq_postinstall(struct
drm_i915_private *dev_priv)

        WARN_ON(dev_priv->irq_mask != ~0);

-       val = (I915_LPE_PIPE_A_INTERRUPT |
-               I915_LPE_PIPE_B_INTERRUPT |
-               I915_LPE_PIPE_C_INTERRUPT);
+       val = I915_LPE_PIPE_A_INTERRUPT |
+               I915_LPE_PIPE_B_INTERRUPT;
+       if (IS_CHERRYVIEW(dev_priv))
+               val |= I915_LPE_PIPE_C_INTERRUPT;

        enable_mask |= val;

-- 
1.9.1
