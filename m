From: Satyam Sharma <satyam@infradead.org>
Subject: [PATCH -mm] sb16: Shut up uninitialized var build warning
Date: Mon, 3 Sep 2007 01:45:00 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0709030143550.29617@enigma.security.iitk.ac.in>
References: <alpine.LFD.0.999.0709022344550.27844@enigma.security.iitk.ac.i
 n>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="464262402-680809842-1188764104=:29617"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759405AbXIBUCI@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.999.0709022344550.27844@enigma.security.iitk.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--464262402-680809842-1188764104=:29617
Content-Type: TEXT/PLAIN; charset=iso-2022-jp


sound/isa/sb16/sb16.c: In function ‘snd_sb16_isa_probe’:
sound/isa/sb16/sb16.c:559: warning: ‘err’ may be used uninitialized in this function

is a bogus warning, so let's shut it up.

Signed-off-by: Satyam Sharma <satyam@infradead.org>

---

 sound/isa/sb/sb16.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.23-rc4-mm1/sound/isa/sb/sb16.c~fix	2007-09-02 21:41:51.000000000 +0530
+++ linux-2.6.23-rc4-mm1/sound/isa/sb/sb16.c	2007-09-02 21:42:56.000000000 +0530
@@ -556,7 +556,6 @@ static int __devinit snd_sb16_isa_match(
 
 static int __devinit snd_sb16_isa_probe(struct device *pdev, unsigned int dev)
 {
-	int err;
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
 	static int possible_dmas8[] = {1, 3, 0, -1};
 	static int possible_dmas16[] = {5, 6, 7, -1};
@@ -585,6 +584,8 @@ static int __devinit snd_sb16_isa_probe(
 	else {
 		static int possible_ports[] = {0x220, 0x240, 0x260, 0x280};
 		int i;
+		int uninitialized_var(err);
+
 		for (i = 0; i < ARRAY_SIZE(possible_ports); i++) {
 			port[dev] = possible_ports[i];
 			err = snd_sb16_isa_probe1(dev, pdev);
--464262402-680809842-1188764104=:29617--
