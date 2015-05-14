From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Fwd: Front speakers doesn't work in multichannel
 output, regression in ALC888
Date: Thu, 14 May 2015 10:45:30 +0300
Message-ID: <5554529A.4040202@iki.fi>
References: <2927807.UsnFnTlWVL@luklap.workgroup>	<4324603.tPLEjaP5mH@luklap.workgroup>	<CAN8cciYbGexGm8GS3nJgBkfTphy6H-eV-dkwno6TYV0FiMfOhQ@mail.gmail.com>	<4678913.FpDgrA5u1d@luklap.workgroup>	<CAN8cciZdSoQpLQe2Cum1gozsJ48J-B9gbECFYDsHgx6=R4pLYg@mail.gmail.com>	<CAN8cciZS8MhXWy5anxMSgtLdDYHQtURXJ2iEoL0YMpb41EifHg@mail.gmail.com>	<d3bbb31411796d9f835396d30dcaa309@mail.onse.fi>
 <CAN8ccibM+PoboaTXoHqg=dCbe-3+ijQZ6xL_Q1J=H9ovZ8gzkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id E61B626053E
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 09:45:39 +0200 (CEST)
In-Reply-To: <CAN8ccibM+PoboaTXoHqg=dCbe-3+ijQZ6xL_Q1J=H9ovZ8gzkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: lukasz.wojnilowicz@gmail.com, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

14.05.2015, 09:26, Raymond Yau kirjoitti:
>>>> I started MS Windows and without externals speakers plugged in I
>>>
>>> could test
>>>  > 5.1 configuration and it seemed that sound was coming from
>>> different directions.
>>>
>>>  >
>>>  > What I managed to determine:
>>>  > I've got 3 stacks:
>>>  > 1 ST: Headphone, Line-out (FL and FR), SPDIF
>>>  > 2 ST: Microphone, Line-out (CLFE)
>>>  > 3 ST: Line-in, Line-out (RL and RR)
>>>  >
>>>  > I've got 5 responsive output pins
>>>  > PIN 0x14: Internal FL FR
>>>  > PIN 0x15: External FL FR
>>>  > PIN 0x17: Internal LFE
>>>  > PIN 0x18: External CLFE
>>>  > PIN 0x1a: External RL RR
>>>  >
>>>  > How can we make it work with these information?
> 
> speaker-test -Dhw:0,0 -c6 -t wav
>  
>>>
>>>
>>>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/Channel-Mapping-API.txt
>>> [1]
>>>
>>> seem chnmap type _FIXED , _VAR and _PAIRED does not fit when LFE and
>>> FC can be swapped for internal speaker and external speaker
>>
>>
>> Right, you can't do it with a single map of one of those types.
> 
> http://git.alsa-project.org/?p=alsa-utils.git&a=search&h=HEAD&st=commit&s=chmap
> 
> do chmap of internal speakers need {FL FR RL RR LFE NA} ?

>From above it looks like there are 3 internal speakers, so I guess e.g.
{FL FR LFE NA} might be in order (or just {FL FR LFE} if 3-channel
playback is supported).

> http://git.alsa-project.org/?p=alsa-lib.git&a=search&h=HEAD&st=commit&s=chmap
> 
> as set_chmap() still not yet implemented in pcm_route.c
> 
> do speaker-test need to specify channel map when using those odd number
> channels ?
> 
> speaker-test -D surround21  -c3 -t wav
> speaker-test -D surround41  -c5 -t wav -mFL,FR,RL,RR,LFE
> speaker-test -D surround50  -c5 -t wav

Well, the driver should provide the correct chmap.

> http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=7b14c00b56784f69ecc954a2de36e0a058fc8849;hp=000bf230cfb3b0abe88d27701dd77982675126ec
> 
> this example seem not working
> 
> speaker-test -c2 -t wav -Dplug:front -mFR,FL

You are getting an error?
If so, that is expected if the underlying device does not support the
wanted channel map.

>>
>>
>>>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=0fb87bb474f978446786263deff6263284e6e011
>>> [2]
>>>
>>> How do the driver implement channel map when codec has  swap
>>> center/lfe switch ?
>>>
>>> Do chmap contain both {FL FR RL RR FC LFE} and {FL FR RL RR LFE FC} ?
>>
>>
>> If you want to provide support for userspace doing it both ways, then
> yes, you need those two _FIXED maps.
> 
> Can chmap contain two _FIXED maps of same number of channels ?

Sure.

-- 
Anssi Hannula
