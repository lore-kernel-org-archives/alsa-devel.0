From: domen@coderock.org
Subject: [patch 2/3] delete unused file
Date: Sun, 26 Dec 2004 16:25:02 +0100
Message-ID: <20041226152446.988CE1ECC0@trashy.coderock.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 63689191
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 16:24:52 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, domen@coderock.org
List-Id: alsa-devel@alsa-project.org


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/sound/core/seq/oss/seq_oss_misc.c |  110 -----------------------------------
 1 files changed, 110 deletions(-)

diff -L sound/core/seq/oss/seq_oss_misc.c -puN sound/core/seq/oss/seq_oss_misc.c~remove_file-sound_core_seq_oss_seq_oss_misc.c /dev/null
--- kj/sound/core/seq/oss/seq_oss_misc.c
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,110 +0,0 @@
-/*----------------------------------------------------------------
- * miscellaneous functions
- *----------------------------------------------------------------*/
-
-unsigned short snd_seq_oss_semitone_tuning[24] = 
-{
-/*   0 */ 10000, 10595, 11225, 11892, 12599, 13348, 14142, 14983, 
-/*   8 */ 15874, 16818, 17818, 18877, 20000, 21189, 22449, 23784, 
-/*  16 */ 25198, 26697, 28284, 29966, 31748, 33636, 35636, 37755
-};
-
-unsigned short snd_seq_oss_cent_tuning[100] =
-{
-/*   0 */ 10000, 10006, 10012, 10017, 10023, 10029, 10035, 10041, 
-/*   8 */ 10046, 10052, 10058, 10064, 10070, 10075, 10081, 10087, 
-/*  16 */ 10093, 10099, 10105, 10110, 10116, 10122, 10128, 10134, 
-/*  24 */ 10140, 10145, 10151, 10157, 10163, 10169, 10175, 10181, 
-/*  32 */ 10187, 10192, 10198, 10204, 10210, 10216, 10222, 10228, 
-/*  40 */ 10234, 10240, 10246, 10251, 10257, 10263, 10269, 10275, 
-/*  48 */ 10281, 10287, 10293, 10299, 10305, 10311, 10317, 10323, 
-/*  56 */ 10329, 10335, 10341, 10347, 10353, 10359, 10365, 10371, 
-/*  64 */ 10377, 10383, 10389, 10395, 10401, 10407, 10413, 10419, 
-/*  72 */ 10425, 10431, 10437, 10443, 10449, 10455, 10461, 10467, 
-/*  80 */ 10473, 10479, 10485, 10491, 10497, 10503, 10509, 10515, 
-/*  88 */ 10521, 10528, 10534, 10540, 10546, 10552, 10558, 10564, 
-/*  96 */ 10570, 10576, 10582, 10589
-};
-
-/* convert from MIDI note to frequency */
-int
-snd_seq_oss_note_to_freq(int note_num)
-{
-
-	/*
-	 * This routine converts a midi note to a frequency (multiplied by 1000)
-	 */
-
-	int note, octave, note_freq;
-	static int notes[] = {
-		261632, 277189, 293671, 311132, 329632, 349232,
-		369998, 391998, 415306, 440000, 466162, 493880
-	};
-
-#define BASE_OCTAVE	5
-
-	octave = note_num / 12;
-	note = note_num % 12;
-
-	note_freq = notes[note];
-
-	if (octave < BASE_OCTAVE)
-		note_freq >>= (BASE_OCTAVE - octave);
-	else if (octave > BASE_OCTAVE)
-		note_freq <<= (octave - BASE_OCTAVE);
-
-	/*
-	 * note_freq >>= 1;
-	 */
-
-	return note_freq;
-}
-
-unsigned long
-snd_seq_oss_compute_finetune(unsigned long base_freq, int bend, int range, int vibrato_cents)
-{
-	unsigned long amount;
-	int negative, semitones, cents, multiplier = 1;
-
-	if (!bend || !range || !base_freq)
-		return base_freq;
-
-	if (range >= 8192)
-		range = 8192;
-
-	bend = bend * range / 8192;	/* Convert to cents */
-	bend += vibrato_cents;
-
-	if (!bend)
-		return base_freq;
-
-	negative = bend < 0 ? 1 : 0;
-
-	if (bend < 0)
-		bend *= -1;
-	if (bend > range)
-		bend = range;
-
-	/*
-	   if (bend > 2399)
-	   bend = 2399;
-	 */
-	while (bend > 2399) {
-		multiplier *= 4;
-		bend -= 2400;
-	}
-
-	semitones = bend / 100;
-	if (semitones > 99)
-		semitones = 99;
-	cents = bend % 100;
-
-	amount = (int) (snd_seq_oss_semitone_tuning[semitones] * multiplier *
-			snd_seq_oss_cent_tuning[cents]) / 10000;
-
-	if (negative)
-		return (base_freq * 10000) / amount;	/* Bend down */
-	else
-		return (base_freq * amount) / 10000;	/* Bend up */
-}
-
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
