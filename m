From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to
 use another nid for pin sense
Date: Fri, 25 Sep 2015 12:06:20 +0800
Message-ID: <CAN8cciZ1xbRQg3aYKjDSq5K1eL44fFKZJdq52WP2Uht_A8JFDA@mail.gmail.com>
References: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
 <s5hvbb16yup.wl-tiwai@suse.de>
 <CAN8cciZ0HKP+RNRRsbNXpo0azmqBKBjejXJRwx8PRuHiw3pZ9w@mail.gmail.com>
 <s5h4mik6xwi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id D2451260656
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 06:06:21 +0200 (CEST)
Received: by obbzf10 with SMTP id zf10so73815970obb.2
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 21:06:20 -0700 (PDT)
In-Reply-To: <s5h4mik6xwi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, jason.braddock.69@gmail.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, arthurborsboom@gmail.com
List-Id: alsa-devel@alsa-project.org

> >
> > > >
> > > > - add sense_nid to __snd_hda_jack_add_kctl for pin sense
> > > >
> > > > - update slave pin sense when master pin sense change
> > > >
> > > > - enable unsolicited event when widcap support UNSOL
> > >
> > > Again, please describe at first the reason you need this change.  Then
> > > start explaining about the implementation details.  For example,
> > > what's the difference from the existing gated_jack.
> > >
> > >
> >
> > I don't understand how gated jack work, but those headset mic in alc668
> > dell-headset-multi does not  use its own pin sense and won't need to
enable
> > unsol event of the headset mic node.
> >
> > As pulseaudio don't expect jack kctl can be repesent the state of
headphone
> > and mic
> >
> > This force the driver to create a headset mic kctl which is just a copy
of
> > the headphone jack kctl
>
> See what you wrote now in the above?  It's a nice introduction of the
> things you're trying to solve.  This kind of information is exactly
> what I asked for.  Please rephrase and put it in the changelog at the
> next time.
>
> About gated_jack: this was introduced for Chromebook for a headset.
> This should work similarly like your case.  The behavior of gated /
> gating jacks are:
>
> - When a jack A has gating_jack = B: the presence of jack A depends on
>   gating_jack B.  Namely, if gating_jack B is unplugged, jack A is
>   treated as unplugged.
>
> - When a jack B has gated_jack = A: jack B doesn't give an unsol event
>   by itself, but it's triggered together with gated_jack A when jack A
>   is plugged/unplugged.  The plug status of jack B can be read from B
>   itself.
>
> For Chromebook, A (gated) is mic pin and B (gating) is HP pin.
> That is, a headset mic is detected only when the HP pin is detected.
>
>

The other possible usage of __snd_hda_jack_add_kctl() with different
sense_nid may be those asus N series notebook with ALC663 codec which seem
to use the hidden pin sense of node 0x1e of Digital Out pin for the
external Sonic Master Subwoofer

it just add subwoofer jack kctl at subwoofer node but use the hidden jack
sense of node 0x1e,  while driver still create SPDIF phantom jack

What is missing is the timer queue to check the jack state similar to vt1708

https://bugs.freedesktop.org/show_bug.cgi?id=91568#c11

WITHOUT subwoofer:
sudo ./hdajacksensetest -a
Pin 0x11 (Not connected): present = No
Pin 0x12 (Not connected): present = No
Pin 0x13 (Not connected): present = No
Pin 0x14 (Internal Speaker, ATAPI): present = No
Pin 0x15 (Not connected): present = No
Pin 0x16 (Internal Speaker, ATAPI): present = No
Pin 0x17 (Not connected): present = No
Pin 0x18 (Pink Mic, Rear side): present = No
Pin 0x19 (Internal Mic, ATAPI): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out, Right side): present = No
Pin 0x21 (Green Headphone, Rear side): present = No

WITH subwoofer:
sudo ./hdajacksensetest -a
Pin 0x11 (Not connected): present = No
Pin 0x12 (Not connected): present = No
Pin 0x13 (Not connected): present = No
Pin 0x14 (Internal Speaker, ATAPI): present = No
Pin 0x15 (Not connected): present = No
Pin 0x16 (Internal Speaker, ATAPI): present = No
Pin 0x17 (Not connected): present = No
Pin 0x18 (Pink Mic, Rear side): present = No
Pin 0x19 (Internal Mic, ATAPI): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out, Right side): present = Yes
Pin 0x21 (Green Headphone, Rear side): present = No
