From: VDR User <user.vdr@gmail.com>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Mon, 31 May 2010 13:17:53 -0700
Message-ID: <AANLkTinOXLzkeqjLfrRXKxOp4jSBf3FMVcNanHa0ya0k@mail.gmail.com>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
	<alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
	<AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
	<alpine.LNX.2.00.1005301733300.6856@eeebox2.perex-int.cz>
	<AANLkTim5L_klj1g-8hwnsftuR4x_GwESH_AOdeb4_XzT@mail.gmail.com>
	<alpine.LNX.2.00.1005312028520.5693@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 65CA5245C7
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 22:17:56 +0200 (CEST)
Received: by vws5 with SMTP id 5so2382566vws.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 13:17:54 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1005312028520.5693@eeebox2.perex-int.cz>
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

On Mon, May 31, 2010 at 11:30 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> Thanks. Could you try this patch?
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 170610e..ac3dbab 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1910,7 +1910,7 @@ static int azx_position_ok(struct azx *chip, struct
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
>
> -----

I've got a bit of a strange result.  With the above patch (and the
wallclk logging patch from your previous email), sound does not work.
However, it _does_ start working only if I `echo 29 >
/proc/asound/card1/pcm3p/xrun_debug`.  I tested these results with a
reboot in between each attempt just to make sure I'm working with a
clean boot.  I can't imagine what's causing this weird condition.  Any
ideas?

Best regards,
Derek
