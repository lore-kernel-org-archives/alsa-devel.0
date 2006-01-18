From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: [BUG] git-alsa.patch is bogus in 2.6.16-rc1-mm1
Date: Wed, 18 Jan 2006 20:54:40 +0100
Message-ID: <m2slrll3b3.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45235154
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 20:54:58 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: akpm@osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

git-alsa.patch is bogus in 2.6.16-rc1-mm1 since it constify
snd_pcm_format_name() whereas it's still exported (in
sound/core/pcm.c) AND used (in sound/usb/usbaudio.c)

thus one cannot compile 2.6.16-rc1-mm1 (at least with gcc-4.0.2) b/c
of the unknown exported symbol :-(

a proper fix is already in ALSA CVS:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix2.diff

Index: ./sound/core/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm.c,v
retrieving revision 1.63
retrieving revision 1.64
diff -u -r1.63 -r1.64
--- ./sound/core/pcm.c	16 Jan 2006 16:29:08 -0000	1.63
+++ ./sound/core/pcm.c	18 Jan 2006 11:50:40 -0000	1.64
@@ -1105,7 +1105,6 @@
 EXPORT_SYMBOL(snd_pcm_notify);
 EXPORT_SYMBOL(snd_pcm_open_substream);
 EXPORT_SYMBOL(snd_pcm_release_substream);
-EXPORT_SYMBOL(snd_pcm_format_name);
   /* pcm_native.c */
 EXPORT_SYMBOL(snd_pcm_link_rwlock);
 #ifdef CONFIG_PM
Index: usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.169
retrieving revision 1.170
diff -u -r1.169 -r1.170
--- ./sound/usb/usbaudio.c	16 Jan 2006 16:36:05 -0000	1.169
+++ ./sound/usb/usbaudio.c	18 Jan 2006 11:50:40 -0000	1.170
@@ -2029,7 +2029,7 @@
 		fp = list_entry(p, struct audioformat, list);
 		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
-		snd_iprintf(buffer, "    Format: %s\n", snd_pcm_format_name(fp->format));
+		snd_iprintf(buffer, "    Format: 0x%x\n", fp->format);
 		snd_iprintf(buffer, "    Channels: %d\n", fp->channels);
 		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
 			    fp->endpoint & USB_ENDPOINT_NUMBER_MASK,

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
