From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: snd-aloop not working in linux-3.12.10
Date: Thu, 5 Mar 2015 13:45:22 +0000
Message-ID: <1425563166355.75990@tataelxsi.co.in>
References: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
 <20150304161013.GU2613@intel.com>	<54F73421.3000108@imgtec.com>
 <20150305070018.GW2613@intel.com>	<54F80916.50703@perex.cz>
 <20150305083054.GY2613@intel.com> <s5h7fuv25dc.wl-tiwai@suse.de>
 <54F84E0D.1070907@imgtec.com>,<54F85C82.9010608@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1bn0101.outbound.protection.outlook.com [134.170.140.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A35E2658B7
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 14:45:26 +0100 (CET)
In-Reply-To: <54F85C82.9010608@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear Jaroslav

As this feature ie., snd-aloop designed by you,  could you please redirect to the respective links where my queries can be posted & get the solutions for the problem

As we are trying to establish GSM two way calls via stereo codec

We are planning to use loopback module (ie.,snd-aloop and alsaloop in ti sdk 7) to connect the sink/source and source/sink GSM and Codec. 

The below is the virtual devices created after configuring snd-aloop in the linux kernel 3.12.10

card 0, device 0
card 0, device 1

whatever am playing we are unable to record in the virtual device, but we are able to play & record with actual device

aplay -D hw:0,0,0 play.wav
arecord -D hw:0,1,0 record.wav or alsaloop -C hw:0,1 -P hw:0,0 -t 50000 # second terminal, latency 50ms

As per the logs below, am using the above commands to perform loopback, could you please let me know why am unable to perform the loopback with the below commands or please let me know am I missing any configurations, 

As this is feature is not working in ti sdk 7 (ie.,snd-aloop and alsaloop), 

Kindly requesting to try in your am335x-evm where it has tlv codec & verify this feature ie., snd-aloop & let me know as early as possible


logs :
======
root@am335x-evm:/# ls /dev/snd/   
by-path    controlC1  pcmC0D0p   pcmC0D1p   pcmC1D0p
controlC0  pcmC0D0c   pcmC0D1c   pcmC1D0c   timer
root@am335x-evm:/# cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 48: [ 1- 0]: digital audio playback
 56: [ 1- 0]: digital audio capture
root@am335x-evm:/# 

Loopback device
----------------
root@am335x-evm:/# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 0: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 1: UDA1345TS [TI UDA1345TS], device 0: UDA134x uda134x-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@am335x-evm:/# aplay -D hw:0,0,0 TangoForTajMusic11.wav 
Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo



Actual device
-------------
root@am335x-evm:/# aplay -D hw:1,0,0 TangoForTajMusic11.wav                                                                                    
Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Li[ 2219.654309] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK=12288000
ttle Endian, Rate 48000 Hz, Stereo
[ 2219.663776] DAVINCIIIIIIIIII UDA134XXXXX BCLK FREQQ=1536000
[ 2219.672880] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK/BCLK_FREQ =8
[ 2219.678982] uda134x_hw_params CLOCKS uda134x_hw_params uda134x->sysclk: 12288000, params_rate(params):48000
[ 2219.689474] uda134x_hw_params FORMATS uda134x_hw_params dai_fmt: 16385, params_format:2
[ 2219.698095] uda134x_hw_params FORMATS uda134x_hw_params uda134x->sysclk / params_rate(params) 256
[ 2219.707644] UDA1345TSSSSSSSSSSSS SYSCLK / fs ratio is 256
[ 2219.713470] uda134x_hw_params dai_fmt: 16385, params_format:2
[ 2219.719639] UDA1345TSSSSSSSSSSSS FORMAT SND_SOC_DAIFMT_I2S
[ 2219.725716] ENTERED davinci_config_channel_size davinci_config_channel_size: tx_rotate = 4
[ 2219.734620] ENTERED davinci_config_channel_size davinci_config_channel_size: MASK= 65535
[ 2219.748324] uda134x_unnnnnnnnmuteeeeeeeeee uda134x_mute mute: 0
[ 2219.756522] davinci_mcasp_starttttttttttttttttttttt SNDRV_PCM_STREAM_PLAYBACK 


Kindly do the needful as early as possible
Awaiting for your replies,

Many Thanks in advance,

________________________________________
From: alsa-devel-bounces@alsa-project.org <alsa-devel-bounces@alsa-project.org> on behalf of Jaroslav Kysela <perex@perex.cz>
Sent: Thursday, March 5, 2015 7:09 PM
To: Qais Yousef; Takashi Iwai; Vinod Koul
Cc: alsa-devel@alsa-project.org; Mark Brown; Pierre-Louis Bossart
Subject: Re: [alsa-devel] [ALSA-UTILS][PATCH] Add support for cplay and crecord

Dne 5.3.2015 v 13:37 Qais Yousef napsal(a):
> On 03/05/2015 08:52 AM, Takashi Iwai wrote:
>> At Thu, 5 Mar 2015 14:00:54 +0530,
>> Vinod Koul wrote:
>>> On Thu, Mar 05, 2015 at 08:43:18AM +0100, Jaroslav Kysela wrote:
>>>> Dne 5.3.2015 v 08:00 Vinod Koul napsal(a):
>>>>> On Wed, Mar 04, 2015 at 04:34:41PM +0000, Qais Yousef wrote:
>>>>>> On 03/04/2015 04:10 PM, Vinod Koul wrote:
>>>>>>> On Wed, Mar 04, 2015 at 03:36:00PM +0000, Qais Yousef wrote:
>>>>>>>> cplay and crecord use compress offload API to play and record compressed audio.
>>>>>>>>
>>>>>>>> They're based on cplay and crec from tinycompress library using LGPL license.
>>>>>>>>
>>>>>>>> For now cplay only supports playing mp3 files.
>>>>>>>>
>>>>>>>> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>>>>>>>> Cc: Takashi Iwai <tiwai@suse.de>
>>>>>>>> Cc: Vinod Koul <vinod.koul@intel.com>
>>>>>>>> Cc: Mark Brown <broonie@kernel.org>
>>>>>>>> ---
>>>>>>>> I renamed crec to crecord also to match aplay and arecord, hopefully
>>>>>>>> you don't mind Vinod.
>>>>>>> No thats fine..
>>>>>>>
>>>>>>>> This patch is dependent on my other patch that adds support for compress offload
>>>>>>>> to alsa-lib.
>>>>>>> And where is that, should have preceded this
>>>>>> Hmm not sure what went wrong. I resent it. Seems I have some emailer
>>>>>> issues as I had this problem before.
>>>>>> Hopefully you received it now.
>>>>>>
>>>>>>>> I needed to include <sound/compress_params.h> in cplay.c and crec.c
>>>>>>>> but I couldn't find an example of any C file which directly includes <sound/*.h>
>>>>>>>> The norm seems to be to just include <alsa/asoundlib.h>. Do I need to
>>>>>>>> redefine structs from <sound/compress_params.h> to newly added <alsa/compress.h>?
>>>>>>>> <alsa/pcm.h> seems to redefine structs from <sound/asound.h>.
>>>>>>> These are kernel headers and should be in your include path if you have
>>>>>>> those installed
>>>>>>>> I could only test cplay but have no means to test crecord at the moment.
>>>>>>>>
>>>>>>>>   Makefile.am       |   3 +
>>>>>>>>   configure.ac      |   6 +-
>>>>>>>>   cplay/Makefile.am |  14 ++
>>>>>>>>   cplay/cplay.c     | 294 +++++++++++++++++++++++++++++++++++
>>>>>>>>   cplay/crec.c      | 449 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>   cplay/tinymp3.h   |  72 +++++++++
>>>>>>>>   6 files changed, 837 insertions(+), 1 deletion(-)
>>>>>>>>   create mode 100644 cplay/Makefile.am
>>>>>>>>   create mode 100644 cplay/cplay.c
>>>>>>>>   create mode 100644 cplay/crec.c
>>>>>>>>   create mode 100644 cplay/tinymp3.h
>>>>>>> Okay here is where we need discussion on the future course. If we do this
>>>>>>> then we end up in two code bases, something I would not encourage!
>>>>>>>
>>>>>>> On the other hand if we add the make file changes to tinycompress or if
>>>>>>> required split this into two, lib and tools and then package lib part into
>>>>>>> alsa-lib and players into tools, that way we can have single code base. That
>>>>>>> was my intent behind ensuring that this is dual licensed.
>>>>>> I'm not sure I follow you completely here. You mean keep cplay and
>>>>>> crec in tinycompress with the dual licensing but only merge the lib
>>>>>> part (which my other patch does) into alsa-lib? For me having this
>>>>>> lib part into alsa-lib is the important bit. Moving crec and cplay
>>>>>> to alsa-utils was something I thought would be useful but maybe not.
>>>>> Not that
>>>>>
>>>>> Since alsa splits lib and tools, in order to take this into alsa-libs we
>>>>> need to split tinycompress, to something like lib and tool part.
>>>>>
>>>>> Then alsa-lib can import the lib part of tinycompress. Please note I am not
>>>>> saying we should copy or move code into alsa-lib.
>>>>> The reason for that is
>>>>> 1. copying code will cause more maintaince of same code in two places :(
>>>>> 2. moving into alsa-lib is not an option as existing users like android will
>>>>> suffer as they dont use alsa-lib
>>>>>
>>>>> So I think, while building and packaging alsa-library and tools we can
>>>>> import the tinycompress using LGPL license and use that to give complete
>>>>> library on Linux to users
>>>>>
>>>>> Takashi, can we get you blessing for this approach before we embark on this,
>>>>> or any other better ideas?
>>>> The problem is if the code is not duplicated, then the parts of the
>>>> alsa-lib binary will be dual-licenced. I don't think that it's the right
>>>> way.
>>>>
>>>> And if the code is duplicated, then patch authors for all next updates
>>>> in both libraries (alsa-lib, tinycompress) must be asked for permissions
>>>> to change code licence for the merge to the second library.
>>>>
>>>> I think that a plugin-style extension should be created here (so
>>>> tinycompress will be used at runtime as the dynamic library).
>>>>
>>>> compress API -> tinycompress plugin -> tinycompress .so functions
>>>>
>>>> This will allow us also to create another plugins in future.
>>> That does solve the issue for me as well. The intent is to provide
>>> compressed functionality within alsa-libs so asa plugin that can work very
>>> well...
>>>
>>> Any other thoughts... ?
>> Well, tinycompress itself is merely a thin layer covering the kernel
>> ABI.  So, writing a plugin infrastructure itself already achieves the
>> whole rewrite of tinycompress library.  What else remains as a plugin
>> content?
>>
>>
>> Takashi
>
> OK reading a bit more about dual license what I understood is that it's
> ok for alsa-lib to choose redistribute tinycompress as LGPL only.
> To cope with code duplication we could create tinycompress as a git
> submodule and educate alsa-lib build system to pull a tag and use that
> to compile the support for compress api.
>
> Makes sense?

Thinking again about this and all suggested variants to use the
tinycompress code are not ideal. The alsa-lib is LGPL. Dot. I don't
think that we want to link (compile time linking) to any external code.

My .so plugin proposal is probably ok, but as Takashi said, it means
that the alsa-lib API code would be more bigger than the ioctl wrapper
code in tinycompress - the question is if it makes sense.

So I think that the best way is to fork the code and create compatible
APIs (headers) with the possible API change syncing.

                                Thanks,
                                        Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
