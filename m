From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] vga_switcheroo: Add a helper function to
	get the client state
Date: Thu,  7 Jun 2012 12:15:15 +0200
Message-ID: <1339064116-18579-2-git-send-email-tiwai@suse.de>
References: <1339064116-18579-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A6F2110B97E
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:15:41 +0200 (CEST)
In-Reply-To: <1339064116-18579-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Airlie <airlied@linux.ie>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?q?J=C3=B6rg-Volker=20Peetz?= <jvpeetz@web.de>, dri-devel@lists.freedesktop.org, Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

Add vga_switcheroo_get_client_state() to get the current state of the
client.  This is necessary to determine the proper initial state of
audio clients in HD-audio driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c |   13 +++++++++++++
 include/linux/vga_switcheroo.h   |    9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 38f9534..eb4f64f 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -190,6 +190,19 @@ find_active_client(struct list_head *head)
 	return NULL;
 }
 
+int vga_switcheroo_get_client_state(struct pci_dev *pdev)
+{
+	struct vga_switcheroo_client *client;
+
+	client = find_client_from_pci(&vgasr_priv.clients, pdev);
+	if (!client)
+		return VGA_SWITCHEROO_NOT_FOUND;
+	if (!vgasr_priv.active)
+		return VGA_SWITCHEROO_INIT;
+	return client->pwr_state;
+}
+EXPORT_SYMBOL(vga_switcheroo_get_client_state);
+
 void vga_switcheroo_unregister_client(struct pci_dev *pdev)
 {
 	struct vga_switcheroo_client *client;
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index b455c7c..661fb7a 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -12,6 +12,9 @@
 enum vga_switcheroo_state {
 	VGA_SWITCHEROO_OFF,
 	VGA_SWITCHEROO_ON,
+	/* below are referred only from vga_switcheroo_get_client_state() */
+	VGA_SWITCHEROO_INIT,
+	VGA_SWITCHEROO_NOT_FOUND,
 };
 
 enum vga_switcheroo_client_id {
@@ -50,6 +53,8 @@ void vga_switcheroo_unregister_handler(void);
 
 int vga_switcheroo_process_delayed_switch(void);
 
+int vga_switcheroo_get_client_state(struct pci_dev *dev);
+
 #else
 
 static inline void vga_switcheroo_unregister_client(struct pci_dev *dev) {}
@@ -62,5 +67,9 @@ static inline int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 	int id, bool active) { return 0; }
 static inline void vga_switcheroo_unregister_handler(void) {}
 static inline int vga_switcheroo_process_delayed_switch(void) { return 0; }
+static inline int vga_switcheroo_get_client_state(struct pci_dev *dev) {
+	return VGA_SWITCHEROO_CLIENT_ON;
+}
+
 
 #endif
-- 
1.7.10.4
