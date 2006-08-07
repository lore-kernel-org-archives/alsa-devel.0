From: Tim Burrell <tim@timburrell.net>
Subject: Re: hda intel driver and no surround sound with nvidia
 mcp55 (chip ID RealTek 888)
Date: Mon, 07 Aug 2006 09:52:08 -0300
Message-ID: <44D73778.4060301@timburrell.net>
References: <44D4BD9F.9010601@timburrell.net>	<Pine.LNX.4.61.0608051946190.9377@tm8103.perex-int.cz>	<44D4F4B4.4040708@timburrell.net>
	<s5hvep4rah2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvep4rah2.wl%tiwai@suse.de>
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

>>>> I'm trying to get multichannel sound working on my nvidia nforce 590
>>>> based mobo that uses the intel hd audio (nvidia mcp55) chipset.  It
>>>> plays fine in two channels but any attempts to use -Dsurround51 or
>>>> -Dsurround40 fail.  Ie:
>>>>
>>>> Playing WAVE 'space_battle.wav' : Signed 16 bit Little Endian, Rate
>>>> 44100 Hz, Channels 6
>>>> aplay: set_params:906: Channels count non available
>>> That's correct. Use -Dplug:surround40, because the count of channels from 
>>> the .wav file has to be converted to four.
>> I just upgraded to 1.0.12_rc2, and I've got a lot more mixer controls in
>> alsamixer now.  I can see front, rear, surround, etc.  And now I can
>> finally specify -Dplug:surround71 to get 8 channel audio!
>>
>> However, there is one problem.  On my card the channels are not exactly
>> correct when running speaker-test.  The side and rear speakers are
>> reversed.  I double checked this with my card's manual, and in Windows.
> 
> Does -Dplug:surround51 work as expected?

speaker-test hangs when I use plug:surround51, however since upgrading I
incorrectly said that mplayer hangs when playing multichannel audio.
When playing a 6 channel audio file with mplayer (it says it uses
surround51) it also has the rear and side channels reversed.  Obviously
since it's 6 channel audio the side channels are not used, but the rear
channels come out of the side speakers.

> 
>> Also, curiously, using the same settings as speaker-test (which works
>> fine), aplay hangs when trying to play multichannel audio files.  Same
>> for mplayer (with or without -channels settings).
> 
> What do you mean "hang"?

By hang, I mean aplay and speaker-test open the device fine, and begin
playing, but do not play any samples and then just sit there
indefinitely.  Ie I see the following output from `speaker-test
-Dplug:surround51 -c 6`:

Playback device is plug:surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 22 to 5461
Period size range from 11 to 2730
Using max buffer size 5460
Periods = 4
was set period_size = 1365
was set buffer_size = 5460
 0 - Front Left

Then no audio is heard and it sits there and does nothing until I press
ctrl-c.

The same goes for aplay using either -Dplug:surround51 OR -Dplug:surround71.

Why mplayer works and aplay doesn't is a mystery to me.  It's also quite
odd that speaker-test works in 8 channels and aplay doesn't.

Either way I'm happy enough with the setup.  I can watch movies in
surround and that's really all I wanted, but I thought this information
might be useful to you ALSA devs.

I don't mind testing, or helping out so if I can provide more
information or if there's anything I can do I'd be happy to lend a hand.

Tim.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
