From: han.lu@intel.com
Subject: [PATCH 1/1] BAT: Add default device name for playback
	and capture
Date: Wed, 28 Oct 2015 16:12:29 +0800
Message-ID: <1446019949-14913-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8191C2605EA
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 09:15:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, caleb@crome.org, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

If the playback device and the capture device was not set through
'-D', '-P' or '-C' options, set the name of the two devices to
"default". So by default, BAT will work through PulseAudio sound
server on Ubuntu/Debian, and work though CRAS sound server on
Chromium OS/Chrome OS.

If the playback device or the capture device was set through '-D',
'-P' or '-C' options by user, the device name "default" will not
be set.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/bat.c b/bat/bat.c
index 086b9fa..4310be0 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -473,6 +473,10 @@ static int bat_init(struct bat *bat)
 			return err;
 	}
 
+	/* Set default playback and capture devices */
+	if (bat->playback.device == NULL && bat->capture.device == NULL)
+		bat->playback.device = bat->capture.device = "default";
+
 	/* Determine capture file */
 	if (bat->local) {
 		bat->capture.file = bat->playback.file;
-- 
1.9.1
