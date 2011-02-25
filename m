From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 19/21]sound:pci:emu10k1:emu10k1_main.c remove
	one to many l's in the word.
Date: Thu, 24 Feb 2011 22:15:42 -0800
Message-ID: <1298614542-4192-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E76D1037EC
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 07:16:02 +0100 (CET)
Received: by yib2 with SMTP id 2so717228yib.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 22:16:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: trivial@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch below removes an extra "l" in the word.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 sound/pci/emu10k1/emu10k1_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 66c7fb3..5e619a8 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -926,7 +926,7 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_IN, 0x19);
 	/* Unknown. */
 	snd_emu1010_fpga_write(emu, EMU_HANA_MIDI_OUT, 0x0c);
-	/* IRQ Enable: Alll on */
+	/* IRQ Enable: All on */
 	/* snd_emu1010_fpga_write(emu, 0x09, 0x0f ); */
 	/* IRQ Enable: All off */
 	snd_emu1010_fpga_write(emu, EMU_HANA_IRQ_ENABLE, 0x00);
-- 
1.7.4.1
