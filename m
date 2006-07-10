From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] make sound/isa/gus/gusextreme.c:devices
	static
Date: Tue, 11 Jul 2006 00:02:36 +0200
Message-ID: <20060710220236.GI13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B5A7A172
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 00:02:36 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"devices" is not a good name for a global variable.

Thankfully, it can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/sound/isa/gus/gusextreme.c.old	2006-07-10 01:15:13.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/sound/isa/gus/gusextreme.c	2006-07-10 01:15:20.000000000 +0200
@@ -87,7 +87,7 @@
 module_param_array(pcm_channels, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for GUS Extreme driver.");
 
-struct platform_device *devices[SNDRV_CARDS];
+static struct platform_device *devices[SNDRV_CARDS];
 
 
 #define PFX	"gusextreme: "



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
