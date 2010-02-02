From: linux@audioscience.com
Subject: [PATCH] Make firmware vs driver major version mismatch
	an error.
Date: Wed, 03 Feb 2010 10:07:37 +1300
Message-ID: <1265144857-13808-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

I.e. incompatible firmware will fail driver load.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpidspcd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/pci/asihpi/hpidspcd.c b/pci/asihpi/hpidspcd.c
index 8c0f251..f58d5a0 100644
--- a/pci/asihpi/hpidspcd.c
+++ b/pci/asihpi/hpidspcd.c
@@ -103,6 +103,13 @@ short HpiDspCode_Open(
 		goto error2;
 	}
 
+	if (header.version / 10000 != HPI_VER_DECIMAL / 10000) {
+		HPI_DEBUG_LOG(ERROR,
+			"Firmware Major Version mismatch  DSP image %d != Driver %d\n",
+			header.version, HPI_VER_DECIMAL);
+		goto error2;
+	}
+
 	if (header.version != HPI_VER_DECIMAL) {
 		HPI_DEBUG_LOG(WARNING,
 			"Version mismatch  DSP image %d != Driver %d\n",
-- 
1.7.0.rc0.8.ge3f67d
