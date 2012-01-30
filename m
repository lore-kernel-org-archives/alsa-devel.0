From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ALSA: Add #ifdef CONFIG_PCI guard for
 snd_pci_quirk_* functions
Date: Mon, 30 Jan 2012 17:10:58 +0800
Message-ID: <1327914658.4520.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F4042455F
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 10:11:08 +0100 (CET)
Received: by ggm4 with SMTP id 4so1765690ggm.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 01:11:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This fixes below build warning when CONFIG_PCI is not set.

CC      sound/sound_core.o
In file included from sound/sound_core.c:15:
include/sound/core.h:454: warning: 'struct pci_dev' declared inside parameter list
include/sound/core.h:454: warning: its scope is only this definition or declaration, which is probably not what you want

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
v2:
begin the ifdef including the definition of struct snd_pci_quirk.

 include/sound/core.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 5ab255f..cea1b54 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -417,6 +417,7 @@ static inline int __snd_bug_on(int cond)
 #define gameport_get_port_data(gp) (gp)->port_data
 #endif
 
+#ifdef CONFIG_PCI
 /* PCI quirk list helper */
 struct snd_pci_quirk {
 	unsigned short subvendor;	/* PCI subvendor ID */
@@ -456,5 +457,6 @@ snd_pci_quirk_lookup(struct pci_dev *pci, const struct snd_pci_quirk *list);
 const struct snd_pci_quirk *
 snd_pci_quirk_lookup_id(u16 vendor, u16 device,
 			const struct snd_pci_quirk *list);
+#endif
 
 #endif /* __SOUND_CORE_H */
-- 
1.7.5.4
