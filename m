From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 23 Aug 2004 14:34:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4129E473.6070702@pg.gda.pl>
References: <Pine.HPX.4.33n.0408181538550.24798-100000@studcom.urz.uni-halle.de> <1092842830.13603.3.camel@localhost.localdomain> <20040818181350.2b38e875@mango.fruits.de> <Pine.LNX.4.58.0408181918160.1769@pnote.perex-int.cz> <20040818201535.1f49a128@mango.fruits.de> <Pine.LNX.4.58.0408191050220.1779@pnote.perex-int.cz> <s5h8ycbv4s9.wl@alsa2.suse.de> <Pine.LNX.4.58.0408191225170.1779@pnote.perex-int.cz> <4129D6A2.7020801@pg.gda.pl> <Pine.LNX.4.58.0408231349520.1801@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28110278
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 14:34:59 +0200 (MEST)
Received: from [153.19.40.232] (atlka@merlin.oi.pg.gda.pl [153.19.40.232])
	by sunrise.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i7NCYvWC019429
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2004 14:34:57 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0408231349520.1801@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org





> On Mon, 23 Aug 2004, Adam Tla=B3ka wrote:
>=20
>=20
>>>On Thu, 19 Aug 2004, Takashi Iwai wrote:
>>>
>>>>Can "network sound device" work with the mmap, too?
>>>
>>>I think yes, it can, but the real output will be more delayd. So, it w=
on't=20
>>>be much useable for the strict real-time applications.
>>
>>But old quake and new quake3 and some OSS apps use mmap mode for better=
=20
>>timing and accurate mixing so will it be usable if done that way?
>=20
>=20
> I already stated: If you want to use real-time applications, buy real-t=
ime=20
> hardware.
They are rather normal user applications then specialized RT apps - I=20
don't want to buy specialized hardware just to play some games
or mix system sounds with browser and communicator apps sounds.
Also switching two, 4 or 5.1 mode and headphone mode should be done
just by one click without application restarting. So down/up mixing
should be in a driver. I think it can't be done with todays ALSA in lib=20
functionality approach and never will be.

Regards
--=20
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
