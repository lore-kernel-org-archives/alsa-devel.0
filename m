From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] properly print ELD sample bits
Date: Fri, 21 Nov 2008 09:42:59 +0800
Message-ID: <20081121014259.GA10607@localhost>
References: <1226542918.126598.6912@de> <20081119071135.GA17733@csy.ca>
	<20081119071757.GA32376@localhost> <20081119075545.GA19833@csy.ca>
	<20081119080800.GA522@localhost> <20081119093940.GA17245@localhost>
	<20081119200201.GA23246@csy.ca> <20081120010204.GA25454@localhost>
	<20081120200606.GA4164@csy.ca> <20081121013655.GA8992@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20081121013655.GA8992@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Shane W <shane-intel@csy.ca>, Takashi Iwai <tiwai@suse.de>
Cc: "Ma, Ling" <ling.ma@intel.com>, "Fu, Michael" <michael.fu@intel.com>, alsa-devel <alsa-devel@alsa-project.org>, intel-gfx@lists.freedesktop.org, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Fix bugs on printing the ELD sample bits.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c  |    2 +-
 sound/pci/hda/hda_proc.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -397,7 +397,7 @@ static void hdmi_show_short_audio_desc(s
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		snd_print_pcm_rates(a->sample_bits, buf2 + 8, sizeof(buf2 - 8));
+		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2 - 8));
 	else if (a->max_bitrate)
 		snprintf(buf2, sizeof(buf2),
 				", max bitrate = %d", a->max_bitrate);
--- sound-2.6.orig/sound/pci/hda/hda_proc.c
+++ sound-2.6/sound/pci/hda/hda_proc.c
@@ -120,7 +120,7 @@ void snd_print_pcm_bits(int pcm, char *b
 	int i, j;
 
 	for (i = 0, j = 0; i < ARRAY_SIZE(bits); i++)
-		if (pcm & (1 << i))
+		if (pcm & (AC_SUPPCM_BITS_8 << i))
 			j += snprintf(buf + j, buflen - j,  " %d", bits[i]);
 
 	buf[j] = '\0'; /* necessary when j == 0 */
@@ -130,7 +130,6 @@ static void print_pcm_bits(struct snd_in
 {
 	char buf[SND_PRINT_BITS_ADVISED_BUFSIZE];
 
-	pcm = (pcm >> 16) & 0xff;
 	snd_iprintf(buffer, "    bits [0x%x]:", pcm);
 	snd_print_pcm_bits(pcm, buf, sizeof(buf));
 	snd_iprintf(buffer, "%s\n", buf);
