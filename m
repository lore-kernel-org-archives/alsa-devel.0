From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] standard control names for the rme96
Date: Wed, 7 May 2003 22:52:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030507205250.GE490@tuba.home>
References: <20030410190218.GA6650@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030410190218.GA6650@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2003 at 09:02:18PM +0200, Martin Langer wrote:
> 
> here is a patch for the Digi96 driver "alsa-kernel/pci/rme96.c" against
> latest CVS. It will change the "Clock Mode" switch to standard names.
> 
> My machine compiles fine with this patch, but I have no rme96 card for
> trying it out. 
> 

now (nearly a month later):
Do we have today one rme96 user for testing out?

Or is that patch not wanted and everybody would prefer an additional "if"
in the control tool code instead of introducing standard names for rme96?


martin


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme96.diff"

--- rme96.c	Wed May  7 22:24:15 2003
+++ rme96.c.PATCHED	Sat May  3 19:34:45 2003
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
@@ -1862,15 +1864,15 @@
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
@@ -2095,7 +2097,7 @@
 static int
 snd_rme96_info_clockmode_control(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[3] = { "Slave", "Master", "Wordclock" };
+	static char *texts[3] = { "AutoSync", "Internal", "Word" };
 	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -2418,7 +2420,7 @@
 },
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         "Clock Mode",
+	.name =         "Sample Clock Source",
 	.info =         snd_rme96_info_clockmode_control, 
 	.get =          snd_rme96_get_clockmode_control,
 	.put =          snd_rme96_put_clockmode_control

--fdj2RfSjLxBAspz7--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
