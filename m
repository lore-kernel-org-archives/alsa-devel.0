From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: hdsp driver, digiface, external sync
Date: Fri,  9 Aug 2002 17:12:57 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208100012.RAA23381@cmn29.stanford.edu>
References: <200208092141.XAA22116@papaschlumpf.wg>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200208092141.XAA22116@papaschlumpf.wg>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi! Anybody out there has managed to get this combination
working? The hdsp driver on a Hammerfall DSP works fine with
"Internal" preferred sync, but chokes when trying to sync the
card to external sources. This happens using both "ADAT1" and
"Word" as sync sources - in both cases the front panel LEDs
for ADAT1 and Word Clock light up solid when the external
source is connected. Playback fails with weird errors:

# aplay --verbose -D plughw:1 test-tones-stereo.wav
Playing WAVE 'test-tones-stereo.wav' : Signed 16 bit Little Endian, Rate 44100  
Hz, Stereo
ALSA lib pcm_hw.c:292:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed:  
Operation not permitted
aplay: set_params:787: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (92879 92880)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: 2
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 10000

This is what proc has to say about the card:

# cat /proc/asound/HammerfallDSP/hdsp
RME Hammerfall DSP (Digiface) (Card #2)
Buffers: capture cf000000 playback cee00000
IRQ: 17 Registers bus: 0xf4900000 VM: 0xd09d6000
Control register: 0x100608c
Status register: 0x12c40008
Status2 register: 0xffff0041
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Latency: 4096 samples (2 periods of 16384 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1
Sync reference: Word/ADAT1
Sample rate: 44100

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off

IEC958 sample rate: Error flag set

ADAT1: Sync
ADAT2: No Lock
ADAT3: No Lock

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
