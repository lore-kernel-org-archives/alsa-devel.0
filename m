From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: UCM questions
Date: Sat, 22 Jan 2011 13:22:00 +0800
Message-ID: <AANLkTinakGECsLuhuXHe6cYubyD4yhM19-t73gacq+Bf@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
	<20110121164329.GB6200@opensource.wolfsonmicro.com>
	<AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
	<1295653025.3348.697.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4CFAB2433E
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 06:22:01 +0100 (CET)
Received: by ewy19 with SMTP id 19so1229103ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 21:22:01 -0800 (PST)
In-Reply-To: <1295653025.3348.697.camel@odin>
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

2011/1/22 Liam Girdwood <lrg@slimlogic.co.uk>

> On Fri, 2011-01-21 at 14:53 -0600, pl bossart wrote:
> > >> I am fine with a system-specific configuration file for each use case,
> > >> but if I have to change the defines in alsa-lib it's a bit of a pain.
> > >> It'll imply branches and specific packages just for a stupid include
> > >> file.
> > >
> > > If the define isn't there you should just be able to use a string - no
> > > need to update the header file unless the thing being added is
> > > sufficiently general that it seems like a good idea.
> >
> > I think I am missing something here.
> > First I believe there's only one application (PulseAudio or resource
> > management of some sort) that will talk to UCM. Player applications
> > shouldn't know anything about UCM, right? You would end-up making
> > conflicting decisions.
>
> Yes, it's intended only Pulseaudio (or similar) will directly control
> the use case.
>

Do you mean that I cannot use my desktop to act as a karaoke by playing
music to default device and singing to the mic with "Mic Playback Volume" of
HDA codec  until pulseaudio or Sound preference implement "Mic Playback
Volume" ?
