From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Fri, 2 Nov 2012 09:44:18 +0800
Message-ID: <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id ECCBB264F13
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 02:44:21 +0100 (CET)
Received: by mail-qa0-f44.google.com with SMTP id 25so706265qao.17
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 18:44:21 -0700 (PDT)
In-Reply-To: <k6tlk1$2vr$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Massimo Del Fedele <max@veneto.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 1045981@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

>
>>
>> can you post the output of alsa-info.sh ?
>
>
> Where can I find the script ? I've not it on my machine
>

http://git.alsa-project.org/?p=alsa-driver.git;a=history;hb=refs/heads/build;f=alsa/utils/alsa-info.sh

>>
>>     9.337454] ALSA hda_codec.c:4877 autoconfig: line_outs=1
>> (0x24/0x0/0x0/0x0/0x0) type:speaker
>> [    9.337458] ALSA hda_codec.c:4881    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
>> [    9.337460] ALSA hda_codec.c:4885    hp_outs=1 (0x25/0x0/0x0/0x0/0x0)
>> [    9.337462] ALSA hda_codec.c:4886    mono: mono_out=0x0
>> [    9.337464] ALSA hda_codec.c:4889    dig-out=0x2d/0x0
>> [    9.337465] ALSA hda_codec.c:4890    inputs:
>> [    9.337467] ALSA hda_codec.c:4894  Internal Mic=0x29
>> [    9.337469] ALSA hda_codec.c:4894  Mic=0x2b
>>
>> it is the auto parser put the speaker to autocfg->lineout

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=90da78bf6aaabd4d31c6663b7c1d1b9c5a8c023f

mono pin complex are usually [Fixed] Speaker instead of [Jack] Line Out

>
>
> Yep, if you look at above, this one was exactly the output before my 2
patches; the only difference
> was line 24, marked as type=SPEAKER; no trace of mono pin 0x33.
> I guess the 0x33 is skipped because the parser don't find a path from it,
as it have a connection to
> widget 0x3e with is out of range (widgets are reported to be from 0x08 to
0x0c).

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1045981

Node 0x33 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x501701f0: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x3e

it is ignored by the auto parser because [N/A] instead of [Fixed]

> We could also patch the returned widget number to be 2 widgets more, even
id 0x3d is NOT there.
>
> The 0x3e is a stereo to mono mixer, connecting to 0x1c.
> As above, VT1802p reports to have widgets up to 0x3c.
>

do widge 0x3e has amp-out for subwoofer volume control ?

>>
>> should the auto parser put it into autocfg->mono_out?
>>
>
> maybe.... I didn't try that one.
> With both patches the stuffs appears like a 4 channel one; the correct
would be 2+1, but
> I didn't manage to get it right.

Node 0x2b [Pin Complex] wcaps 0x400481: Stereo
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Pincap 0x00002324: IN Detect
    Vref caps: HIZ 50 100
  Pin Default 0x01a1903e: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0xe

as the mic jack cannot be retasked as output , No need to put hp in lineout

>
> Resuming, without patches, the auto_parser report for asus :
>
> 0x24 Line out, type speaker
> 0x25 Hp out
> 0x33 is missing
>
> Forcing the connection from 0x33 to 0x1c (skipping so 0x3e) the pin 0x33
don't appear
> because bios marks it at none-connection.
> Forcing the connection to JACK, it puts as a mono speaker, so no sound
from it either.
> Forcing to be a line out, sound only from it because then 0x24 takes the
speaker place (marked as speaker in bios).
> Forcing both 0x24 and 0x33 to be line out gives 4 channel sound (with 2
rear channels output to 0x33 mono).
>
> No idea on how to get the 2+1 behaviour, but at least now it sounds.

multiout.extra_out seem support multi stereo streams in
snd_hda_multi_out_analog_prepare()

for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
                 if (!mout->no_share_stream && mout->extra_out_nid[i])
                         snd_hda_codec_setup_stream(codec,
                                                    mout->extra_out_nid[i],
                                                    stream_tag, 0, format);

how to put those internal speakers into multiout->extra_out in
via_auto_create_speaker_ctls() when the auto parser put the speaker into
autocfg->lineout ?

only two volume controls at 0x08 and 0x09,
there are three pin complexes 0x24, 0x25 and 0x33
