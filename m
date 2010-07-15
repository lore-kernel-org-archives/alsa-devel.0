From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Fri, 16 Jul 2010 06:02:13 +0800
Message-ID: <AANLkTinzaE-HKVk4b79RJeszrwPnAuoX-aRYf8hSlC6m@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D5DA310391C
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 00:02:15 +0200 (CEST)
Received: by vws9 with SMTP id 9so1721563vws.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 15:02:14 -0700 (PDT)
In-Reply-To: <i1n0mf$87c$1@dough.gmane.org>
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

2010/7/15 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
> > On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
> >
> >>> I posted both of those bug reports. Honestly, I just want it to work
> >>> without all the error output to syslog and thrashing of my HD for
> >>> minutes at a time. As I said, I've got the output of pulseaudio -vvvvv
> >>> if anyone would like to look at it and tell me what I need to do to fix
> >>> the problem.
> >>>
> >>> Chris
> >>>
> >>>
> >>>
> >> Just upload your current pulseaudio.log and output of alsa-info.sh to
> >> mandriva 's bugzilla
> >>
> >> Cannot obtain any conclusion based on the log which you have posted last
> >> year ( xmms)
> >>
> >> as Jaroslav Kysela said , need the real system time between I/O
> operations
> >> and you'll see if it's issue in the ALSA driver or a task scheduling
> >> problem.
> >
> > Here is the bug report with the outputs uploaded.
> >
> > https://qa.mandriva.com/show_bug.cgi?id=60169
>
> Well seeing as my process when getting such a bug is to report it here
> on behalf of the user, I suspect that this has reached a stalemate....
>
> it depend on whether PA developer willing to provide system time between
I/O operations of PA server

However , he can still use a small buffer size to force the PA server into
underrun and we can  know how PA server handle this situtation

aplay -D pulse --buffer-size=128 any.wav
