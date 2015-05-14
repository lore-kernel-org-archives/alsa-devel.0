From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fwd: Front speakers doesn't work in multichannel
 output, regression in ALC888
Date: Thu, 14 May 2015 14:26:11 +0800
Message-ID: <CAN8ccibM+PoboaTXoHqg=dCbe-3+ijQZ6xL_Q1J=H9ovZ8gzkQ@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <4324603.tPLEjaP5mH@luklap.workgroup>
 <CAN8cciYbGexGm8GS3nJgBkfTphy6H-eV-dkwno6TYV0FiMfOhQ@mail.gmail.com>
 <4678913.FpDgrA5u1d@luklap.workgroup>
 <CAN8cciZdSoQpLQe2Cum1gozsJ48J-B9gbECFYDsHgx6=R4pLYg@mail.gmail.com>
 <CAN8cciZS8MhXWy5anxMSgtLdDYHQtURXJ2iEoL0YMpb41EifHg@mail.gmail.com>
 <d3bbb31411796d9f835396d30dcaa309@mail.onse.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 057FE26053E
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 08:26:17 +0200 (CEST)
Received: by oiko83 with SMTP id o83so48939376oik.1
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 23:26:11 -0700 (PDT)
In-Reply-To: <d3bbb31411796d9f835396d30dcaa309@mail.onse.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>, lukasz.wojnilowicz@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/patch/sound/pci
> > /hda/patch_realtek.c?id=c3e837bbcc03e39991da5dd1f791c06cde9f7a45
> >
> > When the static model were used, the jack was configured as line out
> > instead of headphone jack and there is no headphone playback volume
>
> That's rather "relevant change". Good job in finding it. I would like such
> configuration (or better) back.
>
I don't see any side effect neither with your changes to hda_generic nor
> with
> vanilla kernel, but I don't know what problems should I expect.
>

Do headphone get same volume level when the jack is configured as Line Out
(without enable Headphone Amplifier) ?

The driver use different automute method when the jack is configured as HP
and Line Out

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=e0d32e335fc0e354db93a807736243f5035fbc67

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=a365fed9806e182cb4e1b7bb1855759489d95858
http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths

if you look at speaker.conf , lineout.conf and headphone.conf, it seem
pulseaudio is unlikely mute all internal speakers when one pair of the
playback volume control need to be shared by internal speaker and external
speakers

you need dirver 's automute instead of pulseaudio 's automute


==> Best config: lo_type=2, wired=1, mio=1
multi_outs = 15/0/0/0 : 2/3/4/0 (type HP)
  out path: depth=3 '02:0c:15'
multi_ios(2) = 1a/18 : 3/4
  mio path: depth=3 '03:0d:1a'
  mio path: depth=3 '04:0e:18'
spk_outs = 14/17/16/0 : 5/25/4/0
  spk path: depth=3 '05:0f:14'
  spk path: depth=3 '25:26:17'
  spk path: depth=3 '04:0e:16'

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_generic.c?id=e80c60f3cbe76fa95029abc53b1a29172b51b96a

when line out type == AUTO_PIN_HP_OUT

should first do_mute() use speaker_path instead of out_path
<https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_generic.c?id=7385df6134888553b5ede71cd573ffe0429e2a80>

>>> I started MS Windows and without externals speakers plugged in I
>>
>> could test
>>  > 5.1 configuration and it seemed that sound was coming from
>> different directions.
>>
>>  >
>>  > What I managed to determine:
>>  > I've got 3 stacks:
>>  > 1 ST: Headphone, Line-out (FL and FR), SPDIF
>>  > 2 ST: Microphone, Line-out (CLFE)
>>  > 3 ST: Line-in, Line-out (RL and RR)
>>  >
>>  > I've got 5 responsive output pins
>>  > PIN 0x14: Internal FL FR
>>  > PIN 0x15: External FL FR
>>  > PIN 0x17: Internal LFE
>>  > PIN 0x18: External CLFE
>>  > PIN 0x1a: External RL RR
>>  >
>>  > How can we make it work with these information?

speaker-test -Dhw:0,0 -c6 -t wav

>>
>>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/Channel-Mapping-API.txt
>> [1]
>>
>> seem chnmap type _FIXED , _VAR and _PAIRED does not fit when LFE and
>> FC can be swapped for internal speaker and external speaker
>
>
> Right, you can't do it with a single map of one of those types.
http://git.alsa-project.org/?p=alsa-utils.git&a=search&h=HEAD&st=commit&s=chmap

do chmap of internal speakers need {FL FR RL RR LFE NA} ?

http://git.alsa-project.org/?p=alsa-lib.git&a=search&h=HEAD&st=commit&s=chmap

as set_chmap() still not yet implemented in pcm_route.c

do speaker-test need to specify channel map when using those odd number
channels ?

speaker-test -D surround21  -c3 -t wav
speaker-test -D surround41  -c5 -t wav -mFL,FR,RL,RR,LFE
speaker-test -D surround50  -c5 -t wav

http://git.alsa-project.org/?p=alsa-utils.git;a=commitdiff;h=7b14c00b56784f69ecc954a2de36e0a058fc8849;hp=000bf230cfb3b0abe88d27701dd77982675126ec

this example seem not working

speaker-test -c2 -t wav -Dplug:front -mFR,FL

>
>
>>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=0fb87bb474f978446786263deff6263284e6e011
>> [2]
>>
>> How do the driver implement channel map when codec has  swap
>> center/lfe switch ?
>>
>> Do chmap contain both {FL FR RL RR FC LFE} and {FL FR RL RR LFE FC} ?
>
>
> If you want to provide support for userspace doing it both ways, then
yes, you need those two _FIXED maps.

Can chmap contain two _FIXED maps of same number of channels ?
