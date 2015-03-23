From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: echoaudio: read past end of array
Date: Mon, 23 Mar 2015 12:41:31 +0300
Message-ID: <20150323094131.GE558@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id C96172604F8
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 10:41:42 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Sachin Kamat <sachin.kamat@samsung.com>
List-Id: alsa-devel@alsa-project.org

We need to cap "ucontrol->id.index / num_busses_in(chip)" so the we
don't read beyond the end of the array.

I also adding a check on "in" and changing the type in
snd_echo_mixer_put() from short to unsigned int. Those changes are done
for symmetry and are cosmetic.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index a962de0..862db9a 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1283,12 +1283,14 @@ static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 static int snd_echo_mixer_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct echoaudio *chip;
+	struct echoaudio *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int out = ucontrol->id.index / num_busses_in(chip);
+	unsigned int in = ucontrol->id.index % num_busses_in(chip);
 
-	chip = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.integer.value[0] =
-		chip->monitor_gain[ucontrol->id.index / num_busses_in(chip)]
-			[ucontrol->id.index % num_busses_in(chip)];
+	if (out >= ECHO_MAXAUDIOOUTPUTS || in >= ECHO_MAXAUDIOINPUTS)
+		return -EINVAL;
+
+	ucontrol->value.integer.value[0] = chip->monitor_gain[out][in];
 	return 0;
 }
 
@@ -1297,12 +1299,14 @@ static int snd_echo_mixer_put(struct snd_kcontrol *kcontrol,
 {
 	struct echoaudio *chip;
 	int changed,  gain;
-	short out, in;
+	unsigned int out, in;
 
 	changed = 0;
 	chip = snd_kcontrol_chip(kcontrol);
 	out = ucontrol->id.index / num_busses_in(chip);
 	in = ucontrol->id.index % num_busses_in(chip);
+	if (out >= ECHO_MAXAUDIOOUTPUTS || in >= ECHO_MAXAUDIOINPUTS)
+		return -EINVAL;
 	gain = ucontrol->value.integer.value[0];
 	if (gain < ECHOGAIN_MINOUT || gain > ECHOGAIN_MAXOUT)
 		return -EINVAL;
