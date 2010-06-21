From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 13:27:00 +0800
Message-ID: <AANLkTin2DtVQR_XBat8T_aCrf2_PgIm0KNgXkZfHfnUn@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikz9pqSvylmKfUPVHRvZtFx4pwzFeRbDWjO9Z8w@mail.gmail.com>
	<1277083535.22889.51.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 95F88243FA
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 07:27:02 +0200 (CEST)
Received: by vws20 with SMTP id 20so187903vws.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 22:27:00 -0700 (PDT)
In-Reply-To: <1277083535.22889.51.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/21 David Dillow <dave@thedillows.org>

> On Mon, 2010-06-21 at 08:47 +0800, Raymond Yau wrote:
> > 2010/6/20 David Dillow <dave@thedillows.org>
> >
> > > Please keep me on the cc list, I'll see your message sooner in my Inbox
> > > than my mailing list folders.
>
> Please don't trim the cc list when replying. If you inadvertently hit
> reply instead of reply-to-all, my apologies.
>
> > AFAIK , pulse device did not support MMAP
>
> Thanks, that's a pretty good clue he's using the hardware device.
> Unfortunately, that means either I have bug in my driver or he's got too
> much system noise and hitting overruns.
>
>

17:41:30.646532 access("/usr/share/alsa/cards/SiS7019.conf", R_OK) = -1
ENOENT (No such file or directory)

There is no aliase for SiS7019 entry in /usr/share/alsa/cards/aliases.conf
