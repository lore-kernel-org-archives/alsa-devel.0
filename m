From: "Martin Tufnel" <martin.tufnel@gmail.com>
Subject: Re: hdsp rpm support
Date: Wed, 28 May 2008 23:01:42 +1000
Message-ID: <c62722740805280601pb33035dvd54a1e2973fa8c1d@mail.gmail.com>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<47321.137.248.1.11.1211815832.squirrel@webmail.naturestudies.eu>
	<c62722740805262000i33e9ea00p88bc808ef286732c@mail.gmail.com>
	<200805270814.36011.faber@faberman.de>
	<c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
	<1211895981.5482.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 437D7245FB
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 15:01:44 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so2866027wag.8
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 06:01:42 -0700 (PDT)
In-Reply-To: <1211895981.5482.17.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: reduzierer@yahoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Roman

On Tue, May 27, 2008 at 11:46 PM, Roman Haefeli <reduzierer@yahoo.de> wrote:

> On Tue, 2008-05-27 at 22:59 +1000, Martin Tufnel wrote:
> > Hi Flo
> >
> > On Tue, May 27, 2008 at 4:14 PM, Florian Faber <faber@faberman.de>
> wrote:
> >
> > > Martin,
> > >
> > > > Just to clarify, given the driver is finished but the user tools are
> > > > still under development, this means that the unit will basically work
> > > > but not have its full functionality - is this correct?
> > >
> > > You have IO, you can adjust the input levels, switch standby and
> > > disconnect the box. So everything works as you would expect it.
> > >
> >
> > Great!
> >
> >
> > >
> > > > Also, did you use the new patched version of the firmware that Karl
> > > > worked on?
> > >
> > > No, it's the original firmware. Why would one want to patch it?
> > >
> >
> > My understanding from Roman's previous posts was that there was a problem
> > loading the firmware from within Linux.  If I understood him correctly,
> he
> > needed to load the fireware from within a Windows boot and then boot into
> > Linux (without turning off the machine of course).  Perhaps I
> misunderstood
> > him.
>
> this is exactly what i do. it's no problem, though, to turn off the
> computer after having sent the firmware from within windows, but as soon
> as i power off the rpm, i need to do the process again. this works well
> for me, since most of the time the rpm is sitting home powered on, so i
> can plug it to the laptop and it works.
>
> correct me if i am wrong, but i thought the problem is not the firmware
> itself, or the fact that it is missing, but the (old) version of the
> hdsploader i used to use only knows about the multiface and the
> digiface, but not about the rpm, AFAIK. from what i know, the very same
> firmware, that is used in windows, can be used in linux as well (since
> its card specific and not os-specific), but as flo suggested, the
> userspace tools need to be adapted.
>
> with the old hdsp* stuff, it technically works, but the hdspmixer looks
> like i'd be using a multiface (it shows more channels than the rpm
> actually has) and also the hdspconf shows the switches for the
> mutliface. some card settings can be changed anyway, but you need to
> guess, what is what, since the labels are bogus (for use with the rpm).
>
> i hope i didn't confuse anyone with my old posts. those describe only
> the kludges, i am using with old alsa-drives, until the final driver and
> userspace tools are written.
>
> roman
>

Thanks for the clarification.  This information is important to me because,
as I've said previously, I don't have a Windows box, so I can't use your
work-around.

Regards, Martin
