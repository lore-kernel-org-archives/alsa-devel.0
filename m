From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: snd-aloop not working in linux-3.12.10
Date: Mon, 9 Mar 2015 05:09:48 +0000
Message-ID: <1425877835921.58813@tataelxsi.co.in>
References: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
 <20150304161013.GU2613@intel.com>	<54F73421.3000108@imgtec.com>
 <20150305070018.GW2613@intel.com>	<54F80916.50703@perex.cz>
 <20150305083054.GY2613@intel.com> <s5h7fuv25dc.wl-tiwai@suse.de>
 <54F84E0D.1070907@imgtec.com>,<54F85C82.9010608@perex.cz>
 <1425563166355.75990@tataelxsi.co.in>,<54F86478.7050107@perex.cz>
 <1425573780241.58049@tataelxsi.co.in>,<54F8A5CA.5090309@perex.cz>
 <1425638151396.85144@tataelxsi.co.in>, <54F98F69.7060308@perex.cz>,
 <1425663849401.16670@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1hn0125.outbound.protection.outlook.com [134.170.132.125])
 by alsa0.perex.cz (Postfix) with ESMTP id E2B1626055A
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 06:09:56 +0100 (CET)
In-Reply-To: <1425663849401.16670@tataelxsi.co.in>
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

Dear Jaroslav,

Very Good Morning!

Could you please kindly help me in clarifying my inline doubts, as I am pretty new to linux audio particularly ALSA Framework as I was involved only in intial codec bringup using aplay & arecord utilities , as I was having some trouble getting a grasp on it all,

Once the inline doubts are calrified, I can plan my design accordingly

And you really appreciate your prompt replies for my earlier two queries

Kindly do the needful as early possible

Awaiting for your replies,

Many Many Thanks in advance again,

________________________________________
From: alsa-devel-bounces@alsa-project.org <alsa-devel-bounces@alsa-project.org> on behalf of Srinivasan S <srinivasan.s@tataelxsi.co.in>
Sent: Friday, March 6, 2015 11:13 PM
To: Jaroslav Kysela
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] snd-aloop not working in linux-3.12.10

Once again Many Thanks a lot Jaroslav, and would appreciate a lot

Now am very clear w.r.t loopback card

Basically I need two sound card devices using loopback. One is a GSM modem with a sink/source and the other is a audio codec, Using loopback module to connect the sink/source and source/sink GSM and Codec.

Could you please clarify the following points w.r.t loopback card(as am new to Alsa, Extremely sorry if this doubts seems to be silly for you)

1) As per the link http://alsa.opensrc.org/Jack_and_Loopback_device_as_Alsa-to-Jack_bridge

In the section, The Jack Bridge, ie.,Creating permanent Jack clients using alsa_in and alsa_out

Again am little bit confused in the link it is mentioned that

ie., Since we used subdevice 0,0 for playback and subdevice 0,1 for capture,
I didn't understand that how the signal will be available in subdevice 1,0, which alsa_in listens to. The "cloop" client we created can now be connected to the jack system output ports and o miracle, you will hear your ALSA app :)

Could you please help me out in understanding

# capture client
alsa_in -j cloop -dcloop

# playback client
alsa_out -j ploop -dploop

ie., Is it possible to record using alsa_in & is it possible to playback the same recorded data using alsa_out independently?? or does it has any interdependencies on the loopback card as we discussed earlier (ie., for example in your case loopbackcard hw:3,0 (playback) & loopbackcard hw:3,1 (capture) )

2)Regarding w.r.t alsaloop
aplay -D plughw:1,0 <your_wav_file>
alsaloop -C hw:1,1 -P hw:0,0 -t 50000

i) Could you please clarify ie., alsaloop does this performs the same as one playback device to another capture device
so it returns them to the userspace. ie., after aplay only alsaloop can be used or what??

ii) Could you please clarify ,inorder to use alsaloop is it mandatory to have amixer controls,
I didn't understand as what you said that is  alsaloop detects the PCM
stream paramter changes automatically using the control API ie., amixer -c 3 controls


Kindly do the needful as early as possible

Awaiting for your replies

Once again Many Thanks a lot for your prompt support w.r.t snd-aloop

________________________________________
From: Jaroslav Kysela <perex@perex.cz>
Sent: Friday, March 6, 2015 4:58 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org
Subject: Re: snd-aloop not working in linux-3.12.10

Dne 6.3.2015 v 11:35 Srinivasan S napsal(a):
> Once again many Thanks for the quick responses,
>
> Could you please try  & let me know whether does it works viceversa ie., arecord on loopback card first & then aplay on the loopback card as shown below
>
> $ arecord -D plughw:3,1,0 -f dat -c 1 a.wav
> Recording WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>
> $ aplay -D plughw:3,0,0 a.wav
> Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
> Endian, Rate 48000 Hz, Mono
>
> Awaiting for your replies,

