From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Fix revision display from cat /proc/asound/card0/ac97#0
Date: Fri, 03 Oct 2003 17:00:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F7D9D2A.5030103@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090300000708050706080109"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090300000708050706080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the display of revision number for ALC650 AC97 chip.
"alsamixer"
displayed the correct revision, but
"cat /proc/asound/card0/ac97#0"
did not.

Cheers
James

--------------090300000708050706080109
Content-Type: text/plain;
 name="ac97_proc-rev-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_proc-rev-fix.diff"

--- ac97_proc.c.org	2003-10-03 16:07:16.578344016 +0100
+++ ac97_proc.c	2003-10-03 16:56:14.184759960 +0100
@@ -37,15 +37,12 @@
 static void snd_ac97_proc_read_main(ac97_t *ac97, snd_info_buffer_t * buffer, int subidx)
 {
 	char name[64];
-	unsigned int id;
 	unsigned short val, tmp, ext, mext;
 	static const char *spdif_slots[4] = { " SPDIF=3/4", " SPDIF=7/8", " SPDIF=6/9", " SPDIF=res" };
 	static const char *spdif_rates[4] = { " Rate=44.1kHz", " Rate=res", " Rate=48kHz", " Rate=32kHz" };
 	static const char *spdif_rates_cs4205[4] = { " Rate=48kHz", " Rate=44.1kHz", " Rate=res", " Rate=res" };
 
-	id = snd_ac97_read(ac97, AC97_VENDOR_ID1) << 16;
-	id |= snd_ac97_read(ac97, AC97_VENDOR_ID2);
-	snd_ac97_get_name(NULL, id, name, 0);
+	snd_ac97_get_name(NULL, ac97->id, name, 0);
 	snd_iprintf(buffer, "%d-%d/%d: %s\n\n", ac97->addr, ac97->num, subidx, name);
 	if ((ac97->scaps & AC97_SCAP_AUDIO) == 0)
 		goto __modem;

--------------090300000708050706080109--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
