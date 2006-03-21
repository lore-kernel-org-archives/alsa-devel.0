From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: ice1712.c CVS typos re Bug 1472 fix
Date: Tue, 21 Mar 2006 10:17:46 +0000
Message-ID: <200603211017.46885.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KL9HETE/ZJiKlyn"
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_KL9HETE/ZJiKlyn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I recently checked the functioning of 'dxr_enable' for DMX6fire you 
implemented on CVS, and noticed a couple of typos which I think are best 
sorted.  I've attached diff just to show the relevant lines.  L90 did 
initialise to 500; I don't know if you think the explicit ={0} is necessary.

However I would comment that the DXR extension (whatever that is -I've never 
seen one) is still unsupported, and surely unlikely ever to be so.  All 
DMX6fire specific code in ews.c etc assumes 6 DACs and ADCs, whereas the DXR 
is using 7 & 8.  Specific driver functions may also be needed.  Adding 
dxr_enable may give the false impression that it will work?  That is why I 
thought it was OK to disable it completely in the original bug 1472 fix.

With or without typo fix the original changes do work, turning on and off the 
unused connections depending on value of dxr_enable.

Regards  Alan

--Boundary-00=_KL9HETE/ZJiKlyn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="CVSice1712.c-179-typofix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="CVSice1712.c-179-typofix.diff"

--- alsa-kernel/pci/ice1712/ice1712.c-179	2006-03-20 22:16:21.000000000 +0000
+++ alsa-kernel/pci/ice1712/ice1712.c	2006-03-21 00:02:06.000000000 +0000
@@ -87,7 +87,7 @@
 static char *model[SNDRV_CARDS];
 static int omni[SNDRV_CARDS];	/* Delta44 & 66 Omni I/O support */
 static int cs8427_timeout[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 500}; /* CS8427 S/PDIF transciever reset timeout value in msec */
-static int dxr_enable[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 500}; /* DXR enable for DMX6FIRE */
+static int dxr_enable[SNDRV_CARDS] = {0};  /* DXR enable for DMX6FIRE Default=disabled */
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for ICE1712 soundcard.");
@@ -102,7 +102,7 @@
 module_param_array(model, charp, NULL, 0444);
 MODULE_PARM_DESC(model, "Use the given board model.");
 module_param_array(dxr_enable, int, NULL, 0444);
-MODULE_PARM_DESC(dsr_enable, "Enable DXR support for Terratec DMX6FIRE.");
+MODULE_PARM_DESC(dxr_enable, "Enable DXR support for Terratec DMX6FIRE.");


 static struct pci_device_id snd_ice1712_ids[] = {

--Boundary-00=_KL9HETE/ZJiKlyn--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
