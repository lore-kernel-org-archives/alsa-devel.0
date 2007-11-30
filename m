From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 20:53:51 +0100
Message-ID: <47506A4F.6010109@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl> <s5hsl2pf8lf.wl%tiwai@suse.de>	 <Pine.LNX.4.61.0711301050540.10769@tm8103.perex-int.cz>	 <s5hy7cgdmcx.wl%tiwai@suse.de>	 <Pine.LNX.4.61.0711301317240.10769@tm8103.perex-int.cz>	 <s5htzn3ewmx.wl%tiwai@suse.de>	 <Pine.LNX.4.61.0711301428241.10769@tm8103.perex-int.cz>	 <4750461E.2040104@keyaccess.nl> <1196444387.23251.332.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755328AbXK3Tyq@vger.kernel.org>
In-Reply-To: <1196444387.23251.332.camel@queen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "yakui.zhao" <yakui.zhao@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 30-11-07 18:39, Thomas Renninger wrote:

> On Fri, 2007-11-30 at 18:19 +0100, Rene Herman wrote:

>> Thomas Renninger is making some haste with the deprecation of the re=
moved=20
>> functions by the way -- I just saw a patch of his entering my mailbo=
x where=20
>> he says he'd in fact like them deprecated in 2.6.24 already. The ALS=
A=20
>> removal would not seem likely to be scheduled to go to 2.6.24 yet, s=
o I=20
>> guess that won't do?
>>
>> I have no opinion on the schedule -- but Thomas, if you do, I guess =
you'd=20
>> need to convince Jaroslav to withstand The Wrath Of Linus and ask hi=
m to=20
>> push it. We can't have it deprecated (on the "spew warnings" level) =
with=20
>> ALSA still using them in 2.6.24.
>=20
> Why not?
> The intend of __deprecated is to throw some compile warnings?
> In this case it would warn on the official 2.6.24 on functions which =
are
> known to be reverted already for the next cycle (this should not hurt=
?),

It does. A clean build is not about esthetics but about quality. Warnin=
gs=20
that are to be ignored hide warnings that are not to be, not just in th=
e=20
sense of the output but due to humans actively tuning out the noise aft=
er=20
just a few. I'd hate for sound/isa to add to the noise.

> it's more for drivers building against kernel headers getting noticed=
 as
> soon as possible...
>=20
> If this is not added to 2.6.24, the funcs should live there for anoth=
er
> kernel cycle just to not print some irrelevant warnings at compile ti=
me
> things are slowed down...

This makes sense if someone told you that the deprecation period for=20
exported symbols is one kernel cycle but who did?

Anyways, two things:

The number of out of tree users of these symbols is very close to zero =
and=20
quite possibly if not likely _at_ zero after I've cleaned up the couple=
 of=20
half-hearted ALSA ISAPnP drivers that I keep in a few local branches he=
re.

As such, and given that removing them apparently clears the path for a =
long=20
overdue and welcome PnP cleanup, simply yanking them soon would get my =
ack.

Second, as said, speak to Jaroslav as well I guess.

> This is also in vanilla and lives there for some time?:
> kernel/power/pm.c:205: warning: =E2=80=98pm_register=E2=80=99 is depr=
ecated (declared at kernel/power/pm.c:64)
> kernel/power/pm.c:205: warning: =E2=80=98pm_register=E2=80=99 is depr=
ecated (declared at kernel/power/pm.c:64)
> kernel/power/pm.c:206: warning: =E2=80=98pm_send_all=E2=80=99 is depr=
ecated (declared at kernel/power/pm.c:180)
> kernel/power/pm.c:206: warning: =E2=80=98pm_send_all=E2=80=99 is depr=
ecated (declared at kernel/power/pm.c:180)

Exactly, and serves as a perfect reminder of why noone should ever be=20
allowed to deprecate anything until after removing all in tree users.

Rene.
