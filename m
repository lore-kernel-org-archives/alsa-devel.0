From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] fix sound/isa/gus/interwave.c compile with PNP=n
Date: Sun, 6 Feb 2005 19:44:21 +0100
Message-ID: <20050206184421.GR3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id A5C2D23F
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2005 19:44:28 +0100 (MET)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, "emmanuel.colbus@ensimag.imag.fr" <colbuse@ensisun.imag.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Emmanuel Colbus sent this patch one month ago with the following 
description:

There is a trivial bug in the file sound/isa/gus/interwave.c .
The variable isapnp is defined only if CONFIG_PNP is enabled, but it is
always used few lines after.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- a/sound/isa/gus/interwave.c	Fri Dec 24 22:34:58 2004
+++ b/sound/isa/gus/interwave.c	Wed Jan  5 14:06:53 2005
@@ -79,8 +79,10 @@
 MODULE_PARM_DESC(id, "ID string for InterWave soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable InterWave soundcard.");
+#ifdef CONFIG_PNP
 module_param_array(isapnp, bool, NULL, 0444);
 MODULE_PARM_DESC(isapnp, "ISA PnP detection for specified soundcard.");
+#endif
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for InterWave driver.");
 #ifdef SNDRV_STB


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
