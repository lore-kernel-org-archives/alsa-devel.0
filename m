From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Date: Wed, 10 Apr 2019 10:51:57 -0700
Message-ID: <20190410175156.GA24002@Asurada-Nvidia.nvidia.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada> <1554892497.14997.13.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1554892497.14997.13.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "viorel.suman@gmail.com" <viorel.suman@gmail.com>, "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "s.hauer@pengutronix.de" <s.hau>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 10:34:57AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> =

> On Ma, 2019-04-09 at 21:29 -0700, Nicolin Chen wrote:
> > WARNING: This email was created outside of NXP. DO NOT CLICK links or
> > attachments unless you recognize the sender and know the content is
> > safe.
> > =

> > =

> > =

> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > =

> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > > =

> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > =

> > > =

> > > ---
> > > =A0sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++-----------
> > > ---------
> > > =A01 file changed, 23 insertions(+), 20 deletions(-)
> > > =

> > > +=A0=A0=A0=A0=A0priv->pdev =3D platform_device_register_data(&pdev->d=
ev, mdrv,
> > > 0, NULL,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A00);
> > Would you please send a separate patch to replace "pdev->dev"?
> =

> Thank you for review. Yes, will send V3.

Ah...when I said that, I was literally saying that you should
send a separate patch individually, not resend the series.

Now I see you sent v3/v4 almost at the same time as "Applied"
mails from Mark. And I am totally confused which version got
applied....

Please rebase your local tree and find out which version got
applied and then send the diff with a separate patch.

Thanks
Nicolin
