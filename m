From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] sound: fix include/sound/core.h warning
Date: Mon, 30 Jan 2012 11:42:51 -0800
Message-ID: <4F26F2BB.6070701@xenotime.net>
References: <20120130144102.8d202c7d8eccd503a86b3053@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120130144102.8d202c7d8eccd503a86b3053@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build warning by providing a struct stub since no fields of
the struct are used:

include/sound/core.h:454:56: warning: 'struct pci_dev' declared inside parameter list

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Jaroslav Kysela <perex@perex.cz>
Cc:	Takashi Iwai <tiwai@suse.de>
Cc:	alsa-devel@alsa-project.org
---
 include/sound/core.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20120130.orig/include/sound/core.h
+++ linux-next-20120130/include/sound/core.h
@@ -450,6 +450,8 @@ struct snd_pci_quirk {
 	{_SND_PCI_QUIRK_ID_MASK(vend, 0, 0), .value = (val)}
 #endif
 
+struct pci_dev;
+
 const struct snd_pci_quirk *
 snd_pci_quirk_lookup(struct pci_dev *pci, const struct snd_pci_quirk *list);
 
