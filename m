From: Safari <safari-ml-alsa-devel@safari.homelinux.net>
Subject: Re: 1.0.2 release
Date: Tue, 27 Jan 2004 14:44:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040127124422.GA16202@msgid.safari.homelinux.net>
References: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from adonis.kotinet.com (adonis.kotinet.com [212.50.211.55])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA19691
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 13:44:56 +0100
Received: from safari.homelinux.net (adsl-82-141-70-99.kotinet.com [82.141.70.99])
	by adonis.kotinet.com (Postfix) with ESMTP id 84190CDFE5
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 14:44:23 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2004 at 10:51:58AM +0100, Jaroslav Kysela wrote:
> Hello all,
> 
> 	we released packages 1.0.2.
...
> alsa-lib
>   * general
>     - added SNDRV_PCM_STATE_DISCONNECTED state
>     - fixed SHM memory leak fix in pcm routines
>     - fixed non-version build
>     - removed the function-in-function for qsort

great! alsamixer does not segfault anymore with exec-shield.

but I have some problems with v1.0.2: sample rate 44100 does not work,
it was fine with v1.0.1.

$ arecord -d 1 -v -r 22050 -f S16_LE -c 2 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050.8 (1572864000/71329)
msbits       : 16
buffer_size  : 11025
period_size  : 2756
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2756
xfer_align   : 2756
start_threshold  : 1
stop_threshold   : 11025
silence_threshold: 0
silence_size : 0
boundary     : 1445068800

$ arecord -d 1 -v -r 44100 -f S16_LE -c 2 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
arecord: pcm_rate.c:512: snd_pcm_rate_init: Assertion `0' failed.
Aborted by signal Aborted...

$ arecord -d 1 -v -r 44100 -f S16_LE -c 1 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
arecord: pcm_rate.c:512: snd_pcm_rate_init: Assertion `0' failed.
Aborted by signal Aborted...

$ arecord -d 1 -v -r 44101 -f S16_LE -c 2 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44101 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

Its setup is:
stream       : CAPTURE

access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44101
exact rate   : 44101.1 (1572864000/35665)
msbits       : 16
buffer_size  : 16384
period_size  : 5513
period_time  : 125005
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 5513
xfer_align   : 5513
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824

$ arecord -d 1 -v -r 48000 -f S16_LE -c 2 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (1572864000/32768)
msbits       : 16
buffer_size  : 16384
period_size  : 6000
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824


$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.2.
Compiled on Jan 27 2004 for kernel 2.4.24-exec-shield-xfs with versioned symbols.

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371 DAC2/ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ gcc -v
Reading specs from /usr/local/lib/gcc-lib/i686-pc-linux-gnu/3.3.2/specs
Configured with: /wrk2/safari/gcc-3.3.2/configure --enable-threads
Thread model: posix
gcc version 3.3.2


lspci says

0000:00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 74 12 71 13 05 00 10 34 06 00 01 04 00 40 00 00
10: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 74 12 71 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0c 80
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 31 6c
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

>     - CMIPCI, ICE1712 - fixed the iec958 capture using asym plugin


>   * direct plugins
>     - close all file descriptors in server_job()
>     - improved compatibility with xine (fixes in poll() implemetation)
>     - added slowptr option which improves pointer accuracy
>     - dmix optimizations
> alsa-utils
>   * improved amidi
> 
> 						Jaroslav

-- 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
