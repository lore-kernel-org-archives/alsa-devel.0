From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problem with multiopen on SB Audigy 2
Date: Tue, 07 Oct 2003 23:16:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F833B40.9070009@superbug.demon.co.uk>
References: <3F82F126.4000800@superbug.demon.co.uk> <s5h4qylkmbk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000107040605040301010500"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qylkmbk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000107040605040301010500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 07 Oct 2003 18:00:22 +0100,
> James Courtier-Dutton wrote:
> 
>>I have 2 sound cards, card 0 is the motherboard intel/alc650 one, and 
>>card 1 is a SB Audigy2
>>
>>Playing two streams at once on device "front:1" works: -
>>aplay -D front:1 filename.wav
>>aplay -D front:1 filename.wav
>>So, this is playing two files to the SB Audigy2 front speakers.
>>I can hear the two files being mixed together and output together to a 
>>single set of speakers.
>>
>>Playing two streams at once on device "rear:1" fails: -
>>aplay -D rear:1 filename.wav
>>aplay -D rear:1 filename.wav
>>So, this is trying to play two files to the SB Audigy2 rear speakers.
>>
>>The first files comes out of the rear speakers, but the output from the 
>>second aplay command fails with: -
>>
>>bash-2.05b# aplay -D rear:1 filename.wav
>>Playing WAVE 'filename.wav' : Signed 16 bit Little Endian, Rate 44100 
>>Hz, Stereo
>>ALSA lib setup.c:94:(snd_sctl_install) Cannot lock ctl elem
>>aplay: set_params:876: Unable to install hw params:
>>ACCESS:  RW_INTERLEAVED
>>FORMAT:  S16_LE
>>SUBFORMAT:  STD
>>SAMPLE_BITS: 16
>>FRAME_BITS: 32
>>CHANNELS: 2
>>RATE: 44100
>>PERIOD_TIME: (125011 125012)
>>PERIOD_SIZE: 5513
>>PERIOD_BYTES: 22052
>>PERIODS: 2
>>BUFFER_TIME: (250022 250023)
>>BUFFER_SIZE: 11026
>>BUFFER_BYTES: 44104
>>TICK_TIME: 1000
>>
>>Can you explain why this might be happening?
> 
> 
> this is because the "Wave Surround Playback Volume" control is locked
> by the first rear stream.
> you can find it in /usr/share/alsa/cards/Audigy2.conf.
> please try to remove the lock.
> 
> 
> Takashi
> 
Thanks that fixed the problem.
Please see attached patch files, for the SB Live and Audigy2, both of 
which have been tested.

Cheers
James

--------------000107040605040301010500
Content-Type: text/plain;
 name="Audigy2-rear-multiopen-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Audigy2-rear-multiopen-fix.diff"

--- Audigy2.conf.org	2003-10-07 23:07:43.642213872 +0100
+++ Audigy2.conf	2003-10-07 23:13:48.954677936 +0100
@@ -31,12 +31,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Surround Playback Volume"
-				preserve true
-				lock true
-				value [ 0 0 ]
-			}
-			{
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true

--------------000107040605040301010500
Content-Type: text/plain;
 name="emu10k1-rear-multiopen-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1-rear-multiopen-fix.diff"

--- EMU10K1.conf.org	2003-10-07 23:13:20.972931808 +0100
+++ EMU10K1.conf	2003-10-07 23:13:31.115389920 +0100
@@ -31,12 +31,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Surround Playback Volume"
-				preserve true
-				lock true
-				value [ 0 0 ]
-			}
-			{
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true

--------------000107040605040301010500--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
