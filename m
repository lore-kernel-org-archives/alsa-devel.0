From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: alsa-driver, alsa-kernel cvs does not install now.
Date: Tue, 29 Jun 2004 21:53:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E1D6C7.2080104@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090901090903060409040906"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090901090903060409040906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Can you maybe fix the problem below.
I am using the latest alsa-driver and alsa-kernel cvs.

I do make, and get
...
*** Warning: "snd_compat_kcalloc" 
[/u/alsacvs/alsa-driver/kbuild/../acore/snd.ko] undefined!
...

Then later

make install
....
WARNING: Module /lib/modules/2.6.7/kernel/sound/acore/snd-pcm.ko 
ignored, due to loop
WARNING: Loop detected: /lib/modules/2.6.7/kernel/sound/acore/snd.ko 
which needs snd.ko again!
WARNING: Module /lib/modules/2.6.7/kernel/sound/acore/snd.ko ignored, 
due to loop
...

see attached file for more details.

Cheers
James

--------------090901090903060409040906
Content-Type: text/plain;
 name="make.log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make.log.txt"

Script started on Tue Jun 29 21:50:14 2004
[01;32mroot@new [01;34malsa-driver # [00mmake
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make dep
make[1]: Entering directory `/u/alsacvs/alsa-driver'
if [ ! -d include/sound -a ! -L include/sound ]; then \
  ln -sf ../alsa-kernel/include include/sound ; \
fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make[2]: Entering directory `/u/alsacvs/alsa-driver/acore'
make[3]: Entering directory `/u/alsacvs/alsa-driver/acore/oss'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/acore/oss'
make[3]: Entering directory `/u/alsacvs/alsa-driver/acore/seq'
make[4]: Entering directory `/u/alsacvs/alsa-driver/acore/seq/instr'
make[4]: Leaving directory `/u/alsacvs/alsa-driver/acore/seq/instr'
make[4]: Entering directory `/u/alsacvs/alsa-driver/acore/seq/oss'
make[4]: Leaving directory `/u/alsacvs/alsa-driver/acore/seq/oss'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/acore/seq'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/acore'
make[2]: Entering directory `/u/alsacvs/alsa-driver/i2c'
make[3]: Entering directory `/u/alsacvs/alsa-driver/i2c/other'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/i2c/other'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/i2c'
make[2]: Entering directory `/u/alsacvs/alsa-driver/drivers'
make[3]: Entering directory `/u/alsacvs/alsa-driver/drivers/opl3'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/drivers/opl3'
make[3]: Entering directory `/u/alsacvs/alsa-driver/drivers/opl4'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/drivers/opl4'
make[3]: Entering directory `/u/alsacvs/alsa-driver/drivers/mpu401'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/drivers/mpu401'
make[3]: Entering directory `/u/alsacvs/alsa-driver/drivers/vx'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/drivers/vx'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/drivers'
make[2]: Entering directory `/u/alsacvs/alsa-driver/isa'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/msnd'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/msnd'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/ad1816a'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/ad1816a'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/ad1848'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/ad1848'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/cs423x'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/cs423x'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/es1688'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/es1688'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/gus'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/gus'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/opti9xx'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/opti9xx'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/sb'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/sb'
make[3]: Entering directory `/u/alsacvs/alsa-driver/isa/wavefront'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/isa/wavefront'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/isa'
make[2]: Entering directory `/u/alsacvs/alsa-driver/synth'
make[3]: Entering directory `/u/alsacvs/alsa-driver/synth/emux'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/synth/emux'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/synth'
make[2]: Entering directory `/u/alsacvs/alsa-driver/pci'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/pdplus'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/pdplus'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/ac97'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/ac97'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/ali5451'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/ali5451'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/au88x0'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/au88x0'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/cs46xx'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/cs46xx'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/emu10k1'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/emu10k1'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/ice1712'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/ice1712'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/korg1212'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/korg1212'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/mixart'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/mixart'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/nm256'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/nm256'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/rme9652'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/rme9652'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/trident'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/trident'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/ymfpci'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/ymfpci'
make[3]: Entering directory `/u/alsacvs/alsa-driver/pci/vx222'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/pci/vx222'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/pci'
make[2]: Entering directory `/u/alsacvs/alsa-driver/usb'
make[3]: Entering directory `/u/alsacvs/alsa-driver/usb/usx2y'
make[3]: Leaving directory `/u/alsacvs/alsa-driver/usb/usx2y'
make[2]: Leaving directory `/u/alsacvs/alsa-driver/usb'
make[1]: Leaving directory `/u/alsacvs/alsa-driver'
make -C /lib/modules/2.6.7/build SUBDIRS=/u/alsacvs/alsa-driver/kbuild  modules
make[1]: Entering directory `/usr/src/linux-2.6.7'
  Building modules, stage 2.
  MODPOST
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/snd.ko] undefined!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/snd-timer.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/snd-timer.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/snd-seq.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/snd-seq.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/oss/snd-seq-oss.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/oss/snd-seq-oss.ko] has no CRC!
*** Warning: "snd_seq_set_queue_tempo" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/oss/snd-seq-oss.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/snd-seq-midi-event.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/snd-seq-device.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/seq/snd-seq-device.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/snd-rtctimer.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/snd-pcm.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/snd-pcm.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/oss/snd-pcm-oss.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/oss/snd-pcm-oss.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../acore/oss/snd-mixer-oss.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../acore/oss/snd-mixer-oss.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../pci/emu10k1/snd-audigyls.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../pci/emu10k1/snd-audigyls.ko] has no CRC!
*** Warning: "snd_verbose_printk" [/u/alsacvs/alsa-driver/kbuild/../pci/ac97/snd-ac97-codec.ko] has no CRC!
*** Warning: "snd_compat_kcalloc" [/u/alsacvs/alsa-driver/kbuild/../pci/ac97/snd-ac97-codec.ko] has no CRC!
make[1]: Leaving directory `/usr/src/linux-2.6.7'

ALSA modules were successfully compiled.

[01;32mroot@new [01;34malsa-driver # [00mexit

Script done on Tue Jun 29 21:50:23 2004

--------------090901090903060409040906--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
