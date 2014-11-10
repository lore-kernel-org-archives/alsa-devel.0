From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinvi-mcasp: Balance
 pm_runtime_enable() on probe failure
Date: Mon, 10 Nov 2014 14:53:29 +0200
Message-ID: <5460B549.40203@ti.com>
References: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id AD6FA2606BD
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 13:53:37 +0100 (CET)
In-Reply-To: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anil Kumar <anilk4.v@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: tiwai@suse.de, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11/09/2014 02:45 PM, Anil Kumar wrote:
> If probe fails then we need to call pm_runtime_disable() to balance
> out the previous pm_runtime_enable() call.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
> ---
> :100644 100644 0eed9b1... 99c747d... M	sound/soc/davinci/davinci-mcasp.c
>  sound/soc/davinci/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index 0eed9b1..99c747d 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1235,6 +1235,7 @@ static int davinci_mcasp_probe(struct platform_devi=
ce *pdev)
>  	ret =3D pm_runtime_get_sync(&pdev->dev);
>  	if (IS_ERR_VALUE(ret)) {
>  		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
>  	}
>  =

> =



-- =

P=E9ter
