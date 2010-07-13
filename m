From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: FIxed alsa-tools' envy24control missing peak level
	meters and "Reset Peaks"
Date: Tue, 13 Jul 2010 20:25:00 +0800
Message-ID: <AANLkTimpNCEPeEUA3JxsT_ljOiDWvbK30vGh46uAMTBv@mail.gmail.com>
References: <AANLkTimVnkZjBLxxhx4I8OtFiu9oOH0cPpX4V9wNimIa@mail.gmail.com>
	<201007131047.01361.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AD08824476
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 14:25:02 +0200 (CEST)
Received: by vws9 with SMTP id 9so5710287vws.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Jul 2010 05:25:01 -0700 (PDT)
In-Reply-To: <201007131047.01361.gineera@aspect135.co.uk>
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

2010/7/13 Alan Horstmann <gineera@aspect135.co.uk>

> Hi Neils,
>
> On Monday 12 July 2010 23:41, Niels Mayer wrote:
> > I've been long annoyed by alsa-tools' envy24control (*) lack of
> > peak-level indication in it's metering, and the non-implementation of
> > its "Reset Peaks" button:
> > https://bugzilla.redhat.com/show_bug.cgi?id=602903
> >
> > I've fixed that annoyance. Now, a small white line appears above the
> > highest level on each meter, and can be reset via "Reset Peaks"
> > button.
> >
> > Original source:
> >
> http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=envy24control/
> >levelmeters.c;hb=HEAD Patch:
> > http://nielsmayer.com/npm/602903.patch
>
>
Seem "Peak Hold" button (e.g  japa or jaaa ) may be better than "Reset
Peaks" button
