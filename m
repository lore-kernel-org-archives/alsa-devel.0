From: Caleb Crome <caleb@crome.org>
Subject: Re: [ASoc] TDM over one SSC channel on AT91 possible?
Date: Thu, 23 Jun 2011 23:07:16 -0700
Message-ID: <BANLkTik5+sCXWgwCNTRp+WT8UPBS5quAgw@mail.gmail.com>
References: <1308676512.32380.11.camel@alice.bigman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 53951248B2
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 08:07:18 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1703846pzk.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 23:07:17 -0700 (PDT)
In-Reply-To: <1308676512.32380.11.camel@alice.bigman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jason Fox <jfox@gai-tronics.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Heh, this is kind of the opposite problem I had to manage -- I had 8 codecs
that needed to appear as a single card, over a single TDM bus.

I could not find a good way to do it, so i did it in a bad way, by modifying
the codec driver to appear to the kernel as a single codec, but drive all 8
codecs directly from a single instantiated codec.

The sticky point that I couldn't find a good resolution to, is that the
dai_link specifies a physical connection from CPU to codec.  However, it's a
point to point link, which does not allow for multiple codecs on the same
active dai link at the same time.  the sound/soc/soc-core.c does does not
currently start multiple codecs when starting a card (as far as I can tell).

i think you can create 8 dai_links, but I don't suspect you'll be able to
open all 8, at the same time.

What's the point of doing this anyway?  Why do you want it to appear as 8
sound cards?   It seems that you can manage the 8 channels from user space
easily enough.

-Caleb




On Tue, Jun 21, 2011 at 10:15 AM, Jason Fox <jfox@gai-tronics.com> wrote:

> Hello everyone,
>
> I am looking for some help where I need an AD193X codec to be shared
> between 8 audio streams using one SSC channel on an AT91SAM9263, in
> other words, I need it to look like 8 different soundcards.  We have the
> 8 TDM channels working in the driver but I can't figure out how to
> create the proper interface of 8 soundcards for ALSA.  In an earlier
> email in this topic was posted:
>
> > I would instantiate one driver with 3 pcms. This would allow:-
> >
> > pcm0: 2 channel, slot 0,1
> > pcm1: 2 channel, slot 2,3
> > pcm2: 4 channel, slot 0,1,2,3
> >
> > Giving full flexibility for many use cases. The pcms would be mutually
> > exclusive (enforced by machine driver).
> >
> > HTH
> >
> > Liam
>
> I think that maybe that I want to instantiate one driver with 8 pcms.
>  Where/how do I
> instantiate the PCMs?  I guess it in in the machine driver?
>
> This is our first attempt at developing a Linux based system so please
> forgive my
> newbie question.  I am sure this is really simple but I'm not following
> somewhere.
>
> Thanks for your help,
> Jason Fox
> GAI-Tronics
> *******************************************************************
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom
> they are addressed. If you have received this email in error please
> notify the system manager. This footnote also confirms that this
> email message has been swept for the presence of computer viruses.
> www.Hubbell.com - Hubbell Incorporated**
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
