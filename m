From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 20/22] ALSA: core - Define snd_pci_quirk
	without CONFIG_PCI
Date: Fri, 28 Feb 2014 15:41:31 -0800
Message-ID: <1393630893-29010-21-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f201.google.com (mail-yk0-f201.google.com
 [209.85.160.201])
 by alsa0.perex.cz (Postfix) with ESMTP id A812B2659BA
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-yk0-f201.google.com with SMTP id 142so521993ykq.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

The hda codecs all use this struct and, with an HDA platform driver,
will be able to be built without PCI.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 include/sound/core.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index aac9a85..d3f5f81 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -433,7 +433,6 @@ static inline void snd_printdd(const char *format, ...) {}
 #define gameport_get_port_data(gp) (gp)->port_data
 #endif
 
-#ifdef CONFIG_PCI
 /* PCI quirk list helper */
 struct snd_pci_quirk {
 	unsigned short subvendor;	/* PCI subvendor ID */
@@ -469,12 +468,26 @@ struct snd_pci_quirk {
 #define snd_pci_quirk_name(q)	""
 #endif
 
+#ifdef CONFIG_PCI
 const struct snd_pci_quirk *
 snd_pci_quirk_lookup(struct pci_dev *pci, const struct snd_pci_quirk *list);
 
 const struct snd_pci_quirk *
 snd_pci_quirk_lookup_id(u16 vendor, u16 device,
 			const struct snd_pci_quirk *list);
+#else
+static inline const struct snd_pci_quirk *
+snd_pci_quirk_lookup(struct pci_dev *pci, const struct snd_pci_quirk *list)
+{
+	return NULL;
+}
+
+static inline const struct snd_pci_quirk *
+snd_pci_quirk_lookup_id(u16 vendor, u16 device,
+			const struct snd_pci_quirk *list)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __SOUND_CORE_H */
-- 
1.8.1.3.605.g02339dd
