From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 5/7] hda - document the ELD proc interface
Date: Sat, 22 Nov 2008 09:40:55 +0800
Message-ID: <20081122014309.276059273@linux.intel.com>
References: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AE531037FF
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:09:01 +0100 (CET)
Content-Disposition: inline; filename=alsa-hdmi-proc-doc.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Describe what ELD proc interface provides and how to fix incorrect values.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 Documentation/sound/alsa/Procfile.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- sound-2.6.orig/Documentation/sound/alsa/Procfile.txt
+++ sound-2.6/Documentation/sound/alsa/Procfile.txt
@@ -153,6 +153,16 @@ card*/codec#*
 	Shows the general codec information and the attribute of each
 	widget node.
 
+card*/eld#*
+	Available for HDMI or DisplayPort interfaces.
+	Shows ELD(EDID Like Data) info retrieved from the attached HDMI sink,
+	and describes its audio capabilities and configurations.
+
+	Some ELD fields may be modified by doing `echo name hex_value > eld#*`.
+	Only do this if you are sure the HDMI sink provided value is wrong.
+	And if that makes your HDMI audio work, please report to us so that we
+	can fix it in future kernel releases.
+
 
 Sequencer Information
 ---------------------

-- 
