From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Sat, 28 Mar 2015 14:09:56 +0800
Message-ID: <CAN8cciZsmcj5k8=L2UcFDZkj8WujW3HoFTwezVOGthbfqXbGjQ@mail.gmail.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8180B261685
 for <alsa-devel@alsa-project.org>; Sat, 28 Mar 2015 07:09:57 +0100 (CET)
Received: by lbbug6 with SMTP id ug6so76953355lbb.3
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 23:09:57 -0700 (PDT)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Tanu Kaskinen (tanu.kaskinen@linux.intel.com)" <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> > >
> > > > > +}
> > > > > +
> > > > > +static int snd_jack_new_kctl(struct snd_card *card, struct
> > > > > +snd_jack *jack, int type) {
> > > > > +       struct snd_kcontrol *kctl;
> > > > > +       struct snd_jack_kctl *jack_kctl;
> > > > > +       int i, err, index, state = 0 /* use 0 for default state
?? */;
> > > > > +
> > > > > +       INIT_LIST_HEAD(&jack->kctl_list);
> > > > > +       for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
> > > > > +               int testbit = 1 << i;
> > > > > +               if (type & testbit) {
> > > >
> > > > With this implementation, you'll get multiple boolean kctls for a
> > > > headset.  I thought we agreed with creating a single boolean for
headset?
> > > [Keyon] We agreed with creating multiple kctls for combo jack, e.g.
> > headset.
> > > Furthermore, e.g., imagine that type = SND_JACK_HEADSET  |
> > > SND_JACK_BTN_0, we will create 3 kctls for the jack, when BTN_0 is
> > > pressed, we will report to the 3rd kctl.
> >
> > Hm, I don't remember that I agreed with multiple kctls...
> >
> > The multiple kctls have a significant drawback (multiple event calls
for a single
> > headset) and its behavior is incompatible with the current code (both
the
> > name change and the behavior change).  That is, your patch will very
likely
> > break the existing applications.
> [Keyon] I am not very clear with the existing applications that using
these
> kctl events(seems Android use input subsystem event? Which we didn't
> Change here. If I understand correctly, Pulseaudio uses jack switch
controls,
> via the name, then we can use different name for headphone and mic here.)
>
> we will generate 2 event calls(one headphone, one mic) when Headset
> plug in/out, applications will receive these 2 events,  and they can do
anything,
> e.g. decide to switch on/off speaker/headphone.

Why do you need to generate two event (hp and mic) if soc jack only support
headset ?

For mobile phone and tablet which only support headset using TRRRS
connector  and most of them don't support  headphone using TRRS connector.

When the headset jack kctl is on, this implies headphone and headset mic
are used
