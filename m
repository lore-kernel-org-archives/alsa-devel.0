From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V3 4/4] Fabric bindings for STAC9766 on the
	Efika
Date: Thu, 28 May 2009 14:58:22 -0400
Message-ID: <9e4733910905281158k4144a50bt363bc2b4faf81a23@mail.gmail.com>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013853.3073.78627.stgit@terra>
	<87eiu972ff.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E7011037F3
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 20:58:24 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so3025550qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2009 11:58:23 -0700 (PDT)
In-Reply-To: <87eiu972ff.fsf@macbook.be.48ers.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2009 at 10:00 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Jon" =3D=3D Jon Smirl <jonsmirl@gmail.com> writes:
>
> Hi,
>
> =A0Jon> Fabric bindings for STAC9766 AC97 codec on the Efika.
> =A0Jon> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> =A0Jon> ---
> =A0Jon> =A0sound/soc/fsl/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +++
> =A0Jon> =A0sound/soc/fsl/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01
> =A0Jon> =A0sound/soc/fsl/efika-audio-fabric.c | =A0 95 ++++++++++++++++++=
++++++++++++++++++
> =A0Jon> =A03 files changed, 104 insertions(+), 0 deletions(-)
> =A0Jon> =A0create mode 100644 sound/soc/fsl/efika-audio-fabric.c
>
> =A0Jon> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> =A0Jon> index 79579ae..f571c6e 100644
> =A0Jon> --- a/sound/soc/fsl/Kconfig
> =A0Jon> +++ b/sound/soc/fsl/Kconfig
> =A0Jon> @@ -47,3 +47,11 @@ config SND_MPC52xx_SOC_PCM030
> =A0Jon> =A0 help
> =A0Jon> =A0 =A0 Say Y if you want to add support for sound on the Phytec =
pcm030 baseboard.
>
> =A0Jon> +config SND_MPC52xx_SOC_EFIKA
> =A0Jon> + tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
> =A0Jon> + depends on PPC_EFIKA
> =A0Jon> + select SND_SOC_MPC5200_AC97
> =A0Jon> + select SND_SOC_STAC9766
> =A0Jon> + help
> =A0Jon> + =A0 Say Y if you want to add support for sound on the Efika.
> =A0Jon> +
>
> Wouldn't it make more sense to make this default y when it has such
> specific dependencies and is so deep down in the tree - Most efika
> users probably want to enable this if they have enabled ALSA and
> SND_SOC?

I can change it in the next round of updates. Right now I'd like to
get some people testing it and maybe doing some patches to enhance it.

For example I know he code has a problem where about 5% of the time
the codec doesn't reset right on boot. Someone needs to put an
oscilloscope on the codec chip and tell me why it is failing.

>
> --
> Bye, Peter Korsgaard
>



-- =

Jon Smirl
jonsmirl@gmail.com
