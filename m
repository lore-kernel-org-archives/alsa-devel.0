From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] standard control names for the rme96
Date: Thu, 10 Apr 2003 21:02:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030410190218.GA6650@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: torger@ludd.luth.se, rv@robertvetter.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

here is a patch for the Digi96 driver "alsa-kernel/pci/rme96.c" against
latest CVS. It will change the "Clock Mode" switch to standard names.
The standards are defined in alsa-kernel/Documentation/ControlNames.txt and
that one is labeled there as "Sample Clock Source".

My machine compiles fine with this patch, but I have no rme96 card for
trying it out. 

IMO this patch is necessary to keep the new rmedigicontrol as simple as
possible.... 


martin

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme96_controlnames.diff"

--- alsa-kernel/pci/rme96.c.ORIGINAL	Thu Apr 10 20:08:28 2003
+++ alsa-kernel/pci/rme96.c	Thu Apr 10 20:19:30 2003
@@ -806,10 +806,12 @@
 {
 	switch (mode) {
 	case RME96_CLOCKMODE_SLAVE:
+	        /* AutoSync */ 
 		rme96->wcreg &= ~RME96_WCR_MASTER;
 		rme96->areg &= ~RME96_AR_WSEL;
 		break;
 	case RME96_CLOCKMODE_MASTER:
+	        /* Internal */
 		rme96->wcreg |= RME96_WCR_MASTER;
 		rme96->areg &= ~RME96_AR_WSEL;
 		break;
@@ -1861,15 +1863,15 @@
 		snd_iprintf(buffer, "  sample format: 16 bit\n");
 	}
 	if (rme96->areg & RME96_AR_WSEL) {
-		snd_iprintf(buffer, "  clock mode: word clock\n");
+		snd_iprintf(buffer, "  sample clock source: word clock\n");
 	} else if (rme96->wcreg & RME96_WCR_MASTER) {
-		snd_iprintf(buffer, "  clock mode: master\n");
+		snd_iprintf(buffer, "  sample clock source: internal\n");
 	} else if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
-		snd_iprintf(buffer, "  clock mode: slave (master anyway due to analog input setting)\n");
+		snd_iprintf(buffer, "  sample clock source: autosync (internal anyway due to analog input setting)\n");
 	} else if (snd_rme96_capture_getrate(rme96, &n) < 0) {
-		snd_iprintf(buffer, "  clock mode: slave (master anyway due to no valid signal)\n");
+		snd_iprintf(buffer, "  sample clock source: autosync (internal anyway due to no valid signal)\n");
 	} else {
-		snd_iprintf(buffer, "  clock mode: slave\n");
+		snd_iprintf(buffer, "  sample clock source: autosync\n");
 	}
 	if (rme96->wcreg & RME96_WCR_PRO) {
 		snd_iprintf(buffer, "  format: AES/EBU (professional)\n");
@@ -2094,7 +2096,7 @@
 static int
 snd_rme96_info_clockmode_control(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[3] = { "Slave", "Master", "Wordclock" };
+	static char *texts[3] = { "AutoSync", "Internal", "Word" };
 	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -2417,7 +2419,7 @@
 },
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         "Clock Mode",
+	.name =         "Sample Clock Source",
 	.info =         snd_rme96_info_clockmode_control, 
 	.get =          snd_rme96_get_clockmode_control,
 	.put =          snd_rme96_put_clockmode_control

--+QahgC5+KEYLbs62--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
