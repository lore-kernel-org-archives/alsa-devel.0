From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: Re: [PATCH] Fix compile error in sound/soc/mid-x86/sst_platform.c
Date: Thu, 15 Dec 2011 23:16:52 +0600
Message-ID: <CADZ9YHi4XX4gzPvbqxBndgNGoMMNzdQH9DqjC4fT7bKRpxjcXQ@mail.gmail.com>
References: <20111215165248.GG2112@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111215165248.GG2112@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 15, 2011 at 10:52 PM, Joerg Roedel <joerg.roedel@amd.com> w=
rote:
> (again with mailing lists on Cc, sorry)
>
> Hi,
>
> I tested current linux-next against my iommu-configs and found a comp=
ile
> error in sound/soc/mid-x86/sst_platform.c. The variable ret_val in th=
e
> sst_platform_open() function is used but not declared. Attached patch
> fixes this.
>

While fixing any kind of error/warning, it's nice to have
error/warning message in changelog.

Thanks,
Rakib

> From d4e6d3b9ff8084c02eaf50e8212f77bcde5dec9d Mon Sep 17 00:00:00 200=
1
> From: Joerg Roedel <joerg.roedel@amd.com>
> Date: Thu, 15 Dec 2011 17:39:31 +0100
> Subject: [PATCH] Fix compile error in sound/soc/mid-x86/sst_platform.=
c
>
> The variable ret_val is used but not declared. Fix this.
>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
> =A0sound/soc/mid-x86/sst_platform.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst=
_platform.c
> index 24f9471..11c39c5 100644
> --- a/sound/soc/mid-x86/sst_platform.c
> +++ b/sound/soc/mid-x86/sst_platform.c
> @@ -267,6 +267,7 @@ static int sst_platform_open(struct snd_pcm_subst=
ream *substream)
> =A0{
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime =3D substream->runtime=
;
> =A0 =A0 =A0 =A0struct sst_runtime_stream *stream;
> + =A0 =A0 =A0 int ret_val;
>
> =A0 =A0 =A0 =A0pr_debug("sst_platform_open called\n");
>
> --
> 1.7.5.4
>
> --
> AMD Operating System Research Center
>
> Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
> General Managers: Alberto Bozzo, Andrew Bowd
> Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB N=
r. 43632
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
