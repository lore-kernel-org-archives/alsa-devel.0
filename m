From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 17/31] ALSA: hdspm - Introduce
	hdspm_get_aes_sample_rate()
Date: Fri,  5 Jul 2013 11:28:09 +0200
Message-ID: <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
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

Helper function to return the AES sample rate class. This class needs to
be translated via HDSPM_bit2freq() to get the more common
representation.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8e6ce14..b7702b2 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2224,6 +2224,23 @@ static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 	return 0;
 }
 
+/**
+ * Returns the AES sample rate class for the given card.
+ **/
+static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index)
+{
+	int timecode;
+
+	switch (hdspm->io_type) {
+	case AES32:
+		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
+		return (timecode >> (4*index)) & 0xF;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
 
 /**
  * Returns the sample rate class for input source <idx> for
-- 
1.8.3.1
