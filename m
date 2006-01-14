From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/4] echoaudio - minor changes
Date: Sat, 14 Jan 2006 18:03:03 +0000
Message-ID: <20060114180303.41b2610a.pochini@shiny.it>
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


Remove some dead code (Indigo's don't have S/PDIF connectors).


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/indigo_dsp.c alsa-driver/pci/echoaudio/indigo_dsp.c
--- alsa-driver__orig/pci/echoaudio/indigo_dsp.c	2006-01-12 21:28:52.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigo_dsp.c	2006-01-12 21:30:25.000000000 +0000
@@ -117,10 +117,6 @@ static int set_sample_rate(struct echoau
 		return -EINVAL;
 	}
 
-	/* Override the clock setting if this Mia is set to S/PDIF clock */
-	if (chip->input_clock == ECHO_CLOCK_SPDIF)
-		control_reg |= MIA_SPDIF;
-
 	/* Set the control register if it has changed */
 	if (control_reg != le32_to_cpu(chip->comm_page->control_register)) {
 		if (wait_handshake(chip))
diff -dup alsa-driver__orig/pci/echoaudio/indigodj_dsp.c alsa-driver/pci/echoaudio/indigodj_dsp.c
--- alsa-driver__orig/pci/echoaudio/indigodj_dsp.c	2006-01-12 21:28:52.000000000 +0000
+++ alsa-driver/pci/echoaudio/indigodj_dsp.c	2006-01-12 21:30:25.000000000 +0000
@@ -117,10 +117,6 @@ static int set_sample_rate(struct echoau
 		return -EINVAL;
 	}
 
-	/* Override the clock setting if this Mia is set to S/PDIF clock */
-	if (chip->input_clock == ECHO_CLOCK_SPDIF)
-		control_reg |= MIA_SPDIF;
-
 	/* Set the control register if it has changed */
 	if (control_reg != le32_to_cpu(chip->comm_page->control_register)) {
 		if (wait_handshake(chip))



--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
