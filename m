From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: explicit commandline control of speakers vs
 headphone output
Date: Thu, 26 Aug 2010 06:48:34 +0800
Message-ID: <AANLkTi=8tUSmD+h4oUODAWk7xU63Mb66FU_7N4OxgxFz@mail.gmail.com>
References: <858637.27362.qm@web50708.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 08B1C24778
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 00:48:35 +0200 (CEST)
Received: by fxm11 with SMTP id 11so800143fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 15:48:34 -0700 (PDT)
In-Reply-To: <858637.27362.qm@web50708.mail.re2.yahoo.com>
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

2010/8/26 Eric Holstege <eric_holstege@yahoo.com>

> It appears that when I have a headphone plugged in, the speakers are
> automatically disabled and the output sound is sent to the headphone.
>
> However, I want to explicitly control (e.g. via a script or commandline
> - not a GUI) whether the sound from an (arbitrary) application is going
> to the speakers or to the headphone even when the headphone is plugged in.
> (When I say "arbitrary application" that means I can't alter the code of
> the application itself).
>
> Is this possible?
>
> (I have heard that ALSA mutes the speakers when it detects plugged-in
> headphones. Is switching between them as simple as using e.g. amixer(1)
> to unmute the speakers and mute the headphones and vice versa, or is
> there more to it.)
>
>
>
it is really hardware dependent

Which on-board sound driver are you using ?

auto mute is a specific feature for notebook in old day

For the desktop,  the front panel audio connector of the AC97' chassis and
HDA chassis

http://www.intel.com/support/motherboards/desktop/sb/cs-015851.htm

For some HDA codec, the headphone (front panel green jack) can be used
indpendent of the rear panel jacks on desktop
