From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Coding style: bit fields
Date: Sat, 26 Feb 2005 19:59:18 +0100
Message-ID: <20050226195918.0a87bc8f.pochini@shiny.it>
References: <20050219183726.5d76f588.pochini@shiny.it>
	<s5hbractign.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hbractign.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Feb 2005 22:04:08 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 19 Feb 2005 18:37:26 +0100,
> Giuliano Pochini wrote:
> > 
> > The echoaudio driver has many flags in chip_t stored as bit fields. It
> > doesn't save any space because accessing a bitfield requires more
> > instructions than accessing a byte. Eg. ppc needs one instruction to write a
> > char and three instructions to write a bitfield (load, modify, store, 12
> > bytes...). I'm thinking about replacing all af them with chars. Is it ok ?
> 
> Sure, go ahead!

Fine.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver_orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver_orig/pci/echoaudio/echoaudio.h	Sat Feb 26 19:35:54 2005
+++ alsa-driver/pci/echoaudio/echoaudio.h	Sat Feb 26 12:57:18 2005
@@ -389,15 +389,15 @@
 	u8 input_clock;				/* Currently selected sample clock source */
 	u8 output_clock;			/* Layla20 only */
 
-	unsigned int meters_enabled : 1;	/* VU-meters status */
-	unsigned int asic_loaded : 1;		/* Set TRUE when ASIC loaded */
-	unsigned int bad_board : 1;		/* Set TRUE if DSP won't load */
-	unsigned int professional_spdif : 1;	/* 0 = consumer; 1 = professional */
-	unsigned int non_audio_spdif : 1;	/* 3G - only */
-	unsigned int digital_in_automute : 1;	/* Gina24, Layla24, Mona - only */
-	unsigned int phantom_power : 1;		/* Gina3G - only */
-	unsigned int has_midi : 1;
-	unsigned int midi_input_enabled : 1;
+	char meters_enabled;			/* VU-meters status */
+	char asic_loaded;			/* Set TRUE when ASIC loaded */
+	char bad_board;				/* Set TRUE if DSP won't load */
+	char professional_spdif;		/* 0 = consumer; 1 = professional */
+	char non_audio_spdif;			/* 3G - only */
+	char digital_in_automute;		/* Gina24, Layla24, Mona - only */
+	char phantom_power;			/* Gina3G - only */
+	char has_midi;
+	char midi_input_enabled;
 
 	char nominal_level[ECHO_MAXAUDIOPIPES];	/* True == -10dBV  False == +4dBu */
 	s8 input_gain[ECHO_MAXAUDIOINPUTS];	/* Input level -50..+50 unit is 0.5dB */



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
