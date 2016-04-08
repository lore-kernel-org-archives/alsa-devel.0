From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [linux-next]:ALSA: Fix a typo in
	timestamping.txt
Date: Fri,  8 Apr 2016 12:45:25 +0900
Message-ID: <1460087125-5402-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F458260824
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 05:45:26 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id zm5so67013401pac.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2016 20:45:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>, corbet@lwn.net
List-Id: alsa-devel@alsa-project.org

This patch fix a spelling typo found in
Documentation/sound/alsa/timestamping.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/sound/alsa/timestamping.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa/timestamping.txt b/Documentation/sound/alsa/timestamping.txt
index 0b191a23f534..1b6473f393a8 100644
--- a/Documentation/sound/alsa/timestamping.txt
+++ b/Documentation/sound/alsa/timestamping.txt
@@ -129,7 +129,7 @@ will be required to issue multiple queries and perform an
 interpolation of the results
 
 In some hardware-specific configuration, the system timestamp is
-latched by a low-level audio subsytem, and the information provided
+latched by a low-level audio subsystem, and the information provided
 back to the driver. Due to potential delays in the communication with
 the hardware, there is a risk of misalignment with the avail and delay
 information. To make sure applications are not confused, a
-- 
2.8.0
