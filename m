From: Daniel Schroeder <sec@dschroeder.info>
Subject: Re: ASUS M2N32 MCP55 HDAudio problems
Date: Thu, 29 Jun 2006 20:29:37 +0200
Message-ID: <44A41C11.2030900@dschroeder.info>
References: <44A19885.8020104@dschroeder.info>	<s5hwtb1qp16.wl%tiwai@suse.de>	<44A2F28C.509@dschroeder.info>
	<s5h64ikce22.wl%tiwai@suse.de>
Reply-To: sec@dschroeder.info
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64ikce22.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 28 Jun 2006 23:20:12 +0200,
> Daniel Schroeder wrote:
>> Takashi Iwai wrote:
>>> At Tue, 27 Jun 2006 22:43:49 +0200,
>>> Daniel Schroeder wrote:
>>>> Hello *,
>>>>
>>>> sorry for posting this to devel and users, but i think this could be
>>>> interesting for both. Plz. send replies in cc to my mail address because
>>>>  i am not on list.
>>>>
>>>> I am a proud owner of this flagship mainboard with a nvdidia mcp55
>>>> hdaudio sound card. The chip is identified by alsa as a AD1988A rev.2
>>>> (dmesg, lspci -v, lspci -nv output below):
>>>>
>>>> The problem is that if i activate only front in kmix all is fine.
>>>> Speaker-Test works as expected. If i activate lfe/center then the sound
>>>> is messed up and he plays front-left/front-rigt through center and lfe.
>>> What do you mean to "activate lfe/center"?
>>> A more detailed step to reproduce is helpful.
>>>
>>>
>>> Takashi
>> a more detail problem description:
>>
>> with this module configuration: options snd-hda-intel model=6stack-dig
>> position_fix=1
> 
> Doesn't the driver work without position_fix option?

The driver works without these options...i have just played around with
these.

> 
>> --------------------------
>> headphone jack in front: if connected the regular sound isnt muted.
>> --------------------------
>> speaker test hangs in surround51 configuration:
>>
>> speaker-test -Dplug:surround51 -c6
>>
>> speaker-test 1.0.12rc1
>>
>> Playback device is plug:surround51
>> Stream parameters are 48000Hz, S16_LE, 6 channels
>> Using 16 octaves of pink noise
>> Rate set to 48000Hz (requested 48000Hz)
>> Buffer size range from 22 to 5461
>> Period size range from 11 to 2730
>> Using max buffer size 5460
>> Periods = 4
>> was set period_size = 1365
>> was set buffer_size = 5460
>>  0 - Front Left
>> ---- hangs forever
> 
> That's bad.  Does aplay with 6 channel samples work fine?

while true;  do aplay chan-id.wav ; done
Playing WAVE 'chan-id.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Channels 6


aplay with 6 channel sample works but only front left / front right the
other "tracks" in the file are "silent".
Output of front left and front right are: front left all speakers to the
left. front left/rear left/center with output of channel "front right"
all speakers to the right "front right/rear right/subwoofer"

> 
>> ----------------------------
>> speaker-test in surround40
>>
>> front left=sound output rear left;
>> front right=sound output rear right;
>> rear right=sound output subwoofer
>> rear left=sound output center
> 
> So the channels are shifted.
> 
> When you play with 2-channel via "aplay foo.wav", do the samples come
> from front speakers?

aplay 10.wav
Playing WAVE 10.wav : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

sound comes through all speakers, front left/front right/rear left/rear
right/center and subwoofer

> 
> As you might have noticed in the kernel message, there is a workaround
> for AD1988A rev2 codec.  You can disable it by re-defining
> AD1988A_REV2 in patch_analog.c to a bogus value, for example, a patch
> like below.  Then try the tests again.
> 
> 
> Takashi
> 
> diff -r ac7516b5dcb9 pci/hda/patch_analog.c
> --- a/pci/hda/patch_analog.c	Thu Jun 29 13:22:29 2006 +0200
> +++ b/pci/hda/patch_analog.c	Thu Jun 29 14:58:36 2006 +0200
> @@ -1543,7 +1543,8 @@ enum {
>  };
>  
>  /* reivision id to check workarounds */
> -#define AD1988A_REV2		0x100200
> +// #define AD1988A_REV2		0x100200
> +#define AD1988A_REV2		0xabcd1234 /* bogus */
>  
>  
>  /*
i have patched the file patch_analog.c recompiled and loaded the module.
same bad behaviour. Im sure that he has taken the new module because the
dmesg output is missing.

----

have you any clues of what i could do? This stuff is a bit mysterious
for me. Why does he play a stereo wav file to all speakers. And why does
he plays only two channels of the surround file (chan-id.wav) and these
two channels getting splitted to every left speaker / every right speaker...

,
daniel


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
