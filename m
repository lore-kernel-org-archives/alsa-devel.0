From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] standard control names for the rme96
Date: Mon, 12 May 2003 01:54:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030511235421.GA3610@tuba.home>
References: <200305111919.h4BJJwlI038695@mail.mega.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200305111919.h4BJJwlI038695@mail.mega.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Pouzzner <douzzer@mega.nu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 11, 2003 at 03:19:58PM -0400, Daniel Pouzzner wrote:
> Did this get resolved?  I have an RME96 on which I can test code for
> you if you still need that done.
> 

Hi Daniel,

thanks for your reply. This patch is still in a state of "untested". It would
be nice if you can try it out. The patched driver should run fine with the
graphical frontend 
http://www.langerland.de/rme32/rmedigiXXcontrol-0.3.4.tar.gz 

The newer version http://www.langerland.de/rme32/rmedigicontrol-0.3.5.tar.gz
has a workaround included and runs only with an unpatched driver. But my
preferred solution would be without a workaround... next version...


Martin


BTW: The CVS-Patch for alsa-kernel/pci/rme96.c is attached.

--7AUc2qLy4jB3hD7Z
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

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
