From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/4] ALSA: hdspm - Fix midi port initialization
Date: Mon, 28 Feb 2011 15:14:50 +0100
Message-ID: <1298902490-10950-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298902490-10950-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298902490-10950-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Depending on the model and the presence of a TCO module, the number of
midi ports varies. Some have 1 port (MADIface), some have 2 (default),
with TCO, there are 3.

Don't hardcode the number of midi ports to initialize.

This patch also fixes a boot lockup on MADIface.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 78f6ab5..3224766 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6291,8 +6291,11 @@ static int __devinit snd_hdspm_create_pcm(struct snd_card *card,
 
 static inline void snd_hdspm_initialize_midi_flush(struct hdspm * hdspm)
 {
-	snd_hdspm_flush_midi_input(hdspm, 0);
-	snd_hdspm_flush_midi_input(hdspm, 1);
+	int i;
+
+	for (i=0; i < hdspm->midiPorts; i++) {
+		snd_hdspm_flush_midi_input(hdspm, i);
+	}
 }
 
 static int __devinit snd_hdspm_create_alsa_devices(struct snd_card *card,
-- 
1.7.4.1
