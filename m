From: etienne <eyem@lalila.net>
Subject: hdsp / pcmcia / multiface .... details
Date: Thu, 22 Aug 2002 18:04:15 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D649AFF.4090005@lalila.net>
Reply-To: eyem@lalila.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

just thought I should give a few more details on the Hammerfall DSP + 
multiface behaviour. (aplay works, but cant seem to get multiple channel 
output)

------------------------------------------------------
modules.conf contains:
alias char-major-116 snd
alias sound-slot-0 snd-card-0
alias snd-card-0 snd-hdsp
options snd-hammerfall_mem snd_enable=1,1
options snd-hdsp snd_id="hdsp"

------------------------------------------------------
I have no asound.conf or .asoundrc files configured

------------------------------------------------------
 cat /proc/asound/pcm gives:
00-00: RME Hammerfall DSP (Multiface) : RME Hammerfall DSP (Multiface) : 
playback 1 : capture 1

------------------------------------------------------
ls /proc/asound/hdsp gives:
hdsp  id  midi0  midi1  pcm0c  pcm0p

------------------------------------------------------
cat /proc/asound/hdsp/hdsp gives:
RME Hammerfall DSP (Multiface) (Card #1)
Buffers: capture c0e00000 playback c0c00000
IRQ: 11 Registers bus: 0xf5000000 VM: 0xe08d5000
Control register: 0x100905c
Status register: 0x12000000
Status2 register: 0xffff0703
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Latency: 4096 samples (2 periods of 16384 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 5
Sync reference: Master/Master (chosen)
Sample rate: 0

IEC958 input: Internal
IEC958 output: Coaxial & ADAT1
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off

IEC958 sample rate: Error flag set

ADAT1: No Lock
ADAT2: No Lock

------------------------------------------------------
aplay -v sound/orgue1.wav gives: (and only plays in one channel)

Playing WAVE 'sound/orgue1.wav' : Signed 16 bit Little Endian, Rate 
44100 Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
10 <- none
11 <- none
12 <- none
13 <- none
14 <- none
15 <- none
16 <- none
17 <- none
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 8192
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Hardware PCM card 0 'Hammerfall DSP' device 0 subdevice -1

Its setup is:
stream       : PLAYBACK
access       : MMAP_NONINTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 18
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 8192
period_size  : 4096
period_time  : 92879
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4096
xfer_align   : 4096
start_threshold  : 8192
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Max peak (8192 samples): 08968 (0x2308) ######               27%
Max peak (8192 samples): 09412 (0x24c4) ######               28%
Max peak (8192 samples): 07178 (0x1c0a) #####                21%
Max peak (8192 samples): 01246 (0x04de) #                    3%

etienne



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
