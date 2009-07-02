From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure
	the data ready bit is cleared
Date: Thu, 2 Jul 2009 15:06:17 -0400
Message-ID: <9e4733910907021206m1b5679eai31fd14afe64ace5b@mail.gmail.com>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 1754A24508
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 21:06:18 +0200 (CEST)
Received: by gxk17 with SMTP id 17so2705621gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2009 12:06:17 -0700 (PDT)
In-Reply-To: <20090702175719.15773.58956.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 2, 2009 at 1:57 PM, Grant Likely<grant.likely@secretlab.ca> wro=
te:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> When doing register reads, it is possible for there to be a stale
> data ready bit set which will cause subsequent reads to return
> prematurely with incorrect data. =A0This patch fixes the issues by
> ensuring stale data is cleared before starting another transaction.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
>
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> index 794a247..9b8503f 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -41,6 +41,10 @@ static unsigned short psc_ac97_read(struct snd_ac97 *a=
c97, unsigned short reg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 bus (rdy)\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Force clear the data valid bit */
> + =A0 =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
> +
> =A0 =A0 =A0 =A0/* Send the read */
> =A0 =A0 =A0 =A0out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0=
x7f) << 24));
>
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
