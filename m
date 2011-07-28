From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] hdsploader: Add support for RME RPM
Date: Thu, 28 Jul 2011 23:45:47 +0200
Message-ID: <1311889548-28617-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Augment hdsploader to support the RME RPM devices. The firmware is
already present in alsa-firmware, so we can directly load it.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdsploader/hdsploader.c b/hdsploader/hdsploader.c
index d1855b1..fa488a2 100644
--- a/hdsploader/hdsploader.c
+++ b/hdsploader/hdsploader.c
@@ -86,6 +86,9 @@ void upload_firmware(int card)
 	    err = read_bin_file(code, DATAPATH "/digiface_firmware_rev11.bin");
 	}
 	break;
+    case RPM:
+	err = read_bin_file(code, DATAPATH "/rpm_firmware.bin");
+	break;
     default:
 	fprintf(stderr, "Unknown iobox or firmware revision\n");
 	snd_hwdep_close(hw);
-- 
1.7.5.4
