From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 22 Jun 2010 10:31:42 +0800
Message-ID: <AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>
	<hv5dkf$tv8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7715E103895
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 04:31:43 +0200 (CEST)
Received: by vws20 with SMTP id 20so1475802vws.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 19:31:42 -0700 (PDT)
In-Reply-To: <hv5dkf$tv8$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/14 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 14/06/10 13:36 did gyre and gimble:
> > 2010/6/14 James Courtier-Dutton <james.dutton@gmail.com>
> >
> >> On 14 June 2010 11:22, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> >>> 'Twas brillig, and James Courtier-Dutton at 14/06/10 09:56 did gyre and
> >>> gimble:
> >>>> If you use "alsamixer", dB values are shown so it is easy to find the
> >>>> 0dB "sweet spot".
> >>>> I think it is pulse audio that hides this information when it combines
> >>>> two alsa mixer controls into one pulseaudio control.
> >>>
> >>> But it doesn't hide it. It's shown very clearly in the volume control
> >>> GUIs as the Base Volume.
> >>>
> >>> Do you really think that most users look at the sliders to find the 0dB
> >>> point? Does gnome-alsa-mixer (the old one) expose this information? No.
> >>> Does kmix? No. So the vast, vast majority of users do not know where
> the
> >>> 0dB point is unless they use alsamixer.... and even if the user is
> >>> advanced enough to use alsamixer, then I'd still say a proportion of
> >>> users are just looking at how far up the slider is rather than looking
> >>> specifically for 0dB.
> >>>
> >>> So I'd argue the exact opposite of your claim. That with the base
> volume
> >>> clearly presented in the GUI, the h/w 0dB spot is much, much more
> >>> obvious to the vast majority of users.
> >>>
> >>> I really think this is a vast improvement over a complex balancing act
> >>> of getting two different sliders setup to get distortion free audio!
> >>>
> >>> Col
> >>
> >> One has very different problems with capture than one does with
> playback.
> >> With capture it is important to identify which are analog controls
> >> (applied to the analog part of the circuit) and which are digital
> >> controls (applied to the digital part of the circuit)
> >> So, for capture one might wish to adjust the analog control so that
> >> the signal going into the ADC is a suitable level, but once the signal
> >> is digital, one should really not adjust it further, and just record
> >> what you have.
> >> If one was to combine these two capture controls in one PA control, it
> >> would just be wrong.
> >>
> >>
> > The AC97 recording from line-in problem seem not related to capture gain
> > since you can set capture volume to 0dB
> >
> > The HDA 's "PCM" softvol plugin is different from AC97 "PCM" Playback
> volume
> >
> > But you can change the softvol plugin to add gain to emulate the clipping
> in
> > software side if PA developers did not have ac97 sound card ( clipping
> occur
> > in hardware side )
> >
> >   /usr/share/alsa/cards/HDA-Intel.conf
> >
> > HDA-Intel.pcm.front.0 {
> >     @args [ CARD ]
> >     @args.CARD {
> >         type string
> >     }
> >     type softvol
> >     slave.pcm {
> >         type hw
> >         card $CARD
> >     }
> >     control {
> >         name "PCM Playback Volume"
> >         card $CARD
> >     }
> > +      min_dB -46.5
> > +     max_dB 12.0
> > +      resolution 32
> > }
>
> I've made this change on my system and while previously my UI had no
> "Base Volume" displayed (because all my "h/w" (I include softvol in
> that) controls had their dB value >0.
>

as your card has no h/w gain,  > 0dB , but the gain in softvol plugin is a
software gain (i.e. in the red region in PA "s volume scale

how can base_volume display in gnome volume control (unamplified) ?

BTW ,  -46.5dB to 0dB of softvol plugin is software atten ( not h/w atten )




>
> Now that this change is live, I have a base volume present in my GUI (at
> around the 64% mark with the cubic scale we've already discussed). When
> I set my volume ot the base volume, the h/w controls are all set to 0dB
> which is exactly as expected.
>


>
> I fail to see the point here? The base volume is clearly exposed to the
> as the recommended point on the scale at which no clipping occurs.
>
> I really don't get where your complaint is.
>
> Col
>
>
>
>
