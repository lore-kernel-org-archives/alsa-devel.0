From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 2/5] Main rewite of the mpc5200 audio
	DMA code
Date: Tue, 26 May 2009 12:08:01 -0500
Message-ID: <ed82fe3e0905261008n68672c6dk7bfc99e4cd614747@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221509.21370.70182.stgit@terra>
	<20090526110120.GA8969@sirena.org.uk>
	<fa686aa40905260951g5115007fo3ef5eb1fb90998f3@mail.gmail.com>
	<9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 558571038EB
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 19:08:03 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so2139732qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 10:08:02 -0700 (PDT)
In-Reply-To: <9e4733910905260953i6337f8a9xc3cd1ff490cd3540@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 11:53 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Put in the V5 version this one has this in the h file:
>
> -int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *=
dai);
> +/* whack this after Timur's patch is merged in to
> arch/powerpc/include/asm/delay.h */
> +#define spin_event_timeout(condition, timeout, delay, rc) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \
> + =A0 =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 while ((rc =3D (condition)) && (tb_ticks_since(__start) <=
=3D __loops)) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (delay) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax(); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> +}
> +/* whack this after Timur's patch is merged in to
> arch/powerpc/include/asm/delay.h */

It won't be that simple.  V9 of my patch changes the number of
parameters, so not only will you need to whack this copy of the macro,
you'll also need to change the callers.

-- =

Timur Tabi
Linux kernel developer at Freescale
