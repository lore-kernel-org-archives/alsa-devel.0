From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: Madera codecs: add missing of table
	registration
Date: Mon, 29 Apr 2019 17:11:05 +0100
Message-ID: <20190429161105.GE81578@ediswmail.ad.cirrus.com>
References: <1555960430-8899-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79E91F80641
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 18:11:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1555960430-8899-1-git-send-email-dagmcr@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Gomez <dagmcr@gmail.com>
Cc: patches@opensource.cirrus.com, rf@opensource.cirrus.com, javier@dowhile0.org, lee.jones@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 09:13:50PM +0200, Daniel Gomez wrote:
> MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
> OF mathing mechanism and register it.
> 
> Before this patch:
> modinfo drivers/mfd/madera-spi.ko  | grep alias
> alias:          spi:wm1840
> alias:          spi:cs47l91
> alias:          spi:cs47l90
> alias:          spi:cs47l85
> alias:          spi:cs47l35
> 
> After this patch:
> modinfo drivers/mfd/madera-spi.ko  | grep alias
> alias:          spi:wm1840
> alias:          spi:cs47l91
> alias:          spi:cs47l90
> alias:          spi:cs47l85
> alias:          spi:cs47l35
> alias:          of:N*T*Ccirrus,wm1840C*
> alias:          of:N*T*Ccirrus,wm1840
> alias:          of:N*T*Ccirrus,cs47l91C*
> alias:          of:N*T*Ccirrus,cs47l91
> alias:          of:N*T*Ccirrus,cs47l90C*
> alias:          of:N*T*Ccirrus,cs47l90
> alias:          of:N*T*Ccirrus,cs47l85C*
> alias:          of:N*T*Ccirrus,cs47l85
> alias:          of:N*T*Ccirrus,cs47l35C*
> alias:          of:N*T*Ccirrus,cs47l35
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/mfd/madera-spi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
> index 4c398b2..1128584 100644
> --- a/drivers/mfd/madera-spi.c
> +++ b/drivers/mfd/madera-spi.c
> @@ -121,6 +121,16 @@ static const struct spi_device_id madera_spi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, madera_spi_ids);
>  
> +const struct of_device_id madera_of_match[] = {
> +	{ .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
> +	{ .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
> +	{ .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
> +	{ .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
> +	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, madera_of_match);
> +

This is definitely an oversight but it would be worth
looking into if it is possible to use the existing table in
madera-core.c rather than adding new tables. The I2C will also
need fixed so it would be best to share.

Thanks,
Charles

>  static struct spi_driver madera_spi_driver = {
>  	.driver = {
>  		.name	= "madera",
> -- 
> 2.7.4
> 
