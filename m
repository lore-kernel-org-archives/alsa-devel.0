From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/3] echoaudio - minor changes
Date: Sat, 14 Jan 2006 18:03:26 +0000
Message-ID: <20060114180326.3afba01a.pochini@shiny.it>
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


Fix wrong comments.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__indi0/pci/echoaudio/indigo_dsp.c alsa-driver/pci/echoaudio/indigo_dsp.c
--- alsa-driver__indi0/pci/echoaudio/indigo_dsp.c	2006-01-12 21:30:25.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigo_dsp.c	2006-01-12 21:35:13.000000000 +0000
@@ -84,7 +84,7 @@ static u32 detect_input_clocks(const str
 
 
 
-/* The Mia has no ASIC. Just do nothing */
+/* The Indigo has no ASIC. Just do nothing */
 static int load_asic(struct echoaudio *chip)
 {
 	return 0;
diff -dup alsa-driver__indi0/pci/echoaudio/indigodj_dsp.c alsa-driver/pci/echoaudio/indigodj_dsp.c
--- alsa-driver__indi0/pci/echoaudio/indigodj_dsp.c	2006-01-12 21:30:25.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigodj_dsp.c	2006-01-12 21:35:13.000000000 +0000
@@ -84,7 +84,7 @@ static u32 detect_input_clocks(const str
 
 
 
-/* The Mia has no ASIC. Just do nothing */
+/* The IndigoDJ has no ASIC. Just do nothing */
 static int load_asic(struct echoaudio *chip)
 {
 	return 0;
diff -dup alsa-driver__indi0/pci/echoaudio/indigoio_dsp.c alsa-driver/pci/echoaudio/indigoio_dsp.c
--- alsa-driver__indi0/pci/echoaudio/indigoio_dsp.c	2006-01-12 21:30:25.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigoio_dsp.c	2006-01-12 21:35:13.000000000 +0000
@@ -84,7 +84,7 @@ static u32 detect_input_clocks(const str
 
 
 
-/* The Mia has no ASIC. Just do nothing */
+/* The IndigoIO has no ASIC. Just do nothing */
 static int load_asic(struct echoaudio *chip)
 {
 	return 0;


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