I'm not sure, if you understand the purpose of the loopback card. It
just passes the data from one playback device to another capture device
so it returns them to the userspace. So you need to have an input
(source) to be loopbacked. You're probably trying to loopback the zero
(silence) samples which are provided when the source is not available
from the loopback card.

You cannot do (simple notation):

arecord Loopback,1 | aplay Loopback,0

it's endless silence loop, but you can do (both commands should be
executed at same time):

aplay Loopback,0 <some_wav_file_with_real_content>
arecord Loopback,1 <loopbacked_result_stored_to_wav>

                                        Jaroslav

>
> Thanks in advance again.
> Srinivasan S
>
>
> ________________________________________
> From: Jaroslav Kysela <perex@perex.cz>
> Sent: Friday, March 6, 2015 12:21 AM
> To: Srinivasan S
> Cc: alsa-devel@alsa-project.org
> Subject: Re: snd-aloop not working in linux-3.12.10
>
> Dne 5.3.2015 v 17:42 Srinivasan S napsal(a):
>> Thanks for your replies,
>>
>> I even tried in the below linux host machine first ie., ubuntu 12.04 prior trying in embedded board
>> Linux srinivasan-Latitude-3440 3.13.0-43-generic #72~precise1-Ubuntu SMP Tue Dec 9 12:14:18 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>>
>> am getting the below
>>
>>> card 1, device 0
>>> card 1, device 1
>>
>> aplay -D hw:1,0,0 TangoForTajMusic11.wav
>>
>> arecord -D hw:1,1,0 record .wav
>>
>> Still this is not working in the linux host machine
>>
>> Could you please help me out in resolving this issue in host machine
>
> On my host, kernel 3.17.8-200.fc20.x86_64, loopback card is #3:
>
> $ aplay -D plughw:3,0,0 /usr/share/sounds/alsa/Noise.wav
> Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
> Endian, Rate 48000 Hz, Mono
> $ arecord -D plughw:3,1,0 -f dat -c 1 a.wav
> Recording WAVE 'a.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>
> As you see, the "capture" program must set the same parameters as the
> sample provider.
>
> This also works:
>
> $ alsaloop -C hw:3,1 -P plughw:1 -t 50000
>
> The "plughw:1" is the real sound hardware in this case (first device,
> second soundcard #1). The aplay command is same as in the first example
> with device "plughw:3,0,0". In this case, the alsaloop detects the PCM
> stream paramter changes automatically using the control API:
>
> $ amixer -c 3 controls
> numid=2,iface=PCM,name='PCM Notify'
> numid=1,iface=PCM,name='PCM Rate Shift 100000'
> numid=3,iface=PCM,name='PCM Slave Active'
> numid=6,iface=PCM,name='PCM Slave Channels'
> numid=4,iface=PCM,name='PCM Slave Format'
> numid=5,iface=PCM,name='PCM Slave Rate'
> numid=8,iface=PCM,name='PCM Notify',subdevice=1
> numid=7,iface=PCM,name='PCM Rate Shift 100000',subdevice=1
> numid=9,iface=PCM,name='PCM Slave Active',subdevice=1
>
>
>                                         Jaroslav
>
>
>>
>> Thanks in advance
>>
>>
>>
>> ________________________________________
>> From: Jaroslav Kysela <perex@perex.cz>
>> Sent: Thursday, March 5, 2015 7:43 PM
>> To: Srinivasan S
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: snd-aloop not working in linux-3.12.10
>>
>> Dne 5.3.2015 v 14:45 Srinivasan S napsal(a):
>>> Dear Jaroslav
>>>
>>> As this feature ie., snd-aloop designed by you,  could you please redirect to the respective links where my queries can be posted & get the solutions for the problem
>>
>> No idea. It looks like you are asking for a commercial support.
>> It may be a cache coherency issue or something else. The embedded/ARM
>> platforms might behave completely differently than x86 on which
>> this code was developed and tested.
>>
>>                                 Jaroslav
>>
>>>
>>> As we are trying to establish GSM two way calls via stereo codec
>>>
>>> We are planning to use loopback module (ie.,snd-aloop and alsaloop in ti sdk 7) to connect the sink/source and source/sink GSM and Codec.
>>>
>>> The below is the virtual devices created after configuring snd-aloop in the linux kernel 3.12.10
>>>
>>> card 0, device 0
>>> card 0, device 1
>>>
>>> whatever am playing we are unable to record in the virtual device, but we are able to play & record with actual device
>>>
>>> aplay -D hw:0,0,0 play.wav
>>> arecord -D hw:0,1,0 record.wav or alsaloop -C hw:0,1 -P hw:0,0 -t 50000 # second terminal, latency 50ms
>>>
>>> As per the logs below, am using the above commands to perform loopback, could you please let me know why am unable to perform the loopback with the below commands or please let me know am I missing any configurations,
>>>
>>> As this is feature is not working in ti sdk 7 (ie.,snd-aloop and alsaloop),
>>>
>>> Kindly requesting to try in your am335x-evm where it has tlv codec & verify this feature ie., snd-aloop & let me know as early as possible
>>>
>>>
>>> logs :
>>> ======
>>> root@am335x-evm:/# ls /dev/snd/
>>> by-path    controlC1  pcmC0D0p   pcmC0D1p   pcmC1D0p
>>> controlC0  pcmC0D0c   pcmC0D1c   pcmC1D0c   timer
>>> root@am335x-evm:/# cat /proc/asound/devices
>>>   0: [ 0]   : control
>>>  16: [ 0- 0]: digital audio playback
>>>  17: [ 0- 1]: digital audio playback
>>>  24: [ 0- 0]: digital audio capture
>>>  25: [ 0- 1]: digital audio capture
>>>  32: [ 1]   : control
>>>  33:        : timer
>>>  48: [ 1- 0]: digital audio playback
>>>  56: [ 1- 0]: digital audio capture
>>> root@am335x-evm:/#
>>>
>>> Loopback device
>>> ----------------
>>> root@am335x-evm:/# aplay -l
>>> **** List of PLAYBACK Hardware Devices ****
>>> card 0: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
>>>   Subdevices: 8/8
>>>   Subdevice #0: subdevice #0
>>>   Subdevice #1: subdevice #1
>>>   Subdevice #2: subdevice #2
>>>   Subdevice #3: subdevice #3
>>>   Subdevice #4: subdevice #4
>>>   Subdevice #5: subdevice #5
>>>   Subdevice #6: subdevice #6
>>>   Subdevice #7: subdevice #7
>>> card 0: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
>>>   Subdevices: 8/8
>>>   Subdevice #0: subdevice #0
>>>   Subdevice #1: subdevice #1
>>>   Subdevice #2: subdevice #2
>>>   Subdevice #3: subdevice #3
>>>   Subdevice #4: subdevice #4
>>>   Subdevice #5: subdevice #5
>>>   Subdevice #6: subdevice #6
>>>   Subdevice #7: subdevice #7
>>> card 1: UDA1345TS [TI UDA1345TS], device 0: UDA134x uda134x-hifi-0 []
>>>   Subdevices: 1/1
>>>   Subdevice #0: subdevice #0
>>> root@am335x-evm:/# aplay -D hw:0,0,0 TangoForTajMusic11.wav
>>> Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>>>
>>>
>>>
>>> Actual device
>>> -------------
>>> root@am335x-evm:/# aplay -D hw:1,0,0 TangoForTajMusic11.wav
>>> Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Li[ 2219.654309] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK=12288000
>>> ttle Endian, Rate 48000 Hz, Stereo
>>> [ 2219.663776] DAVINCIIIIIIIIII UDA134XXXXX BCLK FREQQ=1536000
>>> [ 2219.672880] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK/BCLK_FREQ =8
>>> [ 2219.678982] uda134x_hw_params CLOCKS uda134x_hw_params uda134x->sysclk: 12288000, params_rate(params):48000
>>> [ 2219.689474] uda134x_hw_params FORMATS uda134x_hw_params dai_fmt: 16385, params_format:2
>>> [ 2219.698095] uda134x_hw_params FORMATS uda134x_hw_params uda134x->sysclk / params_rate(params) 256
>>> [ 2219.707644] UDA1345TSSSSSSSSSSSS SYSCLK / fs ratio is 256
>>> [ 2219.713470] uda134x_hw_params dai_fmt: 16385, params_format:2
>>> [ 2219.719639] UDA1345TSSSSSSSSSSSS FORMAT SND_SOC_DAIFMT_I2S
>>> [ 2219.725716] ENTERED davinci_config_channel_size davinci_config_channel_size: tx_rotate = 4
>>> [ 2219.734620] ENTERED davinci_config_channel_size davinci_config_channel_size: MASK= 65535
>>> [ 2219.748324] uda134x_unnnnnnnnmuteeeeeeeeee uda134x_mute mute: 0
>>> [ 2219.756522] davinci_mcasp_starttttttttttttttttttttt SNDRV_PCM_STREAM_PLAYBACK
>>>
>>>
>>> Kindly do the needful as early as possible
>>> Awaiting for your replies,
>>>
>>> Many Thanks in advance,
>>
>>
>> --
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Kernel Sound Maintainer
>> ALSA Project; Red Hat, Inc.
>>
>
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project; Red Hat, Inc.
>


--
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
