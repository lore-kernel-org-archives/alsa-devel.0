From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp patch
Date: 14 Jun 2003 08:43:45 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055605425.1821.9.camel@Wizard.knechthome.com>
References: <200306140455.h5E4tao15150@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306140455.h5E4tao15150@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul,
   Hi. Thanks for sendign these along. First steps look good. I've
managed to patch things and it does install.

QUESTION - I am not explicitly loading snd-hammerfall-mem, but it is
getting loaded when I start Alsa. Is this correct? I should _not_
explicitly load that file anywhere, but just let the driver load it?

   Also, I seem to have had some problems with the second patch you
sent. It didn't apply. I'm sure it's just me. IT was so simple so I just
typed it into the file. Were these sent as attachments, or as text
within the email?

   Hopefully I'll get some sound later today. Currently nothing is
hooked up to the card, so that will take a while to switch over as
everything is quite buried right now.

Thanks,
Mark

Wizard alsa-driver # lsmod
Module                  Size  Used by    Not tainted
snd-hdsp               32556   0 
snd-rawmidi            15040   0  [snd-hdsp]
snd-seq-device          4352   0  [snd-rawmidi]
snd-pcm                64928   0  [snd-hdsp]
snd-timer              15876   0  [snd-pcm]
snd-page-alloc          5404   0  [snd-pcm]
snd-hwdep               5216   0  [snd-hdsp]
snd                    32836   0  [snd-hdsp snd-rawmidi snd-seq-device
snd-pcm snd-timer snd-hwdep]
snd-hammerfall-mem      1920   0  [snd-hdsp]
radeon                107972   1 
agpgart                11920   3  (autoclean)
ide-cd                 27080   0  (autoclean)
cdrom                  25984   0  (autoclean) [ide-cd]
Wizard alsa-driver # 


Wizard card0 # more hdsp 
RME HDSP 9652 (Card #1)
Buffers: capture dee00000 playback df000000
IRQ: 17 Registers bus: 0x28800000 VM: 0xe08e6000
Control register: 0x100805e
Status register: 0x2800000
Status2 register: 0xffff8701
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff3a
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff39

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: Internal 32 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: None
AutoSync Frequency: 0
System Clock Mode: Master
System Clock Frequency: 32000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: No Lock
ADAT2: No Lock
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

Wizard card0 # 

On Fri, 2003-06-13 at 21:55, Paul Davis wrote:
> this patch fixes some basic problems with the hdsp driver with respect
> to the hdsp9652 card. it also cleans up a few minor issues with naming
> in the driver, and slightly rationalizes initialization to involve
> the minimum of special-casing for the hdsp9652.
> 




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
