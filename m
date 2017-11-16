From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: korg1212: Delete a duplicate
 function call "release_firmware" in snd_korg1212_create()
Date: Thu, 16 Nov 2017 12:52:41 +0100
Message-ID: <7b5b034c-e441-f363-a94f-c81bd0b5ed7a@users.sourceforge.net>
References: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 9753B266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 12:53:20 +0100 (CET)
In-Reply-To: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 11:22:26 +0100

The function "release_firmware" is called in the current implementation of
the function "_request_firmware" after a failure was detected.
Link: https://elixir.free-electrons.com/linux/v4.14-rc8/source/drivers/base/firmware_class.c#L1196

Such a call should therefore not be repeated directly after the
corresponding error information was received in the local variable "err"
of the function "snd_korg1212_create".
Thus remove a misplaced function call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/korg1212/korg1212.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 6dde8c215b48..dc701519d219 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2352,7 +2352,6 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
 	err = request_firmware(&dsp_code, "korg/k1212.dsp", &pci->dev);
 	if (err < 0) {
-		release_firmware(dsp_code);
 		snd_printk(KERN_ERR "firmware not available\n");
 		snd_korg1212_free(korg1212);
 		return err;
-- 
2.15.0
