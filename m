From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp patch
Date: 15 Jun 2003 20:27:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055734069.2741.66.camel@Wizard.knechthome.com>
References: <E19RjsK-00057y-00@sc8-sf-list1.sourceforge.net>
	 <1055734014.2748.64.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055734014.2748.64.camel@Wizard.knechthome.com>
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

On Sun, 2003-06-15 at 20:26, Mark Knecht wrote:

> Cool. Something to look for anyway....
> 
> 15 minutes later.
> 
> Bingo! OK, so the new driver hadn't gotten moved to the right place. It
> seems to be there now. I'm getting sound, but it's full volume and I
> don't seem to be able to turn it down. (And I only have a few more
> minutes before my kid goes to sleep. Or tries to...) ;-)
> 
> I have alsamixer up and running, and the volumes turned down to 6 and
> it's still screaming loud. Is this like the old driver where the mixer
> didn't work at all? Or have I not set the right things?
> 
> The other thing I notice is I only seem to be able to set 24 values in
> my little script to set volumes. The driver I just replaced allowed me
> to set all 26.
> 
> OK, so a lot of progress, but I need to be able to reduce the volume
> badly!!!
> 
> What can I send you to see if it's my problem?
> 
> Also, please answer - do I need to set routing paths through the HDSP
> FPGA to get the mixer working? Can you supply a script to do that if
> it's necessary?
> 
> Thanks,
> Mark

BTW:

Wizard rme9652 # cat /proc/asound/card0/hdsp 
RME Hammerfall HDSP 9652 (Card #1)
Buffers: capture de400000 playback de200000
IRQ: 17 Registers bus: 0xe8800000 VM: 0xe4cf7000
Control register: 0x10080de
Control2 register: 0x800
Status register: 0x2040008
Status2 register: 0xffff8061
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: Internal 48 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: ADAT1
AutoSync Frequency: 48000
System Clock Mode: Master
System Clock Frequency: 48000

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

Wizard rme9652 # 



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
