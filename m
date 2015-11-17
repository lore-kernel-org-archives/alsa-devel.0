From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] sound/soc/davinci: fix error case in
	mcasp_set_ctl_reg
Date: Tue, 17 Nov 2015 09:40:31 +0200
Message-ID: <564AD9EF.5060907@ti.com>
References: <20151116174026.GA1735@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id F088B260544
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 08:40:37 +0100 (CET)
In-Reply-To: <20151116174026.GA1735@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/16/2015 07:40 PM, Pavel Machek wrote:
> =

> This fixes typo in comment and fixes mcasp_set_ctl_reg to actually
> printk on error as author wanted, and cleans it up. Yes, i will end up
> being 1001 in the old code.

Yeah, the original code had the additional GBLCTL register check after the
timeout. Which was pointless IMHO.
I'm fine with the change, but...

> =

> Signed-off-by: Pavel Machek <pavel@denx.de>
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index b960e62..a739ca8 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -148,15 +150,14 @@ static void mcasp_set_ctl_reg(struct davinci_mcasp =
*mcasp, u32 ctl_reg, u32 val)
>  =

>  	mcasp_set_bits(mcasp, ctl_reg, val);
>  =

> -	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
> +	/* programming GBLCTL needs to read back from GBLCTL and verify */
>  	/* loop count is to avoid the lock-up */
> -	for (i =3D 0; i < 1000; i++) {
> +	for (i =3D 0; i <=3D 1000; i++) {

Does it really make any difference to change this from looping 1000 times to
1001 times?

>  		if ((mcasp_get_reg(mcasp, ctl_reg) & val) =3D=3D val)
> -			break;
> +			return;
>  	}
>  =

> -	if (i =3D=3D 1000 && ((mcasp_get_reg(mcasp, ctl_reg) & val) !=3D val))
> -		printk(KERN_ERR "GBLCTL write error\n");
> +	printk(KERN_ERR "GBLCTL write error\n");

Can you change this to dev_err(mcasp->dev, ...);

>  }
>  =

>  static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
> =

> =


-- =

P=E9ter
