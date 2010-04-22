From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Thu, 22 Apr 2010 09:16:44 +0800
Message-ID: <i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
	<hqbv5m$cmf$1@dough.gmane.org>
	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>
	<hqmbmm$hsj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id EB83F24339
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 03:16:46 +0200 (CEST)
Received: by pvh11 with SMTP id 11so224971pvh.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 18:16:45 -0700 (PDT)
In-Reply-To: <hqmbmm$hsj$1@dough.gmane.org>
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

2010/4/21 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 21/04/10 03:32 did gyre and gimble:
> > 2010/4/17 Colin Guthrie <gmane@colin.guthr.ie>
> >
> >> 'Twas brillig, and Raymond Yau at 16/04/10 14:48 did gyre and gimble:
> >>> 2010/4/3 Colin Guthrie <gmane@colin.guthr.ie>
> >>
> >> Sorry for the top post but....
> >>
> >> Raymond. Your replies are often very disjoint. I see no relevance to my
> >> message here and why you're replying here is beyond me.
> >>
> >> It's totally unclear what point you are making and which parts of this
> >> message are your comments and which are Lennart's original comments
> >> that's you've just pasted in.
> >>
> >> What are you trying to say?
> >>
> >> Col
> >>
> >
> > http://pulseaudio.org/ticket/580
> >
> >>> Basically, if the signal is completely cut off, then the attenuation is
> > -inf dB.
> >
> > you have to sum the dB gain of  the SPL of the speaker/headphone when you
> > want to calculate the dB ( sound pressure and the distance )
> >
> >
> >>> FWIW, I've got the same/similar h/w with a cutoff at 14% in PA as you
> > have. I've been meaning to get this fixed for a while, but I'm
> > incredibly lazy with certain things that don't bother me practically, so
> > haven't followed it up yet.
> >
> >>> If any specific debug is needed here, feel free to ask.
> >
> > Just reply since you still have similar problem , but it seem that you
> are
> > unwilling to provide info to debug your case , at least you have to
> provide
> > output of alsa-info.sh even when you have the same/similar h/w  ,
>
>
> What debug have you asked me for?


Just output of alsa-info.sh as stated in my previous email

and please confirm that PA provide software gain


> It's impossible to tell from the
> vaguely relevant quotations (poorly formatted in email so that only half
> of the quoted text actually looks like a quote) and random specification
> sheet snippets you post that you're actually asking for anything at all!
>
> If you want information, ask for it clearly and I'll do my best to
> answer it.
>
>
> > If pulseaudio provide per-application volume control, why the PA
> community
> > propose to throw away the volume slider of the application. (i.e. why
> only
> > allow pavucontrol to change the per-application volume ?
> >
> >
> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/6521/focus=6524
>
> That is a discussion, not a statement of intent. As I stated on that
> thread, I personally disagree with Tanu's position, but if you are
> interested in this discussion, feel free to join in on that list. It's
> nothing to do with this thread at all however (it's purely a UI and user
> expectation of cause + effect), so let's not drag this thread further
> into the land of obscure tangents.
>
> >>> Making the application volume sliders control the device volume isn't
> > good either, because if an application has a volume slider, the natural
> > assumption made by users is that the slider controls only that
> application's
> > volume.
> >
> >>> Solution: throw away volume sliders in applications, and promote
> centralized volume management with volume applets and hardware controls.
> >
> >
> > I suggest PA should provide the pre-application volume control for the
> > application too since from the viewpoint of PA when PA have to control
> all
> > the volume , it is better not allow application to control alsa master
> > volume control. but there is no reason to remove the volume sliders in
> > application
>
> I suggest you discuss this issue on the actual thread itself rather than
> pull it in to a completely different one. I do however think you've
> missed the point, but like I say that is something to discuss there, not
> here.
>


I just make suggestion only since I don't know whether it is feasible  to
implement IFACE_PCM in ctl_pulse.c but I strongly recommended PA provide dB
scale for the Master Volume control for the pulse device ( alsa-pulse plugin
) in order for the mixer application to provide a more useful info to the
user


>
> Col
>
>
