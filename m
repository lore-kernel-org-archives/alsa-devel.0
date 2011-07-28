From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH alsa-lib 1/1] Add RME RPM to HDSP_IO_Type.
Date: Thu, 28 Jul 2011 23:24:25 +0200
Message-ID: <1311888265-27690-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The hdsp.c driver supports the RME RPM devices, but we also need this
information in alsa-lib for tools like hdsploader and hdspmixer.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/include/sound/hdsp.h b/include/sound/hdsp.h
index 0fc9e98..5adaf7b 100644
--- a/include/sound/hdsp.h
+++ b/include/sound/hdsp.h
@@ -28,6 +28,7 @@ typedef enum {
 	Multiface,
 	H9652,
 	H9632,
+	RPM,
 	Undefined,
 } HDSP_IO_Type;
 
-- 
1.7.5.4
