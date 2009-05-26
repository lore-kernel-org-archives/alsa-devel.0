From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout()
	takes a condition and timeout value
Date: Tue, 26 May 2009 06:32:35 -0500
Message-ID: <ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221507.21370.68301.stgit@terra>
	<alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BF701038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 13:32:37 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4940966qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 04:32:36 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.00.0905260928320.31893@vixen.sonytel.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 2:29 AM, Geert Uytterhoeven
<Geert.Uytterhoeven@sonycom.com> wrote:

> static inline function, returning rc, instead of a macro?

It won't work as an inline function ...

>> + =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 while ((rc =3D (condition)) && (tb_ticks_since(__start) <=3D _=
_loops)) \

There's no way to pass a expression to an inline function.  It has to
be a macro.  Here, the loop evaluates "condition" at every pass.  If
this were an inline function, "condition" would be evaluated once when
the function were called, and never again.

-- =

Timur Tabi
Linux kernel developer at Freescale
