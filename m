From: Gilles =?ISO-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Mon, 27 Feb 2006 14:42:03 +0100
Message-ID: <1141047723.8504.4.camel@lepetit.gilouweb.com>
References: <200602270112.k1R1Ch6K016385@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602270112.k1R1Ch6K016385@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le lundi 27 f=C3=A9vrier 2006 =C3=A0 11:42 +1030, Jonathan Woithe a =C3=A9=
crit :
> Hi Gilou
>=20
> > I've been reading about the CVS version of the hda-intel allowing to =
use a
> > "test" model. ... Using the CVS version, using the test model, I'm ab=
le to
> > make some sound getting out through the "Line out" jack, identified i=
n
> > alsamixer by "LOUT1". LOUT1 acts also on the microphone jack : I can =
hear
> > the sound in mono by the mic jack when it's active ! However, I can't=
 hear
> > anything from the headphone jack, and the same goes for the internal
> > speakers, whatever strange things I try with the mixer. I haven't tri=
ed to
> > input anything, as I would like the output to work first.
>=20
> Over the weekend there have been major developments in this regard, to =
the
> point that at least some Acers can make noise from the internal speaker=
 and
> the headphone jack.  I am preparing a series of ALC260 consolidation pa=
tches
> now which will include the initial implementation of an "acer" model.  =
This
> should be posted tomorrow.  It would be good if you could test these pa=
tches
> with your Acer and let us know how it goes.
>=20
> If it *does* help, it would be good to know the make/model of your lapt=
op
> and the PCI IDs of your laptop's sound system.  The latter are reported=
 via
> lspci. Refer to a post against bug 1618 by me earlier today for the ful=
l
> details on getting these numbers.
>=20
> Regards
>   jonathan

Hi, and thanks for your answer !

I followed Rimas Kudelis' advice, and I applied the patch on the bug
report about the ALC260, and it just works smoothly.

Thanks for your work guys !

Gilou



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
