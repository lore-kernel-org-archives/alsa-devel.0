From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with
 break
Date: Wed, 10 Apr 2019 02:39:38 +0000
Message-ID: <VE1PR04MB6479E21639D20833A71F9B57E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
 <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <eba6372b-618c-4633-f0a9-06c034cf2f9c@embeddedor.com>
 <20190409035450.GA8476@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190409035450.GA8476@Asurada>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi

>=20
> Hi Gustavo,
>=20
> On Mon, Apr 08, 2019 at 10:20:25PM -0500, Gustavo A. R. Silva wrote:
> > >>> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > >>> index
> > >>> c7410bbfd2af..bad0dfed6b68 100644
> > >>> --- a/sound/soc/fsl/fsl_esai.c
> > >>> +++ b/sound/soc/fsl/fsl_esai.c
> > >>> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct
> > >> snd_soc_dai *dai, int clk_id,
> > >>>               break;
> > >>>       case ESAI_HCKT_EXTAL:
> > >>>               ecr |=3D ESAI_ECR_ETI;
> > >>
> > >> Also, you should use a simple assignment operator "=3D" instead of
> > >> "|=3D" in both cases.
> > >
> > > The result is same for "=3D" and "|=3D", because there is "ecr =3D 0"=
 in
> > > beginning of This function.
> > >
> >
> > Following that same logic, then why not use "+=3D" instead?
> >
> > The point is: is "|=3D" or any other assignment operator other than "=
=3D"
> necessary?
> > The answer in this case is: no, it is not.  So, go for the simple one
> > and avoid any unnecessary confusion.
>=20
> I would like to keep "|=3D" here, just in case that someday it'd be easie=
r to
> insert something to ecr before this chunk. So please get easy on this one=
.
>=20
> Thanks
> Nicolin

Thanks for reviewing,  I will send v2.

Best regards
Wang shengjiu
