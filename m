From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: snd-aloop not working in linux-3.12.10
Date: Thu, 5 Mar 2015 16:42:16 +0000
Message-ID: <1425573780241.58049@tataelxsi.co.in>
References: <1425483360-1806-1-git-send-email-qais.yousef@imgtec.com>
 <20150304161013.GU2613@intel.com>	<54F73421.3000108@imgtec.com>
 <20150305070018.GW2613@intel.com>	<54F80916.50703@perex.cz>
 <20150305083054.GY2613@intel.com> <s5h7fuv25dc.wl-tiwai@suse.de>
 <54F84E0D.1070907@imgtec.com>,<54F85C82.9010608@perex.cz>
 <1425563166355.75990@tataelxsi.co.in>,<54F86478.7050107@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0145.outbound.protection.outlook.com [134.170.132.145])
 by alsa0.perex.cz (Postfix) with ESMTP id B611B265974
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 17:42:20 +0100 (CET)
In-Reply-To: <54F86478.7050107@perex.cz>
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

Thanks for your replies,

I even tried in the below linux host machine first ie., ubuntu 12.04 prior trying in embedded board
Linux srinivasan-Latitude-3440 3.13.0-43-generic #72~precise1-Ubuntu SMP Tue Dec 9 12:14:18 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

am getting the below

> card 1, device 0
> card 1, device 1

aplay -D hw:1,0,0 TangoForTajMusic11.wav

arecord -D hw:1,1,0 record .wav

Still this is not working in the linux host machine

Could you please help me out in resolving this issue in host machine

Thanks in advance



________________________________________
From: Jaroslav Kysela <perex@perex.cz>
Sent: Thursday, March 5, 2015 7:43 PM
To: Srinivasan S
Cc: alsa-devel@alsa-project.org
Subject: Re: snd-aloop not working in linux-3.12.10

Dne 5.3.2015 v 14:45 Srinivasan S napsal(a):
> Dear Jaroslav
>
> As this feature ie., snd-aloop designed by you,  could you please redirect to the respective links where my queries can be posted & get the solutions for the problem

No idea. It looks like you are asking for a commercial support.
It may be a cache coherency issue or something else. The embedded/ARM
platforms might behave completely differently than x86 on which
this code was developed and tested.

                                Jaroslav

>
> As we are trying to establish GSM two way calls via stereo codec
>
> We are planning to use loopback module (ie.,snd-aloop and alsaloop in ti sdk 7) to connect the sink/source and source/sink GSM and Codec.
>
> The below is the virtual devices created after configuring snd-aloop in the linux kernel 3.12.10
>
> card 0, device 0
> card 0, device 1
>
> whatever am playing we are unable to record in the virtual device, but we are able to play & record with actual device
>
> aplay -D hw:0,0,0 play.wav
> arecord -D hw:0,1,0 record.wav or alsaloop -C hw:0,1 -P hw:0,0 -t 50000 # second terminal, latency 50ms
>
> As per the logs below, am using the above commands to perform loopback, could you please let me know why am unable to perform the loopback with the below commands or please let me know am I missing any configurations,
>
> As this is feature is not working in ti sdk 7 (ie.,snd-aloop and alsaloop),
>
> Kindly requesting to try in your am335x-evm where it has tlv codec & verify this feature ie., snd-aloop & let me know as early as possible
>
>
> logs :
> ======
> root@am335x-evm:/# ls /dev/snd/
> by-path    controlC1  pcmC0D0p   pcmC0D1p   pcmC1D0p
> controlC0  pcmC0D0c   pcmC0D1c   pcmC1D0c   timer
> root@am335x-evm:/# cat /proc/asound/devices
>   0: [ 0]   : control
>  16: [ 0- 0]: digital audio playback
>  17: [ 0- 1]: digital audio playback
>  24: [ 0- 0]: digital audio capture
>  25: [ 0- 1]: digital audio capture
>  32: [ 1]   : control
>  33:        : timer
>  48: [ 1- 0]: digital audio playback
>  56: [ 1- 0]: digital audio capture
> root@am335x-evm:/#
>
> Loopback device
> ----------------
> root@am335x-evm:/# aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
>   Subdevices: 8/8
>   Subdevice #0: subdevice #0
>   Subdevice #1: subdevice #1
>   Subdevice #2: subdevice #2
>   Subdevice #3: subdevice #3
>   Subdevice #4: subdevice #4
>   Subdevice #5: subdevice #5
>   Subdevice #6: subdevice #6
>   Subdevice #7: subdevice #7
> card 0: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
>   Subdevices: 8/8
>   Subdevice #0: subdevice #0
>   Subdevice #1: subdevice #1
>   Subdevice #2: subdevice #2
>   Subdevice #3: subdevice #3
>   Subdevice #4: subdevice #4
>   Subdevice #5: subdevice #5
>   Subdevice #6: subdevice #6
>   Subdevice #7: subdevice #7
> card 1: UDA1345TS [TI UDA1345TS], device 0: UDA134x uda134x-hifi-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> root@am335x-evm:/# aplay -D hw:0,0,0 TangoForTajMusic11.wav
> Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>
>
>
> Actual device
> -------------
> root@am335x-evm:/# aplay -D hw:1,0,0 TangoForTajMusic11.wav
> Playing WAVE 'TangoForTajMusic11.wav' : Signed 16 bit Li[ 2219.654309] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK=12288000
> ttle Endian, Rate 48000 Hz, Stereo
> [ 2219.663776] DAVINCIIIIIIIIII UDA134XXXXX BCLK FREQQ=1536000
> [ 2219.672880] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK/BCLK_FREQ =8
> [ 2219.678982] uda134x_hw_params CLOCKS uda134x_hw_params uda134x->sysclk: 12288000, params_rate(params):48000
> [ 2219.689474] uda134x_hw_params FORMATS uda134x_hw_params dai_fmt: 16385, params_format:2
> [ 2219.698095] uda134x_hw_params FORMATS uda134x_hw_params uda134x->sysclk / params_rate(params) 256
> [ 2219.707644] UDA1345TSSSSSSSSSSSS SYSCLK / fs ratio is 256
> [ 2219.713470] uda134x_hw_params dai_fmt: 16385, params_format:2
> [ 2219.719639] UDA1345TSSSSSSSSSSSS FORMAT SND_SOC_DAIFMT_I2S
> [ 2219.725716] ENTERED davinci_config_channel_size davinci_config_channel_size: tx_rotate = 4
> [ 2219.734620] ENTERED davinci_config_channel_size davinci_config_channel_size: MASK= 65535
> [ 2219.748324] uda134x_unnnnnnnnmuteeeeeeeeee uda134x_mute mute: 0
> [ 2219.756522] davinci_mcasp_starttttttttttttttttttttt SNDRV_PCM_STREAM_PLAYBACK
>
>
> Kindly do the needful as early as possible
> Awaiting for your replies,
>
> Many Thanks in advance,


--
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
