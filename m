From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
Date: Thu, 21 Mar 2019 14:15:41 +0000
Message-ID: <AM5PR1001MB0994B0B76F0166D45990E5F980420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
 <20190321122152.GA5684@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321122152.GA5684@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 21 March 2019 12:22, Mark Brown wrote:

> On Tue, Mar 19, 2019 at 05:49:30PM +0000, Adam Thomson wrote:
>=20
> > -- #clock-cells :  Should be set to '<0>', only one clock source
> > provided;
> > -- clock-output-names : Name given for DAI clocks output;
> > +- #clock-cells :  Should be set to '<1>', two clock sources provided;
> > +- clock-output-names : Names given for DAI clock outputs (WCLK &
> > +BCLK);
>=20
> This might need some handling later on as it's a binding change, however =
I can't
> see any current users so hopefully nobody will notice.

No I do not believe there are users of this, other than the AMD board which
doesn't use these bindings. Actually given they're the same bindings, albei=
t
with a different number of cells, I've tested the code with just 1 cell and
1 clock in the DTS and this still works as before so the driver should be
backwards compatible.
