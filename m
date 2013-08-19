From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] hdspm.h: Update LTC ioctl to use struct
	hdspm_ltc
Date: Mon, 19 Aug 2013 17:31:37 +0200
Message-ID: <1376926297-6028-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1376926297-6028-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1376926297-6028-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use struct hdspm_ltc to query the LTC, using a mixer struct was just
plain wrong.

Due to the wrong struct, this ioctl was never working, so we're free to
fix it without breaking userspace compatibility.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/include/sound/hdspm.h b/include/sound/hdspm.h
index 1774ff5..fe9c5f6 100644
--- a/include/sound/hdspm.h
+++ b/include/sound/hdspm.h
@@ -111,7 +111,7 @@ struct hdspm_ltc {
 	enum hdspm_ltc_input_format input_format;
 };
 
-#define SNDRV_HDSPM_IOCTL_GET_LTC _IOR('H', 0x46, struct hdspm_mixer_ioctl)
+#define SNDRV_HDSPM_IOCTL_GET_LTC _IOR('H', 0x46, struct hdspm_ltc)
 
 /**
  * The status data reflects the device's current state
-- 
1.8.3.2
