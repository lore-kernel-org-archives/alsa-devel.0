From: Andreas =?iso-8859-1?q?N=FC=DFlein?= <nutz@unfoog.de>
Subject: Re: No sound with nVidia Corporation MCP79 High
	Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Thu, 2 Jul 2009 19:37:43 +0200
Message-ID: <200907021937.43936.nutz@unfoog.de>
References: <4A493A56.1050504@gmail.com> <200907021254.51495.nutz@unfoog.de>
	<s5h1voz5iq1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.unfoog.de (dom0kun.ath.cx [78.46.99.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 58068244AA
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 19:37:53 +0200 (CEST)
In-Reply-To: <s5h1voz5iq1.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 02 July 2009 15:15:34 you wrote:
> At Thu, 2 Jul 2009 12:54:47 +0200,
>
> Andreas N=FC=DFlein wrote:
> > but i can't get any sound eventhough all channels are unmuted and turned
> > up to 100.
> >
> > i also aplay -Dfoo file.wav again, where foo =3D
> > default,front,surround40,.... , but i always get: aplay: main:608: audio
> > open error: Invalid argument
>
> The error is strange.  Did you build with --enable-dynamic-minors
> configure option?
>
> Otherwise the codec registers look OK.
>


hmmm.. well whenever i really build this manually ( ./configure --with-
cards=3Dhda-intel && make && sudo make install)  i can't load the modules, =

because i get:
[ 1526.091642] snd: Unknown symbol unregister_sound_special                =
                                          =

[ 1526.092374] snd: Unknown symbol register_sound_special_device  =


however when i edited the gentoo-ebuild to use your snapshot, i'm able to =

compile and load the driver but get said error. =


do you have an idea why i'm getting this Unknown symbol -error?  should i =

build alsa-headers myself as well? right now that's built via gentoo-ebuild.

i'll try to copy the ebuild instructions, step by step until i get it runni=
ng =

manually.
