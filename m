From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] usbusx2yaudio.c: remove an unused variable
Date: Sun, 30 Jan 2005 14:03:14 +0100
Message-ID: <20050130130314.GL3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id AC2141AE
	for <alsa-devel@alsa-project.org>; Sun, 30 Jan 2005 14:03:15 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: greg@kroah.com, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In 2.6.11-rc a completely unused variable was added, resulting in the 
following compile warning:

<--  snip  -->

...
  CC      sound/usb/usx2y/usx2yhwdeppcm.o
In file included from sound/usb/usx2y/usx2yhwdeppcm.c:53:
sound/usb/usx2y/usbusx2yaudio.c: In function `usX2Y_urbs_allocate':
sound/usb/usx2y/usbusx2yaudio.c:418: warning: unused variable `ep'
...

<--  snip  -->


This patch removes this unused variable.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/sound/usb/usx2y/usbusx2yaudio.c.old	2005-01-30 12:26:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/sound/usb/usx2y/usbusx2yaudio.c	2005-01-30 12:27:03.000000000 +0100
@@ -415,7 +415,6 @@
 	unsigned int pipe;
 	int is_playback = subs == subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
 	struct usb_device *dev = subs->usX2Y->chip.dev;
-	struct usb_host_endpoint *ep;
 
 	pipe = is_playback ? usb_sndisocpipe(dev, subs->endpoint) :
 			usb_rcvisocpipe(dev, subs->endpoint);



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
