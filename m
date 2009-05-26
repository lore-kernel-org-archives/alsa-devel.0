From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
Date: Tue, 26 May 2009 13:51:47 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221507.21370.68301.stgit@terra>
	<alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, 26 May 2009, Timur Tabi wrote:
> On Tue, May 26, 2009 at 2:29 AM, Geert Uytterhoeven
> <Geert.Uytterhoeven@sonycom.com> wrote:
> =

> > static inline function, returning rc, instead of a macro?
> =

> It won't work as an inline function ...
> =

> >> + =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 while ((rc =3D (condition)) && (tb_ticks_since(__start) <=3D=
 __loops)) \
> =

> There's no way to pass a expression to an inline function.  It has to
> be a macro.  Here, the loop evaluates "condition" at every pass.  If
> this were an inline function, "condition" would be evaluated once when
> the function were called, and never again.

You're right, I missed that part. Sorry about that.

However, you can still improve useability by making the macro return the rc,
instead of letting the caller pass it, cfr. wait_event_timeout() and friend=
s.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
