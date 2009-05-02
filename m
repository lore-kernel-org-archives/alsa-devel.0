From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: New codec for STAC9766 used on Efika
Date: Fri, 1 May 2009 23:46:48 -0400
Message-ID: <9e4733910905012046s6fc7f1cci6812f7fb6e493516@mail.gmail.com>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
	<20090501101402.GB6975@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 89C382476E
	for <alsa-devel@alsa-project.org>;
	Sat,  2 May 2009 05:46:49 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1985513qwk.56
	for <alsa-devel@alsa-project.org>; Fri, 01 May 2009 20:46:48 -0700 (PDT)
In-Reply-To: <20090501101402.GB6975@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Matt Sealey <matt@genesi-usa.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 1, 2009 at 6:14 AM, Mark Brown <broonie@sirena.org.uk> wrote:
>> =A0 =A0 =A0 .playback =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .stream_name =A0 =A0=3D "stac9766 analog",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_min =A0 =3D 1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels_max =A0 =3D 2,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rates =A0 =A0 =A0 =A0 =A0=3D SNDRV_PCM_RATE=
_8000_48000,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .formats =A0 =A0 =A0 =A0=3D SNDRV_PCM_FMTBIT=
_S32_BE,
>
> Are you sure about this? =A0AC97 generally does 16 bit samples...

AC97 can be 16, 18 or 20 bit. The link always transmits 20 bits.
This codec is a 20b version.

On the mpc5200 side you can only feed the FIFOs 32b data. "For each
AC97 slot a 32 bit data word must be in the TxFIFO"
So do I make these pair up?

static struct snd_soc_dai psc_ac97_dai_template[] =3D {
{
	.name	=3D "%s analog",
	.suspend =3D psc_ac97_suspend,
	.resume =3D psc_ac97_resume,
	.playback =3D {
		.channels_min	=3D 1,
		.channels_max	=3D 6,
		.rates		=3D SNDRV_PCM_RATE_8000_48000,
		.formats	=3D SNDRV_PCM_FMTBIT_S32_BE,
	},
	.capture =3D {
		.channels_min	=3D 1,
		.channels_max	=3D 2,
		.rates		=3D SNDRV_PCM_RATE_8000_48000,
		.formats	=3D SNDRV_PCM_FMTBIT_S32_BE,
	},
	.ops =3D &psc_ac97_analog_ops,
},
{
	.name	=3D "%s digital",
	.playback =3D {
		.channels_min	=3D 1,
		.channels_max	=3D 2,
		.rates		=3D SNDRV_PCM_RATE_32000 | \
			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
		.formats	=3D SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE,
	},
	.ops =3D &psc_ac97_digital_ops,
}};

-- =

Jon Smirl
jonsmirl@gmail.com
