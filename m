From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding sampling rates etc
Date: Wed, 11 Jul 2007 17:00:12 +0530
Message-ID: <61445c750707110430v717fe1a8q6aa702834d888a6f@mail.gmail.com>
References: <1184102288.3301.56.camel@localhost.localdomain>
	<11054.27185-13613-1900930647-1184140681@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C9B010390E
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 13:30:13 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2136566wag
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 04:30:12 -0700 (PDT)
In-Reply-To: <11054.27185-13613-1900930647-1184140681@seznam.cz>
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
To: "dustin@seznam.cz" <dustin@seznam.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/11/07, dustin@seznam.cz <dustin@seznam.cz> wrote:
>
> Exactly, this sounds like when I was sending left-aligned serial audio
> instead of I2S format from ice1724 to the codec. Low volumes were OK, hig=
ner
> distorted.
>
> Pavel.
>
> >  ------------ P=F9vodn=ED zpr=E1va ------------
> >  Od: Liam Girdwood <lg@opensource.wolfsonmicro.com>
> >  P=F8edm=ECt: Re: [alsa-devel] Query regarding sampling rates etc
> >  Datum: 10.7.2007 23:18:21
> >  ----------------------------------------
> >  On Tue, 2007-07-10 at 19:32 +0530, Pharaoh . wrote:
> >  > Hi,
> >  > This is a very vague question, just thought of asking it after hours
> of
> >  > debugging.
> >  >
> >  > I am testing my alsa driver, written for omap 730/850 based board. I
> am
> >  > testing it by using aplay.
> >  >
> >  > Despite checking clocks, sampling rates etc many times and after
> doing many
> >  > combinations thereof, I cant hear anything more than a noise which
> changes
> >  > and becomes more like the original .wav file as I change various
> params like
> >  > sampling rates/clocks etc. It becomes close to the actual thing, but
> not
> >  > better.
> >  >
> >  > Any idea what are the params I should be tweaking? I know this is h/w
> >  > dependent.
> >  >
> >
> >  Sounds like (no pun intended) your digital audio interface is not set
> up
> >  correctly between your codec and CPU.  It's probably best to make sure
> >  they are both using the same I2S or PCM modes.
> >
> >  Liam
> >
> >  _______________________________________________
> >  Alsa-devel mailing list
> >  Alsa-devel@alsa-project.org
> >  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> >
> >
>
Okay, got it. But in this case wont the data on i2s line get corrupted?
I could see correct data being passed on i2s data line, I tried with some
unique patterns and the 2's compliment was visible on the data line.
