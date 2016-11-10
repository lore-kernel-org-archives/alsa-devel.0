From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/30] ALSA: doc: ReSTize img,spdif-in.txt
Date: Thu, 10 Nov 2016 22:06:41 +0100
Message-ID: <20161110210641.5907-31-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B620B2673CC
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EA3A8ADFD
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Yet another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../img,spdif-in.txt => cards/img-spdif-in.rst}    | 24 +++++++++++++---------
 Documentation/sound/cards/index.rst                |  1 +
 2 files changed, 15 insertions(+), 10 deletions(-)
 rename Documentation/sound/{alsa/img,spdif-in.txt => cards/img-spdif-in.rst} (68%)

diff --git a/Documentation/sound/alsa/img,spdif-in.txt b/Documentation/sound/cards/img-spdif-in.rst
similarity index 68%
rename from Documentation/sound/alsa/img,spdif-in.txt
rename to Documentation/sound/cards/img-spdif-in.rst
index 8b7505785fa6..7df9f5ae2609 100644
--- a/Documentation/sound/alsa/img,spdif-in.txt
+++ b/Documentation/sound/cards/img-spdif-in.rst
@@ -1,21 +1,25 @@
+================================================
+Imagination Technologies SPDIF Input Controllers
+================================================
+
 The Imagination Technologies SPDIF Input controller contains the following
 controls:
 
-name='IEC958 Capture Mask',index=0
+* name='IEC958 Capture Mask',index=0
 
 This control returns a mask that shows which of the IEC958 status bits
 can be read using the 'IEC958 Capture Default' control.
 
-name='IEC958 Capture Default',index=0
+* name='IEC958 Capture Default',index=0
 
 This control returns the status bits contained within the SPDIF stream that
 is being received. The 'IEC958 Capture Mask' shows which bits can be read
 from this control.
 
-name='SPDIF In Multi Frequency Acquire',index=0
-name='SPDIF In Multi Frequency Acquire',index=1
-name='SPDIF In Multi Frequency Acquire',index=2
-name='SPDIF In Multi Frequency Acquire',index=3
+* name='SPDIF In Multi Frequency Acquire',index=0
+* name='SPDIF In Multi Frequency Acquire',index=1
+* name='SPDIF In Multi Frequency Acquire',index=2
+* name='SPDIF In Multi Frequency Acquire',index=3
 
 This control is used to attempt acquisition of up to four different sample
 rates. The active rate can be obtained by reading the 'SPDIF In Lock Frequency'
@@ -29,21 +33,21 @@ four sample rates set here.
 If less than four rates are required, the same rate can be specified more than
 once
 
-name='SPDIF In Lock Frequency',index=0
+* name='SPDIF In Lock Frequency',index=0
 
 This control returns the active capture rate, or 0 if a lock has not been
 acquired
 
-name='SPDIF In Lock TRK',index=0
+* name='SPDIF In Lock TRK',index=0
 
 This control is used to modify the locking/jitter rejection characteristics
 of the block. Larger values increase the locking range, but reduce jitter
 rejection.
 
-name='SPDIF In Lock Acquire Threshold',index=0
+* name='SPDIF In Lock Acquire Threshold',index=0
 
 This control is used to change the threshold at which a lock is acquired.
 
-name='SPDIF In Lock Release Threshold',index=0
+* name='SPDIF In Lock Release Threshold',index=0
 
 This control is used to change the threshold at which a lock is released.
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index 976ef5eb8f89..c016f8c3b88b 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -16,3 +16,4 @@ Card-Specific Information
    maya44
    hdspm
    serial-u16550
+   img-spdif-in
-- 
2.10.2
