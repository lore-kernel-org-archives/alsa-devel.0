From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS35L32 Boosted
	Amplifier
Date: Thu, 31 Jul 2014 09:37:38 -0500
Message-ID: <alpine.DEB.2.02.1407310936000.7394@heelrod>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <CADhT+wfub5Li5tdM+dTnridOs9k5GwaKDTKvo7s-nefS4Oymyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1994874856-1406817458=:7394"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D1CE2608D3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 16:34:04 +0200 (CEST)
In-Reply-To: <CADhT+wfub5Li5tdM+dTnridOs9k5GwaKDTKvo7s-nefS4Oymyg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

--8323329-1994874856-1406817458=:7394
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Wed, 30 Jul 2014, Dinh Nguyen wrote:

>=20
>=20
>=20
> On Tue, Jul 29, 2014 at 3:02 PM, Brian Austin <brian.austin@cirrus.com>=
 wrote:
>       This patch adds support for the Cirrus Logic CS35L32 Boosted Ampl=
ifier
>       I2S Output provides monitor data to the SOC/CODEC for speaker pro=
tection algorithms
>=20
>       Signed-off-by: Brian Austin <brian.austin@cirrus.com>
>       ---
>       =C2=A0include/dt-bindings/sound/cs35l32.h | =C2=A0 26 ++
>       =C2=A0sound/soc/codecs/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A05 +
>       =C2=A0sound/soc/codecs/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 +
>       =C2=A0sound/soc/codecs/cs35l32.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0670 +++++++++++++++++++++++++++++++++++
>       =C2=A0sound/soc/codecs/cs35l32.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 97 +++++
>       =C2=A05 files changed, 800 insertions(+)
>       =C2=A0create mode 100644 include/dt-bindings/sound/cs35l32.h
>       =C2=A0create mode 100644 sound/soc/codecs/cs35l32.c
>       =C2=A0create mode 100644 sound/soc/codecs/cs35l32.h
>=20
>       +
>       +static int int_clear(struct snd_soc_dapm_widget *w,
>       + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct snd_kcontrol *kcontrol, int event)
>       +{
>       + =C2=A0 =C2=A0 =C2=A0 struct snd_soc_codec *codec =3D w->codec;
>       +
>       + =C2=A0 =C2=A0 =C2=A0 if (SND_SOC_DAPM_EVENT_ON(event)) {
>       + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_read(c=
odec, CS35L32_INT_STATUS_1);
>       + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_read(c=
odec, CS35L32_INT_STATUS_2);
>       + =C2=A0 =C2=A0 =C2=A0 } else {
>       + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>       + =C2=A0 =C2=A0 =C2=A0 }
>       + =C2=A0 =C2=A0 =C2=A0 return 0;
>=20
>=20
> Can remove one of the "return 0" or why not just a void?
You know, I think I am just going to remove this altogether. It was a=20
request from Apps and I don't think it is really needed. I'll test withou=
t=20
it and send a v2 with it removed.

Thanks,
Brian

--8323329-1994874856-1406817458=:7394
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1994874856-1406817458=:7394--
