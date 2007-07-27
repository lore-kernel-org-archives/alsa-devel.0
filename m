From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 15:38:28 -0400
Message-ID: <75b66ecd0707271238p4f48cf8dhefd990d4d8c1b809@mail.gmail.com>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
	<200707271720.41278.gineera@aspect135.co.uk>
	<75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
	<20070727103746.30d03e39@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by alsa0.perex.cz (Postfix) with ESMTP id B194C103820
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 21:38:30 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so835700nzf
	for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2007 12:38:29 -0700 (PDT)
In-Reply-To: <20070727103746.30d03e39@localhost.localdomain>
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
To: stan <stanl@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/27/07, stan <stanl@cox.net> wrote:
> On Fri, 27 Jul 2007 11:59:53 -0400
> "Lee Revell" <rlrevell@joe-job.com> wrote:
>
> > On 7/27/07, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> > > Could you give pointers as to how to modify Alsa configuration so
> > > that rate conversion can never happen, as I would prefer to have an
> > > error accessing the sound card rather than unknown conversion,
> > > which in my use should never be neccesary anyway.
> >
> > Simply open the hw device rather than the default, dmix, or plughw
> > device.
> >
> > Lee
>
> Lee,
>
> Are you saying that plughw *does* do hidden conversion?  I thought its
> definition was equivalent to
>
> newplug {
>         type plug
>         slave {
>                 pcm "hw:0,0"
>         }
> }
>

It's not "hidden" conversion, by using the plughw device you are
explicitly asking ALSA to convert the PCM stream to a format the
hardware supports.

Lee
