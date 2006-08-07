From: Tim Burrell <tim@timburrell.net>
Subject: Re: hda intel driver and no surround sound with nvidia
 mcp55 (chip ID RealTek 888)
Date: Mon, 07 Aug 2006 10:27:42 -0300
Message-ID: <44D73FCE.4060007@timburrell.net>
References: <44D4BD9F.9010601@timburrell.net>	<Pine.LNX.4.61.0608051946190.9377@tm8103.perex-int.cz>	<44D4F4B4.4040708@timburrell.net>	<s5hvep4rah2.wl%tiwai@suse.de>	<44D73778.4060301@timburrell.net>
	<s5hmzagr99e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmzagr99e.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

>>>>>> I'm trying to get multichannel sound working on my nvidia nforce 590
>>>>>> based mobo that uses the intel hd audio (nvidia mcp55) chipset.  It
>>>>>> plays fine in two channels but any attempts to use -Dsurround51 or
>>>>>> -Dsurround40 fail.  Ie:
>>>>>>
>>>>>> Playing WAVE 'space_battle.wav' : Signed 16 bit Little Endian, Rate
>>>>>> 44100 Hz, Channels 6
>>>>>> aplay: set_params:906: Channels count non available
>>>>> That's correct. Use -Dplug:surround40, because the count of channels from 
>>>>> the .wav file has to be converted to four.
>>>> I just upgraded to 1.0.12_rc2, and I've got a lot more mixer controls in
>>>> alsamixer now.  I can see front, rear, surround, etc.  And now I can
>>>> finally specify -Dplug:surround71 to get 8 channel audio!
>>>>
>>>> However, there is one problem.  On my card the channels are not exactly
>>>> correct when running speaker-test.  The side and rear speakers are
>>>> reversed.  I double checked this with my card's manual, and in Windows.
>>> Does -Dplug:surround51 work as expected?
>> speaker-test hangs when I use plug:surround51, however since upgrading I
>> incorrectly said that mplayer hangs when playing multichannel audio.
>> When playing a 6 channel audio file with mplayer (it says it uses
>> surround51) it also has the rear and side channels reversed.  Obviously
>> since it's 6 channel audio the side channels are not used, but the rear
>> channels come out of the side speakers.
> 
> OK, then it's either a bug of BIOS or a specification of HD-audio.
> A tentative patch is below.

Thanks the patch!  I applied it, and channel output now works as
expected!  Must be irritating having to cope with all the different
hardware variations / flaws!

>>>> Also, curiously, using the same settings as speaker-test (which works
>>>> fine), aplay hangs when trying to play multichannel audio files.  Same
>>>> for mplayer (with or without -channels settings).
>>> What do you mean "hang"?
>> By hang, I mean aplay and speaker-test open the device fine, and begin
>> playing, but do not play any samples and then just sit there
>> indefinitely.
> 
> Interesting.  So, you started like:
> 
> 	% aplay -Dplug:surround51 somefile.wav

Yes, originally I also put "-c 6" in there, but I just tried exactly as
above, and got the same results.  aplay looks like it starts playing,
and then sits indefinitely.

> ??  Does any process block the sound device?  You can check it via
> "lsof /dev/snd/pcm* /dev/dsp*", for example.

nope, lsof as you suggested showed nothing is blocking, and when
something else is using the device aplay will give me a "device busy"
error which it does not in this case.  Also, if I run aplay on the same
audio file without specifying -Dplug:surround51 aplay will play the
audio without hanging (albeit in 2 channel mode).

>>  Ie I see the following output from `speaker-test
>> -Dplug:surround51 -c 6`:
>>
>> Playback device is plug:surround51
>> Stream parameters are 48000Hz, S16_LE, 6 channels
>> ...
>>  0 - Front Left
>>
>> Then no audio is heard and it sits there and does nothing until I press
>> ctrl-c.
>>
>> The same goes for aplay using either -Dplug:surround51 OR -Dplug:surround71.
> 
> "same" == "aplay doesn't process any samples"?

Sorry, I can't say for sure what aplay is doing, but it looks to me like
it does the same thing.  It opens the sound card, and appears to start
playing, but no audio is heard, and it sits indefinitely, just as
speaker-test does when using plug:surround51.

> What shows "aplay -v -Dplug:surround51 some6ch.wav" ?

Here is the output:

% aplay -v -Dplug:surround51 chan-id.wav
Playing WAVE 'chan-id.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Channels 6
Plug PCM: Soft volume PCM
Control: PCM Playback Volume
min_dB: -48
resolution: 256
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 6
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 5460
  period_size  : 1365
  period_time  : 30952
  tick_time    : 1000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1365
  xfer_align   : 1365
  start_threshold  : 5460
  stop_threshold   : 5460
  silence_threshold: 0
  silence_size : 0
  boundary     : 1431306240
Slave: Hardware PCM card 0 'HDA NVidia' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 6
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 5460
  period_size  : 1365
  period_time  : 30952
  tick_time    : 1000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1365
  xfer_align   : 1365
  start_threshold  : 5460
  stop_threshold   : 5460
  silence_threshold: 0
  silence_size : 0
  boundary     : 1431306240

Then after that there is no output and it sits there until I ctlr-c it.

Tim.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
