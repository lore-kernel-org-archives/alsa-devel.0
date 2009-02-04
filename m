From: =?iso-8859-1?q?Aur=E9lien_Croc?= <aurelien@ap2c.com>
Subject: Re: No headphone with an Intel 82801I sound card
Date: Wed, 4 Feb 2009 21:26:13 +0100
Message-ID: <200902042126.13241.aurelien@ap2c.com>
References: <200902020244.20757.aurelien@ap2c.com>
	<s5hzlh26s9y.wl%tiwai@suse.de> <s5hy6wm6s7e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cirse-out.extra.cea.fr (cirse-out.extra.cea.fr
	[132.166.172.106])
	by alsa0.perex.cz (Postfix) with ESMTP id 232B7103804
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 21:26:15 +0100 (CET)
Received: from cyclose1.extra.cea.fr (cyclose1.extra.cea.fr [132.167.198.22])
	by cirse.extra.cea.fr (8.14.2/8.14.2/CEAnet-Internet-out-1.2) with
	ESMTP id n14KQEug013603
	for <alsa-devel@alsa-project.org>; Wed, 4 Feb 2009 21:26:14 +0100
Received: from orpin1.extra.cea.fr (orpin1.extra.cea.fr [132.167.198.4])
	by cyclose1.extra.cea.fr (8.13.8/8.13.8) with ESMTP id n14KQEcp006516
	for <alsa-devel@alsa-project.org>; Wed, 4 Feb 2009 21:26:14 +0100
	(envelope-from aurelien@ap2c.com)
Received: from daplxa200.extra.cea.fr (daplxa157.extra.cea.fr [132.166.43.57])
	by orpin1.extra.cea.fr (8.13.8/8.13.8/CEAnet-Extranet-out-1.1) with
	ESMTP id n14KQD9O015653
	for <alsa-devel@alsa-project.org>; Wed, 4 Feb 2009 21:26:13 +0100
In-Reply-To: <s5hy6wm6s7e.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> > The digital mic isn't detected, so apparently (according to BIOS)
> > there is no digital mic but only analog mics.
> > The problem at a quick glance is that you didn't enable "Capture
> > Switch" and you didn't adjust "Capture Volume" as well.

Of course, i tried the mic by enabling the microphone but when i took these =

information after a lot of reboot, i ddin't enabled it.. =


> Oh, and it'd be helpful if you can get alsa-info output on the older
> kernel (with the digital mic working) so that we can compare the
> difference.

It is the first thing i gave to you when i related the problem.
For information, the next link is the alsa-info output when the digital =

microphone -works- and the headphone -doesn't- work:
	http://www.alsa-project.org/db/?f=3D6def7ad107a215d22cef35a74d701216c5a496=
bd

In the next link (or in the file attached to one of my previous email) you =

will find the alsa-info output when the digital microphone -doesn't- work a=
nd =

the headphone -works-:
	http://www.alsa-project.org/db/?f=3D31b5974fde70e1c5273f4248023481bb6766c4=
6f


I hope it will help you.
Best regards, =


Aur=E9lien
