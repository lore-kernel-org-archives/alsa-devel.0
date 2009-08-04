From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - BT and FM audio for zoom2 1/2] Add
	clock-only codec to provide McBSP clock source.
Date: Tue, 4 Aug 2009 13:38:03 +0300
Message-ID: <200908041338.03645.peter.ujfalusi@nokia.com>
References: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
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
To: alsa-devel@alsa-project.org
Cc: "patch@alsa-project.org" <patch@alsa-project.org>, "ext sean.mcneil@ti.com" <sean.mcneil@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 03 August 2009 07:29:14 ext sean.mcneil@ti.com wrote:
> From: Sean McNeil <sean.mcneil@ti.com>
>
>
> Signed-off-by: Sean McNeil <sean.mcneil@ti.com>

I'm not sure what is the rationale behind..
Can you explain what are you trying to achieve with these changes?
Also, it would be better if you split the patch to a series with smaller pa=
tches =

(and write some explanation what you are doing and why).

As Mark already pointed out, please use the latest code for basing your pat=
ches =

(see the first comment below).

Few comments:

>         0x00, /* REG_AVTXL2PGA          (0xC)   */
>         0x00, /* REG_AVTXR2PGA          (0xD)   */
>         0x01, /* REG_AUDIO_IF           (0xE)   */
> -       0x00, /* REG_VOICE_IF           (0xF)   */
> +       0x04, /* REG_VOICE_IF           (0xF)   */

The VOICE_IF:VIF_TRI_EN (and the AUDIO_IF:AIF_TRI_EN) bit has been already =
used =

in the latest code (see twl4030_set_tristate and twl4030_voice_set_tristate =

functions).

>  struct snd_soc_dai twl4030_dai[] =3D {
>  {
>         .name =3D "twl4030",
>         .playback =3D {
>                 .stream_name =3D "HiFi Playback",
> -               .channels_min =3D 2,
> +               .channels_min =3D 1,

The HiFi (Audio interface in twl terms) either supports 2 or 4 channels, it=
 does =

not support mono audio.

>                 .channels_max =3D 4,
>                 .rates =3D TWL4030_RATES | SNDRV_PCM_RATE_96000,
> -               .formats =3D TWL4030_FORMATS,},
> +               .formats =3D TWL4030_FORMATS,
> +       },
>         .capture =3D {
>                 .stream_name =3D "Capture",
> -               .channels_min =3D 2,
> +               .channels_min =3D 1,

Same here, mono is not supported by the codec.

>                 .channels_max =3D 4,
>                 .rates =3D TWL4030_RATES,
> -               .formats =3D TWL4030_FORMATS,},
> +               .formats =3D TWL4030_FORMATS,
> +       },
>         .ops =3D &twl4030_dai_ops,
>  },
>  {
> @@ -2092,17 +2356,37 @@ struct snd_soc_dai twl4030_dai[] =3D {
>         .playback =3D {
>                 .stream_name =3D "Voice Playback",
>                 .channels_min =3D 1,
> -               .channels_max =3D 1,
> +               .channels_max =3D 2,

The Voice interface only supports mono playback. Stereo is only supported o=
n the =

capture path.

>                 .rates =3D SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
> -               .formats =3D SNDRV_PCM_FMTBIT_S16_LE,},
> +               .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> +       },

-- =

P=E9ter
