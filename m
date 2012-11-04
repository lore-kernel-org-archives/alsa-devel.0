From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Sun, 4 Nov 2012 14:27:33 +0800
Message-ID: <CAN8cciZWX2tdAUcNeBHpa7eFHYeMnsTN_ngRcj7gRuj46RXnpg@mail.gmail.com>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
 <k70n1l$65a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D0B626513F
 for <alsa-devel@alsa-project.org>; Sun,  4 Nov 2012 07:27:34 +0100 (CET)
Received: by mail-qa0-f44.google.com with SMTP id 25so1860628qao.17
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 23:27:33 -0700 (PDT)
In-Reply-To: <k70n1l$65a$1@ger.gmane.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

>>> https://launchpadlibrarian.net/121871263/alsainfo.txt

>> do widge 0x3e has amp-out for subwoofer volume control ?
>
>
> Nope. The sound path I got finally are :
> 08/34/14/24/00
> 08/21/14/24/00
> 09/3c/1c/33/00
> 08/35/15/25/00
> 08/21/15/25/00
>
> So, front on 0x08, shared with HP, and subwoofer on 0x09. Volumes are on
0x08 and 0x09 controls,
> afaik there are no more volume controls there.

the driver setup 0x33 (mono pin) for vt1802

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=11890956e948e6ed1b3e4acc11b6879db6ace01b;hp=bc92df7fe55e49c616a003b0b77e7badf2736429

and some asus with vt1802 does not have any subwoofer

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=94c142a160d63edac0e1fca7848960dcf75dd2a9;hp=012e7eb1e501d0120e0383b81477f63091f5e365

do notebook with vt1802 really need independent headphone ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.
git;a=commitdiff;h=a2a870c82797e47884b2736e95e9d9
c89a51c219;hp=5c9a5615dedec19196b1217e864616 a2ce9e392a

>
>>>> should the auto parser put it into autocfg->mono_out?
>>>
>>> maybe.... I didn't try that one.
>>> With both patches the stuffs appears like a 4 channel one; the correct
>>
>> would be 2+1, but
>>>
>>> I didn't manage to get it right.
>>
>>

> The function should scan all paths from DACs to
> OUTS, but like it is just takes the first available DAC.
> The problem arises here :
>
>if (dac) {
>spec->private_dac_nids[i] = dac;
>dac_num++;
>}

> Which correctly adds DAC to used list, but doesn't
> update the total number of found DACs
> in spec->multiout.num_dacs; following calls to
> is_empty_dac() will always return true
> for already used DACs, making parse_output_path()
> return always the first one.

it is because

spec->multiout.num_dacs = cfg->line_outs + spec->smart51_nums;

so this may be the reason for the auto parser put internal speaker 0x24
into autocfg->lineout

are you sure that you need pulseaudio to upmix stereo to 4 channels since
the driver use copy front mode for 2 channels playback when
spec->multiout.num_dacs
= 2

/* surrounds */
for (i = 1; i < mout->num_dacs; i++) {
if (chs >= (i + 1) * 2) /* independent out */
snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
   i * 2, format);
else if (!mout->no_share_stream) /* copy front */
snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
   0, format);
}

this mean that the channel map may has no relationship with the number of
internal speakers of the notebook

>
>> multiout.extra_out seem support multi stereo streams in
>> snd_hda_multi_out_analog_prepare()
>>
>> for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
>>                   if (!mout->no_share_stream && mout->extra_out_nid[i])
>>                           snd_hda_codec_setup_stream(codec,
>>
 mout->extra_out_nid[i],
>>                                                      stream_tag, 0,
format);
>>
>> how to put those internal speakers into multiout->extra_out in
>> via_auto_create_speaker_ctls() when the auto parser put the speaker into
>> autocfg->lineout ?
>
>
> Don't know.... if I let 0x33 and/or 0x24 as speaker, they're put as
speaker out but not taken
> in multiout paths.

does this mean that spec->speaker_path and spec->speaker_mix_path  are
useless ?
