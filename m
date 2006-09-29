From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Build files
Date: Fri, 29 Sep 2006 14:56:07 +0100
Message-ID: <1159538167.3170.73.camel@localhost.localdomain>
References: <1158326252.22950.64.camel@localhost.localdomain>
	<s5hpsdshwuf.wl%tiwai@suse.de>
	<1158944171.18071.87.camel@localhost.localdomain>
	<s5hd59e51ba.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rhxcIzaVyNgtB+Lbuwpb"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hd59e51ba.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-rhxcIzaVyNgtB+Lbuwpb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-09-29 at 14:01 +0200, Takashi Iwai wrote:
> At Fri, 22 Sep 2006 17:56:11 +0100,
> Liam Girdwood wrote:
> > 
> > On Tue, 2006-09-19 at 14:20 +0200, Takashi Iwai wrote:
> > > At Fri, 15 Sep 2006 14:17:32 +0100,
> > > Liam Girdwood wrote:
> > > > 
> > > > Index: alsa-kernel/soc/Kconfig
> > > > ===================================================================
> > > > --- /dev/null
> > > > +++ alsa-kernel/soc/Kconfig
> > > > @@ -0,0 +1,18 @@
> > > > +#
> > > > +# SoC audio configuration
> > > > +#
> > > > +
> > > > +menu "SoC audio support"
> > > > +
> > > > +config SND_SOC
> > > > +	tristate "SoC audio support"
> > > 
> > > Don't you need dependencies?
> > > 
> > 
> > I've set the deps (for each platform) in the child (asoc) Kconfig. 
> 
> But soc/Kconfig is always evaluated even if CONFIG_SND=n.
> If SoC depends on ALSA core layer, it should have "depends on SND"
> or "select SND" at least.  Otherwise you can get a build error.
> 
> 

Fixed. 

> BTW, any drivers using SoC are planned to be merged soon, too?
> It's always better to have a working driver together with the core
> stuff for pushing to upstream.
> 
> 

Np, I was waiting until after 1.0.13 final was released. It's late
today, so I'll submit on Monday.


Liam


--=-rhxcIzaVyNgtB+Lbuwpb
Content-Disposition: attachment; filename=asoc-build.patch
Content-Type: text/x-patch; name=asoc-build.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/Kconfig
===================================================================
--- alsa-kernel.orig/Kconfig
+++ alsa-kernel/Kconfig
@@ -76,6 +76,8 @@ source "sound/sparc/Kconfig"
 
 source "sound/parisc/Kconfig"
 
+source "sound/soc/Kconfig"
+
 endmenu
 
 menu "Open Sound System"
Index: alsa-kernel/Makefile
===================================================================
--- alsa-kernel.orig/Makefile
+++ alsa-kernel/Makefile
@@ -4,7 +4,7 @@
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ soc/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 ifeq ($(CONFIG_SND),y)
Index: alsa-kernel/soc/Kconfig
===================================================================
--- /dev/null
+++ alsa-kernel/soc/Kconfig
@@ -0,0 +1,19 @@
+#
+# SoC audio configuration
+#
+
+menu "SoC audio support"
+	depends on SND!=n
+
+config SND_SOC
+	tristate "SoC audio support"
+	---help---
+
+	  If you want SoC support, you should say Y here and also to the
+	  specific driver for your SoC below. You will also need to select the
+	  specific codec(s) attached to the SoC
+
+	  This SoC audio support can also be built as a module.  If so, the module
+	  will be called snd-soc-core.
+
+endmenu
Index: alsa-kernel/soc/Makefile
===================================================================
--- /dev/null
+++ alsa-kernel/soc/Makefile
@@ -0,0 +1,4 @@
+snd-soc-core-objs := soc-core.o soc-dapm.o
+
+obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
+

--=-rhxcIzaVyNgtB+Lbuwpb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-rhxcIzaVyNgtB+Lbuwpb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-rhxcIzaVyNgtB+Lbuwpb--
