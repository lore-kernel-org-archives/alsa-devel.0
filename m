From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer=8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: Measuring latency on my Apple G3
Date: 21 Jul 2003 13:09:57 +0200
Sender: linux-audio-dev-admin=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <1058785796.28382.139.camel@thor.holligenstrasse29.lan>
References: <3F1BB92C.6090600@sambara.org>
Reply-To: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-audio-dev-admin@music.columbia.edu>
In-Reply-To: <3F1BB92C.6090600@sambara.org>
Errors-To: linux-audio-dev-admin@music.columbia.edu
List-Help: <mailto:linux-audio-dev-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-dev@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev/>
To: Ismael Valladolid Torres <ismael=g6NPVqWaOk1AfugRpC6u6w@public.gmane.org>
Cc: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-user=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, debian-powerpc=0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-07-21 at 11:58, Ismael Valladolid Torres wrote:
>=20
> I am trying latencytest-0.42-png.tar.gz for measuring latency on my=20
> Apple G3 (Debian/Sid PowerPC). Of course I am enabling USE_GENERIC_TIME=
R=20
> and tuning my hard disk using hdparam before tests. But, results show a=
=20
> very poor performance. Indeed, any X11 stressing involves a raise of th=
e=20
> latency and lots of dropouts.
>=20
> I can't blame hardware. Apple hardware is top-class, and this same=20
> machine features under 1,5 ms of latency using CoreAudio on Mac OS X.=20
> So, whether the PowerPC kernel or X11 are not fully optimized, or the=20
> latencytest application is not reliable on non-Intel platforms.

First of all, you mentioned in another post that you use x11perf to
create X11 stress. Are there also problems with real world apps?

Also keep in mind that neither the vanilla 2.4 kernel nor the X server
were designed for low latency. Have you tried the low latency and/or
O(1) scheduler kernel patches, and not running the X server with
negative nice values if you are?

Last but possibly not least of all, the dmasound driver has been less
prone to dropouts in my experience than the ALSA driver.


--=20
Earthling Michel D=E4nzer   \  Debian (powerpc), XFree86 and DRI develope=
r
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenze=
r
