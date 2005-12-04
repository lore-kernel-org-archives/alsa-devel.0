From: Tomas Carnecky <tom@dbservice.com>
Subject: aoss and teamspeak
Date: Sun, 04 Dec 2005 04:00:54 +0000
Message-ID: <439269F6.2070404@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

I think I've foud the problem: snd_pcm_start() is never called !

Look at the output:

$ ALSA_OSS_DEBUG=1 LD_PRELOAD=./libaoss.so.0.0.0 TeamSpeak
ERROR: ld.so: object './libaoss.so.0.0.0' from LD_PRELOAD cannot be 
preloaded: ignored.
Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
Opened PCM default for stream 1 (result = 0)
open("/dev/dsp", 2, 0) -> 18
ioctl(18, SNDCTL_DSP_RESET)
ioctl(18, SNDCTL_DSP_SETDUPLEX)
ioctl(18, SNDCTL_DSP_GETCAPS, 0x59202168) -> [13056]
ioctl(18, SNDCTL_DSP_SETFRAGMENT, 0x5920216c[3000c])
ioctl(18, SNDCTL_DSP_SETFMT, 0x59202168[16]) -> [16]
ioctl(18, SNDCTL_DSP_CHANNELS, 0x59202178[1]) -> [1]
ioctl(18, SNDCTL_DSP_SPEED, 0x5920216c[22050]) -> [22050]
ioctl(18, SNDCTL_DSP_GETBLKSIZE, 0x592022cc) -> [4096]
read(18, 0x83d1140, 4096) -> 4096
write(18, 0x83a3a70, 4096) -> 4096
read(18, 0x83d1140, 4096) -> 4096
write(18, 0x83a3a70, 4096) -> 4096
read(18, 0x83d1140, 4096) -> 4096
write(18, 0x83a3a70, 4096) -> 4096
read(18, 0x83d1140, 4096) -> 4096
write(18, 0x83a3a70, 4096) -> 4096
read(18, 0x83d1140, 4096) -> 4096

[and those read/write continue forever]

if you look at alsa-oss/alsa/pcm.c, you'll see that snd_pcm_start() is 
only called from the ioctl() handler, and only on SNDCTL_DSP_SETTRIGGER 
which never occurs in the teamspeak trace. Because TS2 works with native 
OSS, I assume that the alsa-oss emulator is buggy. I've added 
snd_pcm_start() to the read/write functions and everything works.

a little step-by-step guide:

first I had to remove (comment out) the "period_size" option from the 
capture device, it was set to 1024 and it caused 
snd_pcm_hw_params_set_periods_max() to fail, here is the output of a 
failed session, along with a few debug information:

ioctl(18, SNDCTL_DSP_SETFRAGMENT, 0x590e916c[3000c])
periods_min: 3, periods_max: 3, dsp->maxfrags: 3 <== capture device
periods_min: 15, periods_max: 15, dsp->maxfrags: 3 <== playback device 
that fails
dsp ioctl error = -22

then I had to adjust the SNDCTL_DSP_GETBLKSIZE return value, the normal 
value computed by the aoss library would be:
ioctl(18, SNDCTL_DSP_GETBLKSIZE, 0x592022cc) -> [8192]
but that caused memory corruption in TeamSpeak, any value below (4092, 
2048, 1024) work fine. Symptoms:

read(18, 0x83d9088, 8192) -> 8192
Runtime error 231 at 0806A7E9
Runtime error 231 at 0806A7E9
munmap((nil), 61439)
TeamSpeak.bin: pcm.c:1451: lib_oss_pcm_munmap: Assertion 
`str->mmap_buffer' failed.
Aborted

or

read(18, 0x83c8770, 8192) -> 8192
Runtime error 231 at 0806A7E9
X Error: BadWindow (invalid Window parameter) 3
   Major opcode:  4
X Error: BadValue (integer parameter out of range for operation) 2
   Major opcode:  56
X Error: BadRequest (invalid request code or no such operation) 1
   Major opcode:  249
X Error: BadWindow (invalid Window parameter) 3
   Major opcode:  12
X Error: BadLength (poly request too large or internal Xlib length error) 16
   Major opcode:  2
TeamSpeak.bin: Fatal IO error: client killed

or

read(18, 0x83d91d8, 8192) -> 8192
Runtime error 231 at 0806A7E9
Exception EAccessViolation in module TeamSpeak.bin at 0806A7E9.
Access violation at address 0805C238, accessing address FFFFFFFC.
munmap((nil), 61439)
TeamSpeak.bin: pcm.c:1451: lib_oss_pcm_munmap: Assertion 
`str->mmap_buffer' failed.
Aborted

system: Gentoo Linux 2.6.14.2 #8 SMP PREEMPT Sat Dec 3 23:51:59 GMT 2005 
x86_64 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ AuthenticAMD GNU/Linux

tom



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
