From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: SB Audigy 2. CAPTURE does not work any more. Latest CVS.
Date: Fri, 09 Apr 2004 22:14:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4077121D.3080709@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

bash-2.05b#arecord
RIFF$WAVEfmt @dataRecording WAVE 'stdout' : Unsigned 8 bit, Rate 8000 
Hz, Mono
bash-2.05b#

Thats it. No error message, nothing recorded, just immeadiately exits.
also: -
bash-2.05b# arecord -Dhw:0
RIFF$WAVEfmt @dataRecording WAVE 'stdout' : Unsigned 8 bit, Rate 8000 
Hz, Mono
arecord: set_params:832: Sample format non available

bash-2.05b# arecord -fdat -Dhw:0
RIFF$WAVEfmt »îdataRecording WAVE 'stdout' : Signed 16 bit Little 
Endian, Rate 48000 Hz, Stereo
bash-2.05b#

bash-2.05b# cat info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: emu10k1
name: EMU10K1
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
bash-2.05b#

So, the card is not being used by any other device.

Anybody got any clues?
latest CVS of alsa-driver, alsa-lib and alsa-utils as of 1 hour ago!

Note: Audio playback works fine. I can play DVDs, use aplay to play .wav 
files, just not record!

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
