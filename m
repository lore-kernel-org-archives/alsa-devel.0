From: Tom Watson <sdc695@yahoo.com>
Subject: Getting an ES1869 to work in a Compaq Laptop
Date: Mon, 22 Mar 2004 18:59:17 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040323025917.22005.qmail@web60805.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It looks like I have it working about 1/2 way.  I compiled 1.0.3 and
along with its libs and utils got it installed on a RH9 system
(2.4.20).  The drivers seem to load correctly, but attempts at getting
the mixer to work (alsamixer) seem to die in flames.
Files:
>>>/etc/modules.conf:
# ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-es18xx
# Modules options should go here
options snd-es18xx index=1 id=1 enable=1 isapnp=0 port=0x220
mpu_port=0x330 fm_port=0x
338 irq=5 dma1=1 dma2=0


# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0

# First card (internal to the Presario 1244)
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

>>>>>/proc/modules
ide-cd                 33436   0 (autoclean)
cdrom                  31040   0 (autoclean) [ide-cd]
snd-pcm-oss            42500   0 (autoclean) (unused)
snd-mixer-oss          15032   0 (autoclean) [snd-pcm-oss]
parport_pc             17508   1 (autoclean)
lp                      8580   0 (autoclean)
parport                33952   1 (autoclean) [parport_pc lp]
snd-seq-midi            4576   0 (unused)
snd-seq-midi-event      5920   0 [snd-seq-midi]
snd-opl3-synth         11780   0 (unused)
snd-seq-instr           7228   0 [snd-opl3-synth]
snd-seq-midi-emul       6636   0 [snd-opl3-synth]
snd-seq                42864   0 [snd-seq-midi snd-seq-midi-event
snd-opl3-synth snd-s
eq-instr snd-seq-midi-emul]
snd-ainstr-fm           2944   0 [snd-opl3-synth]
snd-es18xx             21804   0
snd-opl3-lib            8132   0 [snd-opl3-synth snd-es18xx]
snd-hwdep               6464   0 [snd-opl3-lib]
snd-pnp                 5500   0 [snd-es18xx]
snd-pcm                79104   0 [snd-pcm-oss snd-es18xx]
snd-page-alloc          9556   0 [snd-pcm]
snd-timer              18340   0 [snd-seq snd-opl3-lib snd-pcm]
snd-mpu401-uart         4752   0 [snd-es18xx]
snd-rawmidi            17728   0 [snd-seq-midi snd-mpu401-uart]
snd-seq-device          5788   0 [snd-seq-midi snd-opl3-synth snd-seq
snd-opl3-lib snd
-rawmidi]
snd                    43236   0 [snd-pcm-oss snd-mixer-oss
snd-seq-midi snd-seq-midi-
event snd-opl3-synth snd-seq-instr snd-seq snd-es18xx snd-opl3-lib
snd-hwdep snd-pcm s
nd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               6116   6 [snd]
pcnet_cs               13984   1
8390                    7868   0 [pcnet_cs]
ds                      8136   2 [pcnet_cs]
yenta_socket           12864   2
pcmcia_core            53152   0 [pcnet_cs ds yenta_socket]
nls_iso8859-1           3484   1 (autoclean)
nls_cp437               5116   1 (autoclean)
vfat                   11948   1 (autoclean)
fat                    36792   0 (autoclean) [vfat]
keybdev                 2720   0 (unused)
mousedev                5204   1
hid                    20772   0 (unused)
input                   5632   0 [keybdev mousedev hid]
usb-ohci               20392   0 (unused)
usbcore                73088   1 [hid usb-ohci]
ext3                   64704   4
jbd                    47828   4 [ext3]


>>>output from "strace alsamixer" (tail end):
open("/etc/asound.conf", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40013000
read(3, "pcm.es18xx {\n   type hw\n   card "..., 4096) = 75
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40013000, 4096)                = 0
access("/home/tsw/.asoundrc", R_OK)     = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC0", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC0", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENODEV (No such device)
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40013000
write(1, "\n", 1
)                       = 1
write(2, "alsamixer: function snd_ctl_open"..., 68alsamixer: function
snd_ctl_open failed for default: No such device
) = 68
munmap(0x40013000, 4096)                = 0
exit_group(1)                           = ?


>>>File /etc/asound.conf:
pcm.es18xx {
   type hw
   card 0
}

ctl.es18xx {
   type hw
   card 0
}


>>>Output from 'ls'
[tsw@presario proc]$ ls -l /dev/snd/controlC0
crw-rw-rw-    1 root     root     116,   0 Mar 21 23:51
/dev/snd/controlC0
[tsw@presario proc]$ ls -l /dev/aloadC0
crw-rw-rw-    1 root     root     116,   0 Mar 21 22:28 /dev/aloadC0
[these should be writable by all!!]
<<<<<End

p.s.  I won't go into the fact that KDE's use of /dev/dsp sppms to
fail.  I suspect that if the above problem is cured, all will be well. 
My intent here is to show the failure in as simple terms as possible,
using programs provided by alsa (alsamixer).

Previous people mentioned that the ES1869 is a Sound Blaster
compatable, if that were TOTALLY true (who am I to dispute!!), my next
question is why is there a different driver??

I suspect that the solution is a simple one.

Thanks.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
