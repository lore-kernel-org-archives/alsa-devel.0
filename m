From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: cs4270: add Master Playback
	Switch
Date: Mon, 27 Apr 2009 08:55:36 -0500
Message-ID: <ed82fe3e0904270655o79db933fw29ad3b0b182d5068@mail.gmail.com>
References: <20090424135216.GF10450@buzzloop.caiaq.de>
	<1240583865-14407-1-git-send-email-daniel@caiaq.de>
	<1240583865-14407-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B659103837
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 15:55:37 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4502200qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 06:55:36 -0700 (PDT)
In-Reply-To: <1240583865-14407-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 9:37 AM, Daniel Mack <daniel@caiaq.de> wrote:
> This adds a new control named 'Master Playback Switch' for cs4270
> codecs. It is implemented using the new SOC_DOUBLE_EXT macro to catch
> the put function and store the information about manually set mute
> controls from userspace. When a manual mute is set, we don't want the
> soc core to un-mute the outputs.
>
> Renamed cs4270_mute() to cs4270_dai_mute() to avoid confusion.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Mark Brown <broonie@sirena.org.uk>
> Cc: Timur Tabi <timur@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

However, ...

> @@ -486,7 +518,9 @@ static const struct snd_kcontrol_new cs4270_snd_contr=
ols[] =3D {
> =A0 =A0 =A0 =A0SOC_SINGLE("Zero Cross Switch", CS4270_TRANS, 5, 1, 0),
> =A0 =A0 =A0 =A0SOC_SINGLE("Popguard Switch", CS4270_MODE, 0, 1, 1),
> =A0 =A0 =A0 =A0SOC_SINGLE("Auto-Mute Switch", CS4270_MUTE, 5, 1, 0),
> - =A0 =A0 =A0 SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1)
> + =A0 =A0 =A0 SOC_DOUBLE("Master Capture Switch", CS4270_MUTE, 3, 4, 1, 1=
),
> + =A0 =A0 =A0 SOC_DOUBLE_EXT("Master Playback Switch", CS4270_MUTE, 0, 1,=
 1, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_soc_get_volsw, cs4270_soc_put_mute)
> =A0};

Mark, could you add a comma at the end of "cs4270_soc_put_mute)" so
that any future patches won't need to delete any lines?

-- =

Timur Tabi
Linux kernel developer at Freescale
