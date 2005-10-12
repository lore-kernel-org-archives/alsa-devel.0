From: Erik <assie2@zonnet.nl>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Wed, 12 Oct 2005 02:30:46 +0200
Message-ID: <1129077046.10383.5.camel@pc-erik.lan>
References: <4317CC51.3040709@netvigator.com>
	 <200509042134.23916.alien999999999@users.sourceforge.net>
	 <1126131309.17399.8.camel@pc-erik.lan>
	 <44272.62.59.249.250.1126163238.squirrel@62.59.249.250>
	 <1126668747.6835.11.camel@pc-erik.lan>  <432AD3B9.8010200@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432AD3B9.8010200@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "openvortex-dev@nongnu.org" <openvortex-dev@nongnu.org>
List-Id: alsa-devel@alsa-project.org

i tried the patch on alsa-driver-1.0.9b
kernel 2.6.13.2

and i get this error:
 
make -C /lib/modules/2.6.13.2/source
SUBDIRS=/home/assie/alsa-driver-1.0.9b O=/lib/modules/2.6.13.2/build
modules
make[1]: Entering directory `/usr/src/linux-2.6.13.2'
  CC [M]  /home/assie/alsa-driver-1.0.9b/pci/au88x0/au8830.o
In file included
from /home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au8830.c:17,

from /home/assie/alsa-driver-1.0.9b/pci/au88x0/au8830.c:2:
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for 'vortex_XtalkHw_SetSampleRate'
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of 'vortex_XtalkHw_SetSampleRate' was here
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for 'vortex_XtalkHw_SetSampleRate'
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of 'vortex_XtalkHw_SetSampleRate' was here
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.h:51: warning: 'vortex_XtalkHw_SetSampleRate' declared `static' but never defined
/home/assie/alsa-driver-1.0.9b/pci/au88x0/../../alsa-kernel/pci/au88x0/au88x0_xtalk.c:645: warning: 'vortex_XtalkHw_SetSampleRate' defined but not used
make[5]: *** [/home/assie/alsa-driver-1.0.9b/pci/au88x0/au8830.o] Error
1
make[4]: *** [/home/assie/alsa-driver-1.0.9b/pci/au88x0] Error 2
make[3]: *** [/home/assie/alsa-driver-1.0.9b/pci] Error 2
make[2]: *** [_module_/home/assie/alsa-driver-1.0.9b] Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.13.2'
make: *** [compile] Error 2
[root@pc-erik alsa-driver-1.0.9b]#

without the patch i can make and install alsadriver but then it isn't
working giving this error :

service alsasound start
Starting sound driver: snd-au8830 WARNING: Error inserting snd
(/lib/modules/2.6.13.2/kernel/sound/acore/snd.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-seq-device
(/lib/modules/2.6.13.2/kernel/sound/acore/seq/snd-seq-device.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-rawmidi
(/lib/modules/2.6.13.2/kernel/sound/acore/snd-rawmidi.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-mpu401-uart
(/lib/modules/2.6.13.2/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko):
Unknown symbol in module, or unknown parameter(see dmesg)
WARNING: Error inserting snd-timer
(/lib/modules/2.6.13.2/kernel/sound/acore/snd-timer.ko): Unknown symbol
in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-pcm
(/lib/modules/2.6.13.2/kernel/sound/acore/snd-pcm.ko): Unknown symbol in
module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-ac97-codec
(/lib/modules/2.6.13.2/kernel/sound/pci/ac97/snd-ac97-codec.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd-au8830
(/lib/modules/2.6.13.2/kernel/sound/pci/au88x0/snd-au8830.ko): Unknown
symbol in module, or unknown parameter (see dmesg)
done


I hope you can do something with this information.

Erik



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
