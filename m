From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: [PATCH] ucm: Document PlaybackPCMIsDummy and
	CapturePCMIsDummy values
Date: Thu, 26 Jun 2014 13:30:25 +0300
Message-ID: <1403778625-4608-1-git-send-email-tanu.kaskinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 086B82610C1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 12:30:40 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Felipe Tonello <eu@felipetonello.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

At least PulseAudio needs special handling for dummy devices. To allow
that to happen automatically, the UCM configuration should contain the
information about which PCMs are dummy.

Signed-off-by: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
---
 include/use-case.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/use-case.h b/include/use-case.h
index 4e13249..f30168f 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -258,7 +258,17 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
  * Recommended names for values:
  *   TQ			- Tone Quality
  *   PlaybackPCM	- full PCM playback device name
+ *   PlaybackPCMIsDummy	- Valid values: "yes" and "no". If set to "yes", the
+ *			  PCM named by the PlaybackPCM value is a dummy device,
+ *			  meaning that opening it enables an audio path in the
+ *			  hardware, but writing to the PCM device has no
+ *			  effect.
  *   CapturePCM		- full PCM capture device name
+ *   CapturePCMIsDummy	- Valid values: "yes" and "no". If set to "yes", the
+ *			  PCM named by the CapturePCM value is a dummy device,
+ *			  meaning that opening it enables an audio path in the
+ *			  hardware, but reading from the PCM device has no
+ *			  effect.
  *   PlaybackRate	- playback device sample rate
  *   PlaybackChannels	- playback device channel count
  *   PlaybackCTL	- playback control device name
-- 
1.9.3
