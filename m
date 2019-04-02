From: Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH] ALSA: doc: my_chip has no element ioport
Date: Tue,  2 Apr 2019 14:16:48 +0200
Message-ID: <20190402121649.26536-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: trivial@kernel.org, Christina Quast <cquast@hanoverdisplays.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

chip->ioport is dereferenced in two places, but the struct is
defined as follows:

struct mychip {
	struct snd_card *card;
	struct pci_dev *pci;

	unsigned long port;
	int irq;
};

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 6b154dbb02cc..132f5eb9b530 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -324,7 +324,7 @@ to details explained in the following section.
               strcpy(card->driver, "My Chip");
               strcpy(card->shortname, "My Own Chip 123");
               sprintf(card->longname, "%s at 0x%lx irq %i",
-                      card->shortname, chip->ioport, chip->irq);
+                      card->shortname, chip->port, chip->irq);
 
               /* (5) */
               .... /* implemented later */
@@ -437,7 +437,7 @@ Since each component can be properly freed, the single
   strcpy(card->driver, "My Chip");
   strcpy(card->shortname, "My Own Chip 123");
   sprintf(card->longname, "%s at 0x%lx irq %i",
-          card->shortname, chip->ioport, chip->irq);
+          card->shortname, chip->port, chip->irq);
 
 The driver field holds the minimal ID string of the chip. This is used
 by alsa-lib's configurator, so keep it simple but unique. Even the
-- 
2.20.1
