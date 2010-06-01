From: VDR User <user.vdr@gmail.com>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Tue, 1 Jun 2010 00:15:13 -0700
Message-ID: <AANLkTikVEROV4o8uZzSPIZO7nGZq7r1HUoFOsFw7llfm@mail.gmail.com>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
	<alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
	<AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
	<alpine.LNX.2.00.1005301733300.6856@eeebox2.perex-int.cz>
	<AANLkTim5L_klj1g-8hwnsftuR4x_GwESH_AOdeb4_XzT@mail.gmail.com>
	<alpine.LNX.2.00.1005312028520.5693@eeebox2.perex-int.cz>
	<AANLkTinOXLzkeqjLfrRXKxOp4jSBf3FMVcNanHa0ya0k@mail.gmail.com>
	<alpine.LNX.2.00.1005312241260.5693@eeebox2.perex-int.cz>
	<AANLkTimNhaaJZjWvv2t68BsF7Z3hcj4GB5PYaO2OS8is@mail.gmail.com>
	<alpine.LNX.2.00.1006010738380.5693@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D599A10397C
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 09:15:14 +0200 (CEST)
Received: by vws5 with SMTP id 5so3046642vws.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 00:15:14 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1006010738380.5693@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 31, 2010 at 10:39 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> Thanks. Here is next correction:
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 170610e..b6ba210 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1910,11 +1910,11 @@ static int azx_position_ok(struct azx *chip, stru=
ct
> azx_dev *azx_dev)
> =A0 =A0 =A0 =A0if (WARN_ONCE(!azx_dev->period_bytes,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hda-intel: zero azx_dev->peri=
od_bytes"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1; /* this shouldn't happen! */
> - =A0 =A0 =A0 if (wallclk <=3D azx_dev->period_wallclk &&
> + =A0 =A0 =A0 if (wallclk < (azx_dev->period_wallclk * 3) / 2 &&
> =A0 =A0 =A0 =A0 =A0 =A0pos % azx_dev->period_bytes > azx_dev->period_byte=
s / 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* NG - it's below the first next period b=
oundary */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return bdl_pos_adj[chip->dev_index] ? 0 : =
-1;
> - =A0 =A0 =A0 azx_dev->start_wallclk =3D wallclk;
> + =A0 =A0 =A0 azx_dev->start_wallclk +=3D wallclk;
> =A0 =A0 =A0 =A0return 1; /* OK, it's fine */
> =A0}
>

Great news!  With the previous patch and the one quoted above, sound
is now working without setting xrun_debug.  Now that the bug has been
fixed, what exactly was going wrong in the first place?

Thanks for your help Jaroslav!
-Derek
