From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: hdsp I/O-error
Date: Sun, 13 Apr 2003 03:33:23 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304130333.23356.Jaakko.Prattala@Helsinki.FI>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI> <200304121240.17736.Jaakko.Prattala@Helsinki.FI> <1050176702.1427.681.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050176702.1427.681.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello again. Maybe these will mean something?

This is /proc/asound/card0/hdsp when I've loaded the firmware
in windows:

RME Hammerfall DSP + Multiface (Card #1)
Buffers: capture c0e00000 playback c0c00000
IRQ: 11 Registers bus: 0x10800000 VM: 0xcf977000
Control register: 0x10080de
Status register: 0x12000000
Status2 register: 0xffff0703
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 5

Sample Clock Source: Internal 48 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: None
AutoSync Frequency: 0
System Clock Mode: Master
System Clock Frequency: 48000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

Strangely, after I cat'ed it again right after, there were some changes:
< Control register: 0x10080de
> Control register: 0x100805c
< Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
> Buffer Size (Latency): 4096 samples (2 periods of 16384 bytes)
< Sample Clock Source: Internal 48 kHz
> Sample Clock Source: Internal 32 kHz
< System Clock Frequency: 48000
> System Clock Frequency: 32000

pd is quite verbose too, maybe this will tell something:

# pd -rt -alsa -nomidi
ALSA lib pcm_hw.c:1078:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed:
Device  or resource busy
snd_pcm_open (output): Device or resource busy
ALSA: sample width 4 bytes
ALSA: set input channels to 14
ALSA: rate to 44100
fragsize b 64
nfrags a 27
ALSA lib pcm_hw.c:325:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS fa=
iled:=20
Device or resource busy
snd_pcm_hw_params (input): Device or resource busy
ALSA: hw interface configured
pd: pcm.c:5020: snd_pcm_sw_params_current: Assertion `pcm->setup' failed.
Aborted

(sampling rate doesn't change in /proc/asound/card0/hdsp)

from /etc/modules.conf:

alias char-major-116 snd
alias snd-card-0 snd-hdsp
options line_outs_monitor=3D"1"
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss


--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
