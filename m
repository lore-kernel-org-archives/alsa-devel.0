From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: simple-card: Support for selecting
 system clocks by ID
Date: Mon, 18 Apr 2016 18:50:52 +0300
Message-ID: <5715025C.7070108@ti.com>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk> <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io> <56C42BAF.3050900@ti.com>
 <20160217120759.GO7544@sirena.org.uk> <56C4CF8B.5010005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <56C4CF8B.5010005@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/17/2016 09:52 PM, Peter Ujfalusi wrote:
> On 02/17/2016 02:07 PM, Mark Brown wrote:
>> On Wed, Feb 17, 2016 at 10:13:35AM +0200, Peter Ujfalusi wrote:
>>
>>> With this change we don't need to write custom machine drivers for =
setup not
>>> using sysclk_id =3D=3D 0.
>>> I do think this is reasonable change by itself.
>>
>>> However I do think that the current simple-card is flawed regarding=
 to clock
>>> selection and the change Jyri and me are proposing is reasonable.
>>
>> But you define a new ABI to specify it in the process, I'd rather fi=
x
>> the flaws by using the common clock ABI than extend any device stuff=
=2E
>> If it didn't define a new ABI I'd probably not worry about it but on=
e of
>> the issues we have with DT is that we do end up making ABIs every ti=
me
>> we put something in DT.
>=20
> I understand. This should have been supported by simple-card since th=
e
> beginning. When we tried to move all boards to use simple-card, we hi=
t the
> wall by not being able to select and configure other sysclk_id than 0=
=2E
> I don't want to create yet another simple card which handles only sys=
clk_id 1 ;)
> On the other hand this ABI is backwards compatible since if it is mis=
sing it
> will default to the configuration we right now have regarding to sysc=
lk_dir
> and sysclk_id.
>=20
> I will look at the CCF implementation for McASP first then for aic3x.

The first issue with converting the McASP to use CCF internally for clo=
ck
selection, muxing and rate configuration is that the daVinci platform d=
oes not
use CCF at all. Given that the davinci-mcasp driver is used by daVinci,=
 we
need to have non CCF way supported in ASoC...

--=20
P=E9ter
