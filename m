From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH] ucm: allow multiple devices in JackHWMute
Date: Mon,  4 May 2015 19:10:38 +0300
Message-ID: <1430755838-16445-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A7662605B2
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 18:11:21 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

One jack may mute multiple devices, so let's make JackHWMute a list of
device names instead of just a single device name.

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/use-case.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)


Changes in v2:
 - Fixed the typo that Arun pointed out.
 - Send to alsa-devel (v1 was accidentally not sent to the list).


diff --git a/include/use-case.h b/include/use-case.h
index e3308b1..c7789c0 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -311,14 +311,15 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  *        applications are likely to support only one or the other.
  *
  *        If **JackHWMute** is set, it indicates that when the jack is plugged
- *        in, the hardware automatically mutes some other device. The
- *        JackHWMute value is the name of the muted device. Note that
- *        JackHWMute should be used only when the hardware enforces the
- *        automatic muting. If the hardware doesn't enforce any muting, it may
- *        still be tempting to set JackHWMute to trick upper software layers to
- *        e.g. automatically mute speakers when headphones are plugged in, but
- *        that's application policy configuration that doesn't belong to UCM
- *        configuration files.
+ *        in, the hardware automatically mutes some other device(s). The
+ *        JackHWMute value is a space-separated list of device names (this
+ *        isn't compatible with device names with spaces in them, so don't use
+ *        such device names!). Note that JackHWMute should be used only when
+ *        the hardware enforces the automatic muting. If the hardware doesn't
+ *        enforce any muting, it may still be tempting to set JackHWMute to
+ *        trick upper software layers to e.g. automatically mute speakers when
+ *        headphones are plugged in, but that's application policy
+ *        configuration that doesn't belong to UCM configuration files.
  */
 int snd_use_case_get(snd_use_case_mgr_t *uc_mgr,
                      const char *identifier,
-- 
1.9.3
