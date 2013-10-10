From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra 8r...
Date: Thu, 10 Oct 2013 18:57:53 +0200
Message-ID: <CAFz=ag5aCshs6WJAksartBXfkUpocYEw5WknT=AStP0aFPo35g@mail.gmail.com>
References: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f42.google.com (mail-qe0-f42.google.com
 [209.85.128.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5452C2617AD
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 18:57:54 +0200 (CEST)
Received: by mail-qe0-f42.google.com with SMTP id gc15so2263369qeb.29
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 09:57:53 -0700 (PDT)
In-Reply-To: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Petri_J=E4rvisalo?= <petri.jarvisalo@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Petri,

It's been me who worked out the patches for mixer support on the Fast Track
Ultra series some while ago. The question you asked has been asked before
and I've answered it similarly before. Let' get into it:

> What I expected was clear stereo/surround sound, what i got was distorted
> mono sound with reverb!

How do you come to expecting stereo/surround sound from a device that has 8
outputs, 8 inputs and 8 'software input' channels?

> Far away from optimal settings!

Yes, that's true. But actually I don't think there is something like
'optimal settings' for this device in general since use cases differ a lot:
You might look into stereo/surround, others prefer 'diagonal software only=
=92
I for myself have completely different needs.

The only reasonable sane default I can think of is 'everything muted'. But
that again wouldn't fit many expectations. (Although I would probably
implement *this* default if there was a consensus on it.)

That's why I decided not to do anything with the current defaults. At least
they make it *very* clear that you probably should adjust something for
this device ;-)

Maybe I should add a Readme to the ALSA docs but I haven't found the time
to do so.

BTW, you can save your own settings via alsactl.

Ultimately I think that anybody using this device should adjust his initial
settings via a script first since it is a major pain in the ass to manually
adjust all those controls.

A dedicated Fast Track Ultra mixer application could also be helpful. So if
you're interested: Just start working on it.

Regards,
Felix
