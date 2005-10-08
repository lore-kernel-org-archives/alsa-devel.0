From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/2] Echoaudio, remove useless code
Date: Sat, 8 Oct 2005 12:47:10 +0000
Message-ID: <20051008124710.3fbb7da2.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


- The whole comm page was zeroed a few lines above.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c alsa-driver/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.c	2005-10-08 12:30:28.000000000 +0000
@@ -1000,8 +1000,6 @@ static int init_dsp_comm_page(echoaudio_
 	chip->comm_page->midi_out_free_count = __constant_cpu_to_le32(DSP_MIDI_OUT_FIFO_SIZE);
 	chip->comm_page->sample_rate = __constant_cpu_to_le32(44100);
 	chip->sample_rate = 44100;
-	for (i = 0; i < DSP_MAXAUDIOINPUTS; i++)
-		chip->comm_page->line_in_level[i] = 0;
 
 	/* Set line levels so we don't blast any inputs on startup */
 	memset(chip->comm_page->monitors, ECHOGAIN_MUTED, MONITOR_ARRAY_SIZE);


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
