From: "Ralph Little" <ralph.little@tribaldata.co.uk>
Subject: RE: VIA82XX & aRTS
Date: Fri, 9 Jan 2004 09:51:50 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E73302CFAE1F8D4A908B7B2DD4007DCA0B7A78@TDSCore01.TribalData.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Ing-Simmons <nick.ing-simmons@elixent.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I thought you were being funny, but on closer inspection my work server
has ALSA as an aRTS option. However, my home machine does not, which is
the one I am having trouble with.
My BAD. I assumed that aRTS supported OSS only.

Must have compiled KDE/aRTS without an ALSA option, and it has left me
with only OSS options.
I'll recompile and make sure that support is compiled in.

Many thanks,
Ralph

-----Original Message-----
From: Nick Ing-Simmons [mailto:nick.ing-simmons@elixent.com]=20
Sent: 07 January 2004 17:56
To: Ralph Little
Subject: Re: [Alsa-devel] VIA82XX & aRTS


Ralph Little <ralph.little@tribaldata.co.uk> writes:
>Hi,
>Sorry if this has been mentioned before,
>I tried 1.0.0rc1 with 2.4.19 kernel on my VIA 8233 onboard sound. Seems

>to work fine mostly, except aRTS (KDE) when starts up generates a=20
>horrible squealy noise and barfs out with a CPU overload message after=20
>about 10/15 seconds or so. (KDE 3.1.4) when trying to play a sound=20
>through it.
>=20
>OSS option used.

Why - what happens with alsa option?

>=20
>Anything I can try to help to get to the bottom of this?
>What information would help?
>=20
>Regards,
>Ralph
>=20
>=20
>=20
>=20
>
>---------
>We have moved! Tribal Data Solutions (formerly Trackit Systems) has=20
>moved to bigger and better premises at Hawthorn Park, which is two
minutes from the junction of the A64 and Leeds outer ring road. The new
contact details are; Tribal Data Solutions, Tribal House, Hawthorn Park,
Coal Road, Leeds, LS14 1PQ, Telephone number - 0113 306 0306. For more
details and a map, please visit our website at
http://www.tribaldata.co.uk
>This e-mail and any attachments are confidential and are sent on the
basis of our copyright, e-mail and security policy which can be
inspected by visiting http://www.tribaldata.co.uk/policies.asp=20
>If you are not the intended recipient, please notify the sender and
delete this message. Thank you.
>-----------


---------
Tribal Data Solutions has moved, please visit our website for more =
details http://www.tribaldata.co.uk.=20
This e-mail and any attachments are confidential and are sent on the =
basis of our copyright, e-mail and security policy which can be =
inspected by visiting http://www.tribaldata.co.uk/policies.asp.
If you are not the intended recipient, please notify the sender and =
delete this message. Thank you.
-----------



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
