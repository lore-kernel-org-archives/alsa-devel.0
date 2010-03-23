From: linux@audioscience.com
Subject: [PATCH 4/7] Bump lib version due to added and removed
	APIs
Date: Tue, 23 Mar 2010 21:14:24 +1300
Message-ID: <1269332067-25959-5-git-send-email-linux@audioscience.com>
References: <1269332067-25959-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1269332067-25959-1-git-send-email-linux@audioscience.com>
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

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 61b3565..71ddd61 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -52,7 +52,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER HPI_VERSION_CONSTRUCTOR(4L, 3, 10)
 
 /* Library version as documented in hpi-api-versions.txt */
-#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(3, 5, 0)
+#define HPI_LIB_VER  HPI_VERSION_CONSTRUCTOR(9, 0, 0)
 
 #ifdef __cplusplus
 /* *INDENT-OFF* */
-- 
1.7.0.rc0.8.ge3f67d
