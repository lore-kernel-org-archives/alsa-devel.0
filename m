From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/3] sound/pci: Eliminate use after free
Date: Fri, 2 Apr 2010 14:47:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004021447390.17695@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Use the call to snd_card_free in the error handling code at the end of the
function, as in the other error cases.

A simplified version of the semantic patch that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E,E2;
@@

snd_card_free(E)
...
(
  E = E2
|
* E
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/pci/echoaudio/echoaudio.c     |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 8dab82d..668a5ec 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2184,10 +2184,9 @@ static int __devinit snd_echo_probe(struct pci_dev *pci,
 			goto ctl_error;
 #endif
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
+	err = snd_card_register(card);
+	if (err < 0)
 		goto ctl_error;
-	}
 	snd_printk(KERN_INFO "Card registered: %s\n", card->longname);
 
 	pci_set_drvdata(pci, chip);
