From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Fri, 11 Feb 2005 13:31:08 +1100
Message-ID: <420C18EC.3060706@machinehasnoagenda.com>
References: <1106091073.24484.60.camel@krustophenia.net>	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>	 <41FE5838.4060907@glocalnet.net>	 <1108073865.11177.6.camel@krustophenia.net>	 <420BEF63.60402@machinehasnoagenda.com>	 <1108083562.15438.4.camel@krustophenia.net>	 <420C0BE5.3060008@machinehasnoagenda.com> <1108085587.15438.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1108085587.15438.6.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Fri, 2005-02-11 at 12:35 +1100, Shayne O'Connor wrote:
>  
>
>>[mrmachine@localhost alsa-driver]$ patch -p1 <
>>../emu10k1-multichannel-v009.patch
>>can't find file to patch at input line 8
>>Perhaps you used the wrong -p or --strip option?
>>    
>>
>
>Apply the patch from the main alsa directory, not the alsa-driver
>directory.
>  
>
ok, i did that, but when i try to compile alsa-driver i get the output
below ... but just to clear up - with patches before 009, i only had to
compile and install the alsa-driver module (i'm using PlanetCCRMA which
loads alsa as a kernel module), is that the case here as well?

if not, could you give me a run-through of how i would install the whole
pattched alsa package on top of what i've already got there? i realise
you're busy, but it would help a great deal in making sure i'm testing
these patches correctly :)

here is the ouput from trying to compile alsa-driver:

[mrmachine@localhost alsa-driver]$ make
make dep
make[1]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #9 succeeded at 934 (offset -1 lines).
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #2 succeeded at 2737 (offset 6 lines).
Hunk #4 succeeded at 2810 (offset 6 lines).
Hunk #6 succeeded at 2928 (offset 6 lines).
Hunk #8 succeeded at 2965 (offset 6 lines).
Hunk #10 succeeded at 3026 (offset 6 lines).
Hunk #12 succeeded at 3084 (offset 6 lines).
Hunk #14 succeeded at 3122 (offset 6 lines).
Hunk #16 succeeded at 3149 (offset 6 lines).
Hunk #18 succeeded at 3238 (offset 6 lines).
Hunk #20 succeeded at 3306 (offset 6 lines).
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #2 succeeded at 1254 (offset -2 lines).
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
copying file alsa-kernel/core/init.c
patching file init.c
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #1 succeeded at 1264 (offset -3 lines).
copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #2 succeeded at 165 with fuzz 2.
Hunk #3 succeeded at 366 (offset -4 lines).
Hunk #4 succeeded at 385 (offset -2 lines).
Hunk #5 succeeded at 504 (offset 1 line).
copying file alsa-kernel/core/timer.c
patching file timer.c
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/oss'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
make[4]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq/instr'
make[4]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq/instr'
make[4]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
make[4]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq/oss'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/seq'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/i2c'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/i2c/other'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/i2c/other'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/i2c'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/pcsp'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/pcsp'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/opl3'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/opl4'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/opl4'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/mpu401'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/vx'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers/vx'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/drivers'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/msnd'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/msnd'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/ad1816a'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/ad1816a'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/ad1848'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/ad1848'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/cs423x'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/cs423x'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/es1688'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/es1688'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/gus'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/gus'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/opti9xx'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/opti9xx'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/sb'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/sb'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/wavefront'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa/wavefront'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/isa'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/synth'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/synth/emux'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/synth/emux'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/synth'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci'
copying file alsa-kernel/pci/bt87x.c
patching file bt87x.c
Hunk #1 succeeded at 803 (offset 28 lines).
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk #1 succeeded at 41 (offset -2 lines).
Hunk #2 succeeded at 745 (offset -4 lines).
Hunk #3 succeeded at 758 (offset -2 lines).
Hunk #4 succeeded at 2846 (offset 33 lines).
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/pdplus'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/pdplus'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/pcxhr'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/pcxhr'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/echoaudio'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/echoaudio'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ac97'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ac97'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ali5451'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ali5451'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/au88x0'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/au88x0'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ca0106'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ca0106'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/cs46xx'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/cs46xx'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/emu10k1'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/emu10k1'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/hda'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/hda'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ice1712'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ice1712'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/korg1212'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/korg1212'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/mixart'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/mixart'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/nm256'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/nm256'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/rme9652'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/rme9652'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/trident'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/trident'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ymfpci'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/ymfpci'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/vx222'
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci/vx222'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pci'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
Hunk #17 succeeded at 3088 (offset 2 lines).
Hunk #19 succeeded at 3193 (offset 2 lines).
Hunk #21 succeeded at 3306 (offset 2 lines).
Hunk #23 succeeded at 3414 (offset 2 lines).
copying file alsa-kernel/usb/usbmidi.c
patching file usbmidi.c
Hunk #2 succeeded at 865 (offset 12 lines).
Hunk #4 succeeded at 1379 (offset 12 lines).
copying file alsa-kernel/usb/usbmixer.c
patching file usbmixer.c
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/usb/usx2y'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/usb'
make[2]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia/vx'
copying file alsa-kernel/pcmcia/vx/vxpocket.c
patching file vxpocket.c
Hunk #2 succeeded at 167 (offset -8 lines).
copying file alsa-kernel/pcmcia/vx/vx_entry.c
patching file vx_entry.c
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia/vx'
make[3]: Entering directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia/pdaudiocf'
copying file alsa-kernel/pcmcia/pdaudiocf/pdaudiocf.c
patching file pdaudiocf.c
Hunk #3 succeeded at 73 (offset -7 lines).
Hunk #4 succeeded at 187 with fuzz 1 (offset -5 lines).
Hunk #5 succeeded at 271 (offset -8 lines).
Hunk #6 succeeded at 363 (offset -14 lines).
Hunk #7 succeeded at 440 (offset -8 lines).
make[3]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia/pdaudiocf'
make[2]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/pcmcia'
make[1]: Leaving directory
`/home/mrmachine/linux-progz/cvs/alsa/alsa-driver'
make -C /lib/modules/2.6.10-0.5.rdt.rhfc2.ccrma/source
SUBDIRS=/home/mrmachine/linux-progz/cvs/alsa/alsa-driver
O=/lib/modules/2.6.10-0.5.rdt.rhfc2.ccrma/build modules
make[1]: Entering directory `/lib/modules/2.6.10-0.5.rdt.rhfc2.ccrma/build'
  CC [M]  /home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.o
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:198: error: redefinition of `pm_message_t'
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:716:
error: `pm_message_t' previously declared here
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:218:1: warning: "PMSG_FREEZE" redefined
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:717:1:
warning: this is the location of the previous definition
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:219:1: warning: "PMSG_SUSPEND" redefined
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:718:1:
warning: this is the location of the previous definition
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/core.h:29,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:28:
include/linux/pm.h:220:1: warning: "PMSG_ON" redefined
In file included from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/sound/driver.h:42,
                 from
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.c:22:
/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/include/adriver.h:719:1:
warning: this is the location of the previous definition
make[4]: ***
[/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore/hwdep.o] Error 1
make[3]: *** [/home/mrmachine/linux-progz/cvs/alsa/alsa-driver/acore]
Error 2
make[2]: *** [_module_/home/mrmachine/linux-progz/cvs/alsa/alsa-driver]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/lib/modules/2.6.10-0.5.rdt.rhfc2.ccrma/build'
make: *** [compile] Error 2


shayne



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
