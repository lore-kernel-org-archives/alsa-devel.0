From: linux@audioscience.com
Subject: [PATCH 11/15] Explicitly include mutex.h
Date: Fri, 22 Jul 2011 15:52:57 +1200
Message-ID: <1311306785-23116-23-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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

Because mutex is used in adapter struct defined here.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpios.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index 03273e7..2f605e3 100644
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -38,6 +38,7 @@ HPI Operating System Specific macros for Linux Kernel driver
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/mutex.h>
 
 #define HPI_NO_OS_FILE_OPS
 
-- 
1.7.0.4
