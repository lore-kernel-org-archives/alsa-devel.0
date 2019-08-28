From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Update descriptions about new
	position_fix values
Date: Wed, 28 Aug 2019 16:36:36 +0200
Message-ID: <20190828143636.28420-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CD83F897B5
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 16:36:38 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 00DDFABED
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 14:36:37 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The new values for the recent Intel and AMD chips are missing in the
documentation.  Add the new descriptions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa-configuration.rst | 2 ++
 Documentation/sound/hd-audio/notes.rst     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 4a3cecc8ad38..02aacd69ab96 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -1001,6 +1001,8 @@ position_fix
     2 = POSBUF: use position buffer,
     3 = VIACOMBO: VIA-specific workaround for capture,
     4 = COMBO: use LPIB for playback, auto for capture stream
+    5 = SKL+: apply the delay calculation available on recent Intel chips
+    6 = FIFO: correct the position with the fixed FIFO size, for recent AMD chips
 probe_mask
     Bitmask to probe codecs (default = -1, meaning all slots);
     When the bit 8 (0x100) is set, the lower 8 bits are used
diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index 9f7347830ba4..0f3109d9abc8 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -66,6 +66,11 @@ by comparing both LPIB and position-buffer values.
 ``position_fix=4`` is another combination available for all controllers,
 and uses LPIB for the playback and the position-buffer for the capture
 streams.
+``position_fix=5`` is specific to Intel platforms, so far, for Skylake
+and onward.  It applies the delay calculation for the precise position
+reporting.
+``position_fix=6`` is to correct the position with the fixed FIFO
+size, mainly targeted for the recent AMD controllers.
 0 is the default value for all other
 controllers, the automatic check and fallback to LPIB as described in
 the above.  If you get a problem of repeated sounds, this option might
-- 
2.16.4
