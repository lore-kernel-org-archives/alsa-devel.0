From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Subject: Re: 3.5-rc6 doesn't run powerpc SoundByLayout
Date: Fri, 17 Aug 2012 10:58:14 +0200
Message-ID: <1345193894.2924.10.camel@thor.local>
References: <20120708082157.GA3955@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
In-Reply-To: <20120708082157.GA3955@samweis.home.lxtec.de>
Resent-Message-ID: <opSDKJyJwdH.A.Fl.GfgLQB@bendel>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org, debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org

On Son, 2012-07-08 at 10:21 +0200, Elimar Riesebieter wrote:=20
>=20
> trying 3.5.0-rc6 doesn't give me sound from my snd_aoa_codec_onyx.

I ran into the same problem with 3.5.2+. I think this is the relevant
error in dmesg:

i2c i2c-5: aoa_codec_onyx: attach_adapter method is deprecated
snd-aoa-codec-onyx: found pcm3052
i2c i2c-5: Failed to register i2c client aoa_codec_onyx at 0x46 (-16)

Commit 26b0d14106954ae46d2f4f7eec3481828a210f7d ('sound/aoa: Adapt to
new i2c probing scheme') seems to fix it for me (only tested with
loading the snd-aoa-codec-onyx module manually so far). Andreas, maybe
this commit should be submitted for the 3.5 stable tree?


P.S. Might have helped to report this on the linuxppc-dev mailing list
and/or kernel bugzilla as well.

--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
