From: d <dieb13@klingt.org>
Subject: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 14:38:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED5FF3A.3040906@klingt.org>
References: <Pine.LNX.4.44.0305291344040.28435-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305291344040.28435-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

dear alsa gurus!
i'm trying to get a rme hdsp 9652 to work, and have bad results:
loading snd-hammerfall-mem and snd-hdsp works fine, starting jack or 
some alsa-playback too (or at least seems to).
but when i start alsamixer or alsactl and want to unmute the channels i 
get massive xruns and no sound, sometimes a kernel panic.
i tried a pentium3- and a amd-duron system and ran into the same behavior.
the card worked for the previous owner, but i have no windows-system to 
test it there.

has anybody had similar expiriences or any hints for me?
regards
d13b


my setup:
rme hdsp 9652 with adi8-ae interface
kernel 2.4.20 (straight forward)
latest alsa from cvs

cat /proc/asound/card0/hdsp  gives me:

RME HDSP 9652 (Card #1)
Buffers: capture d4000000 playback d3e00000
IRQ: 12 Registers bus: 0xeb000000 VM: 0xdc8a2000
Control register: 0x10080de
Status register: 0x3400008
Status2 register: 0xffff8041
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff38
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff38

Buffer Size (Latency): 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: Internal 48 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: ADAT1
AutoSync Frequency: 44100
System Clock Mode: Master
System Clock Frequency: 48000

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: Lock
ADAT2: No Lock
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
