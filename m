From: linux@audioscience.com
Subject: [PATCH 2/6] Use version string instead of printf
	formatting.
Date: Tue, 06 Jul 2010 08:37:07 +1200
Message-ID: <1278362231-10160-3-git-send-email-linux@audioscience.com>
References: <1278362231-10160-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1278362231-10160-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/hpioctl.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/pci/asihpi/hpioctl.c b/pci/asihpi/hpioctl.c
index 7396ac5..3114999 100644
--- a/pci/asihpi/hpioctl.c
+++ b/pci/asihpi/hpioctl.c
@@ -464,9 +464,7 @@ void __init asihpi_init(void)
 
 	memset(adapters, 0, sizeof(adapters));
 
-	printk(KERN_INFO "ASIHPI driver %d.%02d.%02d\n",
-		HPI_VER_MAJOR(HPI_VER), HPI_VER_MINOR(HPI_VER),
-		HPI_VER_RELEASE(HPI_VER));
+	printk(KERN_INFO "ASIHPI driver " HPI_VER_STRING "\n");
 
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_SUBSYSTEM,
 		HPI_SUBSYS_DRIVER_LOAD);
-- 
1.7.0.4
