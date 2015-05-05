From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Front speakers doesn't work in multichannel output,
 regression in ALC888
Date: Wed, 6 May 2015 00:47:22 +0800
Message-ID: <CAN8cciYbGexGm8GS3nJgBkfTphy6H-eV-dkwno6TYV0FiMfOhQ@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <29807127.PULdKhJLmi@luklap.workgroup>
 <CAN8cciapcbygVjS20+Ln6aDJbd3poieo6-8Zq3x69brsqr+Raw@mail.gmail.com>
 <4324603.tPLEjaP5mH@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 505092658F1
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 18:47:23 +0200 (CEST)
Received: by oign205 with SMTP id n205so152415782oig.2
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 09:47:22 -0700 (PDT)
In-Reply-To: <4324603.tPLEjaP5mH@luklap.workgroup>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>
> > seem internal subwoofer only use one channel and don't have any stereo
to
> > mono downmix according to your patch
> >
> > It is not easy to assign different name to internal 4.1 and external 5.1
> > speaker when alc888 only has five DAC
> >
> > Some playback volume control  must be shared
>
> If you know what's missing, you could send a few lines of code and I will
test
> it, otherwise I'll have to experiment on my own.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/patch/sound/pci/hda/patch_realtek.c?id=
c3e837bbcc03e39991da5dd1f791c0 6cde9f7a45

As your patch indicate internal subwoofer use external center speaker
channel and your codec does not support L/R swap

You may need to reserve Audio mixer 0x26 for internal subwoofer playback
volume by restrict the connection of the internal rear speaker

excluding 0x26 so that last DAC can be assigned to the internal subwoofer
similar to alc889_fixup_dac_route

void alc888_fixup_dac_route(struct hda_codec *codec,
   const struct alc_fixup *fix, int action)
{
if (action == ALC_FIXUP_ACT_PRE_PROBE) {

hda_nid_t conn1[4] = { 0x0c, 0x0d, 0x0e, 0x0f};

snd_hda_override_conn_list(codec, 0x17, 4, conn1);

} else if (action == ALC_FIXUP_ACT_PROBE) {
conn[5] = { 0x0c, 0x0d, 0x0e, 0x0f, 0x26 };
snd_hda_override_conn_list(codec, 0x17, 5, conn);

}
}

>
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/patch/sound/pci/hda/patch_realtek.c?id=
c3e837bbcc03e39991da5dd1f791c0 6cde9f7a45

> >
> > Do you mean internal subwoofer has low pass filter
>
> I don't know. How to check it?
>
>
> > what do you mean when you say 4.1 worked fine ?
>
> External 5.1 speakers working as 4.1 speakers because such profile was
set.
>
>
> > The channel map of internal 4.1 speaker are different from external 5.1
> > speaker
>
> Recently I also made such conclusion.
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=2d3391ec0ecca37efb6bc995906292f47522b471

Seem  4.1 is not defined in snd_pcm_std_chmap and you need to define and
add your 4.1  chmap similar to 2.1

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ee81abb623cb5e03c182d16871bb4fb34fdc9b4f
