From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: 3.5-rc6 doesn't run powerpc SoundByLayout
Date: Fri, 17 Aug 2012 14:17:07 +0200
Message-ID: <m2zk5t4ssc.fsf@igel.home>
References: <20120708082157.GA3955@samweis.home.lxtec.de>
	<1345193894.2924.10.camel@thor.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
In-Reply-To: <1345193894.2924.10.camel@thor.local> ("Michel =?utf-8?Q?D?=
 =?utf-8?Q?=C3=A4nzer=22's?= message
	of "Fri, 17 Aug 2012 10:58:14 +0200")
Resent-Message-ID: <I4KovlroK0F.A.GUB.lwjLQB@bendel>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <daenzer@debian.org>
Cc: Elimar Riesebieter <riesebie@lxtec.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org, debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org

Michel D=C3=A4nzer <daenzer@debian.org> writes:

> Commit 26b0d14106954ae46d2f4f7eec3481828a210f7d ('sound/aoa: Adapt to
> new i2c probing scheme') seems to fix it for me (only tested with
> loading the snd-aoa-codec-onyx module manually so far). Andreas, maybe
> this commit should be submitted for the 3.5 stable tree?

You also need 3a3dd01.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED=
5
"And now for something completely different."


--=20
To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
Archive: http://lists.debian.org/m2zk5t4ssc.fsf@igel.home
