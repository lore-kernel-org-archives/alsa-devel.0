From: Christoph Lameter <christoph@lameter.com>
Subject: Re: cmipci driver locking up linux hard
Date: Mon, 7 Aug 2006 13:23:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608071318580.7499@graphe.net>
References: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
	<s5hy7u0raux.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608070927480.3308@graphe.net>
	<s5hhd0os9nv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhd0os9nv.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Aug 2006, Takashi Iwai wrote:

> Also, you can still try the old OSS cmpci driver...

Well that one is still in the kernel but one cannot enable it
in menuconfig. I needed the following patch to make it possible
to enable that module. It was not loaded automatically on bootup so I 
needed to do a

modprobe cmpci

After that I had sound for 2 minutes before the system locked up
again. Same code base?

Index: linux-2.6/sound/oss/Kconfig
===================================================================
--- linux-2.6.orig/sound/oss/Kconfig	2006-08-07 13:12:48.000000000 -0700
+++ linux-2.6/sound/oss/Kconfig	2006-08-07 13:13:38.000000000 -0700
@@ -479,6 +479,12 @@
 
 	  This driver is also available as a module and will be called aci.
 
+config SOUND_CMPCI
+	tristate "CMPCI Sound"
+	depends on SOUND_OSS
+	help
+		CMPCI sound
+
 config SOUND_CS4232
 	tristate "Crystal CS4232 based (PnP) cards"
 	depends on SOUND_OSS

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
