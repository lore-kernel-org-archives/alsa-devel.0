From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: snd-hdsp unresolved symbol and an alsa build error
Date: 12 Apr 2003 00:42:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050100931.1337.51.camel@satellite.undata.org>
References: <200304120118.45101.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-00wOEMe+MnIPXSv996j3"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304120118.45101.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?ISO-8859-1?Q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-00wOEMe+MnIPXSv996j3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> kernel 2.4.20, pcmcia support as module, alsa cvs from friday evening
> ./configure --with-cards=virmidi,hdsp,usb-audio,via82xx --with-sequencer=yes
> --with-isapnp=no
> 
> /sbin/modprobe snd-hdsp
> /lib/modules/2.4.20/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved symbol 
> snd_hwdep_new_R42732707
> 
> This build error comes everytime I leave out --with-isapnp=no :
> 
> pnp.c:130: redefinition of `pnp_request_card_device_Rfcc1b9a4'
> pnp.h:203: `pnp_request_card_device_Rfcc1b9a4' previously defined here
> pnp.c:143: redefinition of `pnp_release_card_device_R57adc334'
> pnp.h:204: `pnp_release_card_device_R57adc334' previously defined here
> pnp.c:150: redefinition of `pnp_register_card_driver_Rcbd2bd96'
> pnp.h:205: `pnp_register_card_driver_Rcbd2bd96' previously defined here
> pnp.c:199: redefinition of `pnp_unregister_card_driver_Re6bf830a'
> pnp.h:206: `pnp_unregister_card_driver_Re6bf830a' previously defined here
> pnp.c:218: redefinition of `pnp_register_driver_Rc6d14622'
> pnp.h:207: `pnp_register_driver_Rc6d14622' previously defined here
> pnp.c:249: redefinition of `pnp_unregister_driver_Re83d02dc'
> pnp.h:208: `pnp_unregister_driver_Re83d02dc' previously defined here
> pnp.c:267: redefinition of `pnp_init_resource_table_R16084899'
> pnp.h:209: `pnp_init_resource_table_R16084899' previously defined here
> pnp.c:297: redefinition of `pnp_manual_config_dev_Rad6619ba'
> pnp.h:210: `pnp_manual_config_dev_Rad6619ba' previously defined here
> pnp.c:328: redefinition of `pnp_activate_dev_R85f47f33'
> pnp.h:211: `pnp_activate_dev_R85f47f33' previously defined here
> pnp.h:203: warning: `pnp_request_card_device_Rfcc1b9a4' defined but not used
> pnp.h:204: warning: `pnp_release_card_device_R57adc334' defined but not used
> pnp.h:205: warning: `pnp_register_card_driver_Rcbd2bd96' defined but not used
> pnp.h:206: warning: `pnp_unregister_card_driver_Re6bf830a' defined but not 
> used
> pnp.h:207: warning: `pnp_register_driver_Rc6d14622' defined but not used
> pnp.h:208: warning: `pnp_unregister_driver_Re83d02dc' defined but not used
> pnp.h:209: warning: `pnp_init_resource_table_R16084899' defined but not used
> pnp.h:210: warning: `pnp_manual_config_dev_Rad6619ba' defined but not used
> pnp.h:211: warning: `pnp_activate_dev_R85f47f33' defined but not used

The hdsp driver now depends on the hwdep interface.
alsa-kernel/core/Makefile should be edited to reflect that.
A patch is attached.

Thomas



--=-00wOEMe+MnIPXSv996j3
Content-Disposition: attachment; filename=alsa_kernel_core_makefile.patch
Content-Type: text/x-makefile; name=alsa_kernel_core_makefile.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- Makefile.old	2003-04-12 00:40:09.000000000 +0200
+++ Makefile	2003-04-12 00:40:23.000000000 +0200
@@ -90,7 +90,7 @@
 obj-$(CONFIG_SND_KORG1212) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
 obj-$(CONFIG_SND_NM256) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
 obj-$(CONFIG_SND_RME9652) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
-obj-$(CONFIG_SND_HDSP) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
+obj-$(CONFIG_SND_HDSP) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_TRIDENT) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o
 obj-$(CONFIG_SND_YMFPCI) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_POWERMAC) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o

--=-00wOEMe+MnIPXSv996j3--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
