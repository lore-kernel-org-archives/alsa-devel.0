From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Tue, 9 Sep 2008 09:45:35 +0100
Message-ID: <200809090945.35359.gineera@aspect135.co.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809082127.13653.gineera@aspect135.co.uk>
	<20080908205105.GA32649@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id D8C1024525
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:38:25 +0200 (CEST)
In-Reply-To: <20080908205105.GA32649@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Monday 08 September 2008 21:51, you wrote:
> On Mon, Sep 08, 2008 at 09:27:13PM +0100, Alan Horstmann wrote:
> > Attached and here inline is the small change we applied to ensure the
> > byte order is correct in the _spi_write function.  Note we observed the
> > spi bus
>
> I take it you're happy to give this your Signed-off-by?

Yes, fine, though obviously we haven't tested this with any other soc syste=
ms.

wm8731_spi_write_byte_order.patch

Ensure wm8731_spi_write byte order is consistent regardless of endianess.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>


> > With just this one change we have been successful in running the codec
> > over spi.  At present we do have an issue with dapm during capture
> > -nothing is being turned on!  Any pointers would be appreciated.
>
> If you define DEBUG when building soc-dapm.c (a define at the top of the
> source file will do the trick) then it will be very verbose about the
> decisions it's making - that will normally point out the problem.
> Probably either one of the input controls is not configured to make a
> path from the input pins to the ADC or the input has been mistakenly
> marked as disabled.
>
> Otherwise if you post the machine driver and the kernel output with
> DEBUG enabled someone might be able to spot something.

Thanks, Mark, we will try this.

Alan

wm8731_spi_write_byte_order.patch

--- wm8731-orig.c=A0=A0=A0=A0=A0=A0=A02008-09-08 17:16:52.000000000 +0100
+++ wm8731.c=A0=A0=A0=A02008-09-08 21:03:16.000000000 +0100
@@ -688,12 +688,13 @@
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0struct spi_transfer t;
=A0=A0=A0=A0=A0=A0=A0=A0struct spi_message m;
-=A0=A0=A0=A0=A0=A0=A0u16 msg[2];
+=A0=A0=A0=A0=A0=A0=A0u8 msg[2];

=A0=A0=A0=A0=A0=A0=A0=A0if (len <=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;

-=A0=A0=A0=A0=A0=A0=A0msg[0] =3D (data[0] << 8) + data[1];
+=A0=A0=A0=A0=A0=A0=A0msg[0] =3D data[0];
+=A0=A0=A0=A0=A0=A0=A0msg[1] =3D data[1];

=A0=A0=A0=A0=A0=A0=A0=A0spi_message_init(&m);
=A0=A0=A0=A0=A0=A0=A0=A0memset(&t, 0, (sizeof t));
