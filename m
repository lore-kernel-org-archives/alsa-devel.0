From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX533FD with ALC294
Date: Fri, 7 Dec 2018 17:13:14 +0800
Message-ID: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com> <20181206084554.4728-3-jian-hong@endlessm.com>
 <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
 <CAPpJ_ed36NyopArw98qhkstAm=L9A4=xiLPaa2ju0+qMR0tE9Q@mail.gmail.com> <6FAB7C47BCF00940BB0999A99BE3547A1842025B@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A1842025B@RTITMBSV02.realtek.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Kailang Yang <kailang@realtek.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Daniel Drake <drake@endlessm.com>, josh@wtmec.com
List-Id: alsa-devel@alsa-project.org

> Hi Jian Hong,
>
> I call our agent guy @ WTMEC.
> Please modify as bellowing then test again.
> Remove EAPD control by hidden.
> If this modify patch was pass audio test, please regenerate patch to Takashi.
> If this patch will solve the speaker no sound issue, I think the model name maybe could rename to ALC294_FIXUP_ASUS_SPK.
> Because it doesn't relate with Noise.
>
> > +       [ALC294_FIXUP_ASUS_SPK_NOISE] = {
> > +               .type = HDA_FIXUP_VERBS,
> > +               .v.verbs = (const struct hda_verb[]) {
> > +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> > +                       { 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
> > +                       { }
> > +               },
> > +               .chained = true,
> > +               .chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
> > +       },
> >  };
>

Thanks for the help!
I have tried the new verbs, and they work on the laptops.
I am going to send the new patches.

Regards,
Jian-Hong Pan
