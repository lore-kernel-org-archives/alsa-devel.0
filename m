From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Mon, 7 Jan 2013 10:43:00 +0800
Message-ID: <CAN8cciaWrAcf5RCy=mZpM8a4xokKLL_MewKPAXSE0Koy=dECeA@mail.gmail.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
 <20130105071605.GA11323@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id CBD0626506E
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 03:43:01 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id c11so22255454ieb.5
 for <alsa-devel@alsa-project.org>; Sun, 06 Jan 2013 18:43:00 -0800 (PST)
In-Reply-To: <20130105071605.GA11323@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

> - there is no alsamixer control for the internal speaker. I have a "PCM"
volume control which appears to do nothing. Previously there was a speaker
control, the PCM control affected every output (from memory), as did the
master volume.

Take a look at function alc_get_line_out_pfx

Most likely lack of speaker pin complex

> no audio comes out of the internal speaker regardless of the "auto mute"
setting.

>- there are no pin mode (re-tasking) controls for the mic or headphone
jack in alsamixer. On this laptop the mic jack should have various bias
options as well as line-in. The headphone jack should include headphone
(aka output amplifier on), line-out (output amplifier off), line-in and mic
options.

All retaskable jacks support impedance measurement

Try hda-verb SET_PIN_SENSE and GET_PIN_SENSE to find out the impedance and
PD bit of different jacks

> > > > Does this mean that the internal speaker and line out at Sep right
(dock
> > > > line out) at same node 0x10 ?
> > >
> > > Here is what I know:
> > >
> > >   Node 0x10 = Internal speaker
> >
> > -static const struct hda_verb alc260_fujitsu_init_verbs[] = {
> > -       /* Disable all GPIOs */
> > -       {0x01, AC_VERB_SET_GPIO_MASK, 0},
> > -       /* Internal speaker is connected to headphone pin */
> > -       {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
> >
> > The auto model won't set pin ctls to HP when pin default is line out or
> > speaker
> >
> >
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868/comments/9
>
> Do you require feedback from me about this?  As far as I can tell it's
just
> an observation which might partly explain why the speaker doesn't work on
> the S7020.

E8020 has same PCI SSID and codec SSID as your S7020

It has a spdif/headphone jack

>
> In case it helps clarify things, perhaps I should explain some of the
> comments which were previously contained within alc260_quirks.c (since I
> wrote them).

Do the driver need to disable GPIO since your previous  Fujitsu model have
this init verb ?
