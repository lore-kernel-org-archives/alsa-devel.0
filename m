From: Thomas Koenig <koenig.thomas@rheinmetall-de.com>
Subject: aplay Problem Alsa 1.0.7rc2 Kernel 2.4.21-243-smp
Date: Mon, 18 Oct 2004 11:02:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <417386B9.4020608@rheinmetall-de.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Lienig <lienig@rheinmetall-de.com>
List-Id: alsa-devel@alsa-project.org

Hello,

When we tried  Alsa 1.0.7rc2 on a 2.4.21-243-smp 64-Bit Linux Box aplay=20
will not play Sounds.

Same Kernel in 32-Bit Alsa 1.0.6a work fine.
Compiling Alsa 1.0.6a with 64-Bit dose not work so we take Alsa 1.0.7rc2=20
where compiling seemd to be ok.

Play play /usr/share/sounds/alsa/test.wav (osslibs) work but when we try=20
to aplay a sound we got:

sider11-s1 /home/vtssim> aplay -D c56 /usr/share/sounds/alsa/test.wav
Playing WAVE '/usr/share/sounds/alsa/test.wav' : Signed 16 bit Little=20
Endian, Rate 44100 Hz, Stereo
aplay: set_params:910: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE
PERIOD_TIME: (74285 74286)
PERIOD_SIZE: (392911 392912)
PERIOD_BYTES: (1571644 1571648)
PERIODS: (2 3)
BUFFER_TIME: (148594 148595)
BUFFER_SIZE: 785951
BUFFER_BYTES: 3143804
TICK_TIME: 0

Just for Info:

sider11-s1 /home/vtssim> aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Phase88 [TerraTec Phase88], device 0: ICE1712 multi [ICE1712 mult=
i]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Phase88 [TerraTec Phase88], device 1: ICE1712 consumer [ICE1712=20
consumer]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Phase88 [TerraTec Phase88], device 2: ICE1712 consumer (DS)=20
[ICE1712 consumer (DS)]
  Subdevices: 6/6
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5


sider11-s1 /home/vtssim> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1991.475
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm=20
3dnowext 3dnow
bogomips        : 3915.77
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 1991.475
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm=20
3dnowext 3dnow
bogomips        : 3981.31
TLB size        : 1088 4K pages
clflush size    : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


Same Kernel in 32-Bit Alsa work fine. But when we change to 64-Bit=20
aplay  has Problems:

sider11-s1 /home/vtssim> aplay -D c56 /usr/share/sounds/alsa/test.wav
Playing WAVE '/usr/share/sounds/alsa/test.wav' : Signed 16 bit Little=20
Endian, Rate 44100 Hz, Stereo
aplay: set_params:910: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: NONE
PERIOD_TIME: (74285 74286)
PERIOD_SIZE: (392911 392912)
PERIOD_BYTES: (1571644 1571648)
PERIODS: (2 3)
BUFFER_TIME: (148594 148595)
BUFFER_SIZE: 785951
BUFFER_BYTES: 3143804
TICK_TIME: 0

Please Reply to lienig@rheinmetall-de.com

--=20
mit freundlichen Gr=FC=DFen

Thomas Koenig
Rheinmetall Defence Electronics GmbH
Simulation Division
Br=FCggeweg 54
D-28309 Bremen
Tel. : +49/421/457-4184
Fax  : +49/421/457-3578
email: koenig.thomas@rheinmetall-de.com



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
