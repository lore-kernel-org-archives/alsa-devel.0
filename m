From: Mark Knecht <markknecht@attbi.com>
Subject: Re: HDSP 9652 - Some first results, but lockups and no
	actual audio
Date: 12 Apr 2003 11:22:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050171742.1218.14.camel@Wizard>
References: <1050169066.1183.31.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050169066.1183.31.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, PlanetCCRMA <planetccrma@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org

Hi,
Just a bit more info. By rebooting and doing a couple of power cycles on
the external A/D/D/A I have been able to get the RME to acknowledge that
it's seeing an ADAT sync at 44.1K, so I think at least the clock is
being sent.

This specific external unit (AI-3 for now) supports a loopback, where
the ADAT in can be looped and sent back on its ADAT out. In doing this,
I cannot see the audio signal I send it, implying that it is actually
not receiving one.

Also, I sent the wave file recorded using jackrec to my Windows box. (A
copy of a Yellowjackets tune) It plays fine, so it appears that jack and
alsaplayer are working OK.

Thanks in advance again.

Cheers,
Mark

On Sat, 2003-04-12 at 10:37, Mark Knecht wrote:
> [root@Wizard card0]# more /proc/asound/card0/hdsp
> RME HDSP 9652 (Card #1)
> Buffers: capture dde00000 playback ddc00000
> IRQ: 10 Registers bus: 0xe8800000 VM: 0xe0967000
> Control register: 0x1008098
> Status register: 0x6086a48
> Status2 register: 0xffff8061
> FIFO status: 0
> MIDI1 Output status: 0xffffff00
> MIDI1 Input status: 0xffffff80
> MIDI2 Output status: 0xffffff00
> MIDI2 Input status: 0xffffff5f
> 
> Buffer Size (Latency): 1024 samples (2 periods of 4096 bytes)
> Hardware pointer (frames): 1024
> Passthru: no
> Line out: on
> Firmware version: 1
> 
> Sample Clock Source: Internal 44.1 kHz
> Preferred Sync Reference: ADAT1
> AutoSync Reference: ADAT1
> AutoSync Frequency: 48000
> System Clock Mode: Master
> System Clock Frequency: 44100
> 
> IEC958 input: Internal
> IEC958 output: Coaxial only
> IEC958 quality: Consumer
> IEC958 emphasis: off
> IEC958 NonAudio: off
> IEC958 sample rate: Error flag set
> 
> ADAT1: Lock
> ADAT2: No Lock
> ADAT3: No Lock
> SPDIF: No Lock
> Word Clock: No Lock
> ADAT Sync: No Lock
> 
> [root@Wizard card0]#
> 

[mark@Wizard mark]$ cat /proc/asound/card0/hdsp
RME HDSP 9652 (Card #1)
Buffers: capture de600000 playback de400000
IRQ: 10 Registers bus: 0xe8800000 VM: 0xe0967000
Control register: 0x1008090
Status register: 0x2040008
Status2 register: 0xffff8041
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff3d
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff39

Buffer Size (Latency): 64 samples (2 periods of 256 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: Internal 44.1 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: ADAT1
AutoSync Frequency: 44100
System Clock Mode: Master
System Clock Frequency: 44100

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: Sync
ADAT2: No Lock
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

[mark@Wizard mark]$




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
