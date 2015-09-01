From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Tue, 1 Sep 2015 09:20:31 +0200
Message-ID: <55E551BF.9000304@invoxia.com>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F25C2261AE4
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 09:20:32 +0200 (CEST)
Received: by wicmc4 with SMTP id mc4so22306464wic.0
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2015 00:20:33 -0700 (PDT)
In-Reply-To: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, albertchen@realtek.com, broonie@kernel.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


So, this example is a "normal" FSYNC, "normal" BCLK, DSP-B mode, 16 =

bits/sample, isn't it (just to have something visual).
regards,
arnaud

--+  +--+  +--+  +--+  +--+  +--+  +--+  +--
   |  |  |  |  |  |  |  |  |  |  |  |  |  |    ...
   +--+  +--+  +--+  +--+  +--+  +--+  +--+

               +-----+
               |     |
--------------+     +------------------------ ...

   | b1  | b0  | b15 | b14 | b13 | b12 | b11 | ...

--frame N-1--> <----- frame N ---------


Le 31/08/2015 22:50, Anatol Pomozov a =E9crit :
> Per discussion at [1] currently there is no clear definition of what is F=
SYNC polarity.
> Different drivers use its own definition of what is "normal" and what is =
"inverted"
> fsync in different modes. This leads to compatibility problems between dr=
ivers.
>
> Explicitly specify meaning of BCLK/FSYNC polarity.
>
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/0971=
21.html
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>   include/sound/soc-dai.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 2df96b1..c8170c4 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -48,10 +48,15 @@ struct snd_compr_stream;
>   #define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
>   =

>   /*
> - * DAI hardware signal inversions.
> + * DAI hardware signal polarity.
>    *
> - * Specifies whether the DAI can also support inverted clocks for the sp=
ecified
> - * format.
> + * For BCLK:
> + *  - "normal" polarity means signal sensing happens at rising edge of B=
CLK
> + *  - "inverted" polarity means signal sensing happens at falling edge o=
f BCLK
> + *
> + * For FSYNC:
> + *  - "normal" polarity means frame starts at rising edge of FSYNC
> + *  - "inverted" polarity means frame starts at falling edge of FSYNC
>    */
>   #define SND_SOC_DAIFMT_NB_NF		(0 << 8) /* normal bit clock + frame */
>   #define SND_SOC_DAIFMT_NB_IF		(2 << 8) /* normal BCLK + inv FRM */
