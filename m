From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Reg: Audio recording with twl4030 codec
Date: Fri, 22 Jan 2010 14:41:49 +0200
Message-ID: <201001221441.50022.peter.ujfalusi@nokia.com>
References: <1cbe56071001220157u5133ae91mf89dabb2f4da8fdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B374324454
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 13:42:02 +0100 (CET)
In-Reply-To: <1cbe56071001220157u5133ae91mf89dabb2f4da8fdb@mail.gmail.com>
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
Cc: ext shariff <shariffsinbox@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Friday 22 January 2010 11:57:23 ext shariff wrote:
> Hi all,
> =

>         I am working with OMAP3 based custom board that has twl4030 codec=
 &
>         using linux-2.6.29 kernel from opensource.

This is kind of old...

> =

>         I have some queries regarding Audio recording.
> =

>        Audio codec is connected to twl4030 as bellow
> =

>                                   TWL4030
> =

>                              |--------------------|
>                              |
>                              |                    |------ MAINMIC
> =

>       McBSP2  ------  |i2s/tdm         |
> =

>                              | ___________|
> =

>       --> One Analog MIC is connected to Main Mic and I am using Audio pa=
th
> not the Voice path.
> =

>            After selecting Main Mic through amixer control.
> =

>            and recording audio using "arecord -c 1 -r 8000 -f S16_LE -t w=
av
> -d 20 record-file.wav"

The hardware should have been opened in stereo mode, since it is not suppor=
ting =

the mono, you can verify it by appending -v to arecord and see how the HW h=
as =

been opened at the end.

> =

>        --> Here record is successful but with lot of noise.
> =

>           1) Can we record Mono(1 channel) through I2S from TWL4030 codec?

The TWL codec "Audio" path is either stereo or 4 channel.
You need to record stereo/4 channel, and than extract/use the data from the =

valid channel.
In case of Main mic it is the left channel, or Channel 1 or/and 2 (dependin=
g on =

the routings) in four channel mode.

> =

>           2) To record stereo(2 channels), do we need two Mic's ? (i.e do=
 I
> need Sub Mic also).

No you don't need. The right channel will not contain valid data (most like=
ly it =

is going to be silent).

You need to enable the Mic bias 1 for the main mic in your machine driver, =
if =

you have not done that yet:

static const struct snd_soc_dapm_widget your_widgets[] =3D {
...
	SND_SOC_DAPM_MIC("Your Mic", NULL),
...
};

static const struct snd_soc_dapm_route your_audio_map[] =3D {
...
	{"MAINMIC", NULL, "Mic Bias 1"},
	{"Mic Bias 1", NULL, "Your Mic"},
...
};

I'm not sure about the state of the twl soc codec driver in 2.6.29, but my =
guess =

is that it should work.

Are there any capture routing option for TX1 path, which selects between An=
alog =

and Digimic0? If there is than that has to be set to analog as well.

> =

> Regards,
> Shariff

-- =

P=E9ter
