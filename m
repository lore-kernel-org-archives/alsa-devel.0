From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Thu, 8 Nov 2012 15:38:36 +0100
Message-ID: <509BC3EC.4030503@ti.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id BF40C260318
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 15:38:40 +0100 (CET)
In-Reply-To: <5098E929.7040404@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 11/06/2012 11:40 AM, Rajeev kumar wrote:
> Please find below the implementation for dapm.
> =

> static const struct snd_soc_dapm_widget sta529_dapm_widgets[] =3D {
>         SND_SOC_DAPM_DAC("DAC", "Play", SND_SOC_NOPM , 0, 0),
>         SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
>         SND_SOC_DAPM_OUTPUT("HPL"),
>         SND_SOC_DAPM_OUTPUT("HPR"),
>         SND_SOC_DAPM_OUTPUT("SPKL"),
>         SND_SOC_DAPM_OUTPUT("SPKR"),
>         SND_SOC_DAPM_INPUT("MIC1"),
> };
> =

> static const struct snd_soc_dapm_route sta529_audio_map[] =3D {
>         {"DAC", NULL, "output"},
>         {"ADC", NULL, "input"},
>         {"HPL", NULL, "HP Left Out"},
>         {"HPR", NULL, "HP Right Out"},
>         {"SPKL", NULL, "SPK Left Out"},
>         {"SPKR", NULL, "SPK Right Out"},
> };

If this is all you have for DAPM routing I just wonder what the core will do
with these... I mean you don't appear to have valid routing: no sign of
"output", "input", "HP Left Out", etc.

But it is really odd that you can not have at least some power control bits
along the paths.

This would look odd also but at least connects the widgets:
static const struct snd_soc_dapm_route sta529_audio_map[] =3D {
        {"HPL", NULL, "DAC"},
        {"HPR", NULL, "DAC"},
        {"ADC", NULL, "MIC1"},
};

Don't you have messages during boot or module loading about DAPM route erro=
r?

-- =

P=E9ter
