From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/7] ASoC: S3C64XX: Pass I2S base address
	from platform	data
Date: Wed, 9 Dec 2009 11:25:22 +0000
Message-ID: <20091209112521.GG19851@opensource.wolfsonmicro.com>
References: <1260332994-11535-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209110900.GE19851@opensource.wolfsonmicro.com>
	<1b68c6790912090314v379883deofaf71199e9d1bcb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AA112435D
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:25:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790912090314v379883deofaf71199e9d1bcb3@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 08:14:24PM +0900, jassi brar wrote:
> On Wed, Dec 9, 2009 at 8:09 PM, Mark Brown

> >> + =A0 =A0 if (!request_mem_region(res->start, resource_size(res),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "s3c64xx-i2s")) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to request SFR r=
egion\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >> + =A0 =A0 }
> >> +

> > This feels like it should be in the patch that requested the resource
> > rather than here. =A0Probably ought to have a version that does the
> > request in 2.6.33 too if we can...

> that patch is only for setting DMA channel and dst addresses, so we
> request MEM resource there.

I'm not sure I follow?  In any case the real issue here is that looking
at this change and it's hard to see how it's immediately related to the
subject of the patch; it's not about how the data is passed and somewhat
distant from the code which does do the passing.

> > A comment explaining why we're doing the subtraction wouldn't hurt; the
> > code is OK.

> its just that i didn't want to reorder the code and MEM resource was requ=
ested
> into a temporary variable 'res' not immediately before this call. At this=
 point
> res->start should do too though.

Yes, I saw - all I'm saying is that putting a note in the code =
