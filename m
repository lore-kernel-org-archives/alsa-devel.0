From: linux@audioscience.com
Subject: [PATCH 28/28] HPI v4.06
Date: Thu, 10 Feb 2011 17:26:21 +1300
Message-ID: <1297311981-30448-29-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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

Firmware version check depends on hpi version. Update so correct firmware
is accepted.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index dec1c30..6fc025c 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -43,8 +43,8 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) ((int)(v & 0xFF))
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 5, 32)
-#define HPI_VER_STRING "4.05.32"
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 6, 0)
+#define HPI_VER_STRING "4.06.00"
 
 /* Library version as documented in hpi-api-versions.txt */
 #define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
-- 
1.7.0.4
