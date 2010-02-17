From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 12:42:05 +0000
Message-ID: <20100217124205.GA11510@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<20100217104222.GA31765@sirena.org.uk>
	<1b68c6791002170413o61958189y786b13477fd7e12a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17F1B103856
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 13:42:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002170413o61958189y786b13477fd7e12a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 09:13:05PM +0900, jassi brar wrote:
> On Wed, Feb 17, 2010 at 7:42 PM, Mark Brown

> > So. =A0Ideally for hardware mixing you'd represent the hardware mixing =
as
> > a device within ASoC but that's not currently supported - the multi
> > CODEC work should take care of it but it's not there yet.

> is that work visible on some branch in ur tree?

I'm not doing it, it's on Liam's list.  I generally don't maintian
branches for anything.

> > Overall I don't see any immediate problem with supporting this in
> > mainline as-is from what I've looked at so far.

> I assume this is about dma_id flag?

The hardware mixing too, like I say it's the most trivial case possible
so doesn't run into many problems.
