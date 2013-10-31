From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 15:44:37 +0800
Message-ID: <20131031074436.GG9605@MrMyself>
References: <cover.1383197521.git.b42378@freescale.com>
 <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
 <52720CA4.3090003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52720CA4.3090003@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>
Cc: s.hauer@pengutronix.de, timur@tabi.org, shawn.guo@linaro.org, broonie@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, galak@codeaurora.org, dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi, Philippe

On Thu, Oct 31, 2013 at 08:54:12AM +0100, Philippe R=E9tornaz wrote:
> Hi
>=20
> >
> >+			/* When using dual fifo mode, we need to keep watermark
> >+			 * as even numbers due to dma script limitation.
> >+			 */
> >+			ssi_private->dma_params_tx.maxburst /=3D 2;
> >+			ssi_private->dma_params_tx.maxburst *=3D 2;
> >+			ssi_private->dma_params_rx.maxburst /=3D 2;
> >+			ssi_private->dma_params_rx.maxburst *=3D 2;
> >
>=20
> Why not using a mask here ?
> ssi_private->dma_params_tx.maxburst &=3D ~0x1;
> ssi_private->dma_params_rx.maxburst &=3D ~0x1;

I'll use this in v3. Thank you!

Nicolin Chen

>=20
> Regards,
>=20
> Philippe
>=20
>=20


