From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH v2 4/4] Rename exports in mpc5200_dma.c
Date: Mon, 27 Apr 2009 21:19:02 -0400
Message-ID: <9e4733910904271819v5b95b28fxdb51021adc38d83@mail.gmail.com>
References: <20090427164108.18211.44680.stgit@terra>
	<20090427164447.18211.42851.stgit@terra>
	<20090427193534.GA23567@rakim.wolfsonmicro.main>
	<9e4733910904271305h171f5e9dybdd560ae2c22c9bf@mail.gmail.com>
	<20090427200910.GC14626@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 8509A2415F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 03:19:04 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so215462qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 18:19:03 -0700 (PDT)
In-Reply-To: <20090427200910.GC14626@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You could just drop this #4 patch. Since the driver is marked broken
it doesn't matter if it doesn't compile right.
Everything in this patch is undone by later ones.

On Mon, Apr 27, 2009 at 4:09 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
> On Mon, Apr 27, 2009 at 04:05:10PM -0400, Jon Smirl wrote:
> > On Mon, Apr 27, 2009 at 3:35 PM, Mark Brown
> > <broonie@opensource.wolfsonmicro.com> wrote:
>
> > > Why are you exporting these? ?They should all be accessed via...
>
> > This is part of what is broken in the driver. I have later patches
> > that fix it but those patches are more complex.
>
> Could you go into more detail on this, please? =A0Why aren't you just
> moving them directly to the vtable of the DMA driver?



--
Jon Smirl
jonsmirl@gmail.com
