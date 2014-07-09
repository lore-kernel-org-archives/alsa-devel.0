From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Split a 7.1 device into 4 stereo devices
Date: Wed, 9 Jul 2014 23:32:02 +0800
Message-ID: <CAN8cciboV4jHyFukCH4SPbohyLexg68TgYjddZHEi=5eV-CKyw@mail.gmail.com>
References: <1404832691.13359.9.camel@X230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id D2AA5261A5F
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 17:32:03 +0200 (CEST)
Received: by mail-qg0-f52.google.com with SMTP id f51so6551337qge.39
 for <alsa-devel@alsa-project.org>; Wed, 09 Jul 2014 08:32:02 -0700 (PDT)
In-Reply-To: <1404832691.13359.9.camel@X230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Claessens <xavier.claessens@collabora.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> I have a 7.1 sound device and speaker-test -c8 can output on each
> speaker. But what I would like to do is using it as 4 stereo devices so
> I could play different sounds on each of them.
>
> Ideally I would like to avoid dmix and friends to be able to have
> gapless and bit-perfect output.
>
> On IRC "debianuser" said it is possible with hdajackretask to make it
> appear as 4 different hw devices in "aplay -l" but we didn't succeed
> doing that. Anyone knows what configuration is needed for that?
>
> Here is my setting:
> http://www.alsa-project.org/db/?f=bf0744873d5e6d42d3adc0076c5f66189e9191b7
>
The easy way is to use jackd and alsa jack plugin

If you really need  need four stereo devices, you need to customized
snd_hda multiout_analog_open, snd_hda multiout_analog_prepare and snd_hda
multiout_analog_cleanup similar to those  alt_analog_capture_xxx function
to use substream->number to provide four stereo devices

static const struct hda_pcm_stream pcm_analog_playback = {
.substreams = 4,
.channels_min = 2,
.channels_max = 2,
/* NID is set in build_pcms */
.ops = {
.open = playback_pcm_open,
.close = playback_pcm_close,
.prepare = playback_pcm_prepare,
.cleanup = playback_pcm_cleanup
},
};

Since only those four retaskable jacks support HP, you may need to use
input jacks if you want four headphones instead of four line out jackd
