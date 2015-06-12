From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ALSA: gus: use swap() in
	snd_ics_put_double()
Date: Fri, 12 Jun 2015 18:58:59 +0200
Message-ID: <1434128340-10418-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay108.isp.belgacom.be (mailrelay108.isp.belgacom.be
 [195.238.20.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 742952604AA
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 18:59:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/isa/gus/gus_mixer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/isa/gus/gus_mixer.c b/sound/isa/gus/gus_mixer.c
index 0dd4341..3b5d9a7 100644
--- a/sound/isa/gus/gus_mixer.c
+++ b/sound/isa/gus/gus_mixer.c
@@ -109,7 +109,7 @@ static int snd_ics_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 	unsigned long flags;
 	int addr = kcontrol->private_value & 0xff;
 	int change;
-	unsigned char val1, val2, oval1, oval2, tmp;
+	unsigned char val1, val2, oval1, oval2;
 	
 	val1 = ucontrol->value.integer.value[0] & 127;
 	val2 = ucontrol->value.integer.value[1] & 127;
@@ -120,11 +120,8 @@ static int snd_ics_put_double(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 	gus->gf1.ics_regs[addr][0] = val1;
 	gus->gf1.ics_regs[addr][1] = val2;
 	if (gus->ics_flag && gus->ics_flipped &&
-	    (addr == SNDRV_ICS_GF1_DEV || addr == SNDRV_ICS_MASTER_DEV)) {
-		tmp = val1;
-		val1 = val2;
-		val2 = tmp;
-	}
+	    (addr == SNDRV_ICS_GF1_DEV || addr == SNDRV_ICS_MASTER_DEV))
+		swap(val1, val2);
 	addr <<= 3;
 	outb(addr | 0, GUSP(gus, MIXCNTRLPORT));
 	outb(1, GUSP(gus, MIXDATAPORT));
-- 
2.4.2
