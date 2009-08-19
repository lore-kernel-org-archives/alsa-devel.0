From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] Add FSI-AK464x sound support for
	ms7724se
Date: Wed, 19 Aug 2009 15:02:56 +0100
Message-ID: <20090819140256.GA31305@rakim.wolfsonmicro.main>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	<20090819120058.GB20227@rakim.wolfsonmicro.main>
	<aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AE3E103895
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 16:02:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 10:46:34PM +0900, Magnus Damm wrote:
> On Wed, Aug 19, 2009 at 9:00 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> >> + =A0 =A0 gpio_request(GPIO_FN_FSIMCKA, =A0 =A0NULL);

> > Is this something that the FSI driver should do for itself? =A0It looks
> > like there's no pin options here, just fixed functions for FSI A or B so
> > replicating per-board seems redundant. =A0On the other hand, if it's
> > idiomatic for SH better keep it this way.

> These GPIO_FN_ values are processor specific, sh7724 in this case. I
> suspect we will see the FSI block reused in future processors so
> keeping processor-specific bits out of the driver itself may be a good
> plan. Long term I'd be more than happy to pass along processors
> specific GPIOs to each driver, but at this point I don't know any
> clean and standard way to do that.

Is it possible to build kernels for more than one processor?  The way
the code looks that's not the case...
