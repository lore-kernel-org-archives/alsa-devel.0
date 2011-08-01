From: linux@audioscience.com
Subject: [PATCH] ALSA: asihpi - Clarify adapter index validity
	check
Date: Tue, 02 Aug 2011 09:44:24 +1200
Message-ID: <1312235064-4767-1-git-send-email-linux@audioscience.com>
References: <s5hsjpp64cz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <s5hsjpp64cz.wl%tiwai@suse.de>
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

Avoids assigning possibly invalid address to pa, even if it
is never dereferenced.
Correct error response to reflect request object/function ids.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpioctl.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 9683f84..a32502e 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -177,16 +177,21 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	} else {
 		u16 __user *ptr = NULL;
 		u32 size = 0;
-
+		u32 adapter_present;
 		/* -1=no data 0=read from user mem, 1=write to user mem */
 		int wrflag = -1;
-		u32 adapter = hm->h.adapter_index;
-		struct hpi_adapter *pa = &adapters[adapter];
+		struct hpi_adapter *pa;
+
+		if (hm->h.adapter_index < HPI_MAX_ADAPTERS) {
+			pa = &adapters[hm->h.adapter_index];
+			adapter_present = pa->type;
+		} else {
+			adapter_present = 0;
+		}
 
-		if ((adapter >= HPI_MAX_ADAPTERS) || (!pa->type)) {
-			hpi_init_response(&hr->r0, HPI_OBJ_ADAPTER,
-				HPI_ADAPTER_OPEN,
-				HPI_ERROR_BAD_ADAPTER_NUMBER);
+		if (!adapter_present) {
+			hpi_init_response(&hr->r0, hm->h.object,
+				hm->h.function, HPI_ERROR_BAD_ADAPTER_NUMBER);
 
 			uncopied_bytes =
 				copy_to_user(puhr, hr, sizeof(hr->h));
-- 
1.7.0.4
