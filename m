From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: ac97: copy subsys values from the PCI
	device
Date: Thu, 17 Jul 2008 14:24:32 +0200
Message-ID: <487F3A00.6000705@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000002040805080104050207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 98CAF24402
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 14:22:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000002040805080104050207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Just getting to know to the code...

Why do we reread the subsys values from PCI config space in the AC97 code?

(this in addition to why we store the values in the ac97 struct in the 
first place if they're available through ac97->pci but that's secondary)

Rene.

--------------000002040805080104050207
Content-Type: text/plain;
 name="0001-ALSA-ac97-copy-subsys-values-from-the-PCI-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ALSA-ac97-copy-subsys-values-from-the-PCI-device.patch"

>From 01de5a42c7d5a0237895a476735028298203f30f Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Thu, 17 Jul 2008 14:18:10 +0200
Subject: [PATCH] ALSA: ac97: copy subsys values from the PCI device

copy the subsys values from the PCI device instead of rereading them.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ac97/ac97_codec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 45fd290..4f4343d 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2015,8 +2015,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 
 #ifdef CONFIG_PCI
 	if (ac97->pci) {
-		pci_read_config_word(ac97->pci, PCI_SUBSYSTEM_VENDOR_ID, &ac97->subsystem_vendor);
-		pci_read_config_word(ac97->pci, PCI_SUBSYSTEM_ID, &ac97->subsystem_device);
+		ac97->subsystem_vendor = ac97->pci->subsystem_vendor;
+		ac97->subsystem_device = ac97->pci->subsystem_device;
 	}
 #endif
 	if (bus->ops->reset) {
-- 
1.5.5


--------------000002040805080104050207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000002040805080104050207--
