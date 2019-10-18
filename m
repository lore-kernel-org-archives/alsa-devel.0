Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CDCA9EA1
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:40:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF14222C3
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E4lu5Z6P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kmRTjgAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF14222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3254D852;
	Fri, 18 Oct 2019 12:39:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3254D852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571395225;
	bh=53OymNLmzIBL7uHRLy7zB9cx7bYRTMRghAsrjXjzJ7A=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E4lu5Z6P0F/fJhS1NZevW9mRvIx4exHdBspghglcA0EIrmCylCOgf4ibSbaEMFPPp
	 RQfKj9M8AygbInvHMCiSLgX71Wd1SahgxNQLmcILDgR4oPVvR3xHqQ6KoblSXxBsQ0
	 CtoI6M271jdgiBFMxnuzsNfN8/DzSSDtrud5bO2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C60DF80323;
	Fri, 18 Oct 2019 12:39:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2853F80362; Fri, 18 Oct 2019 12:39:32 +0200 (CEST)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9F4FF80322
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 12:39:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9F4FF80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="kmRTjgAm"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IAT9xc116999;
 Fri, 18 Oct 2019 10:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=b5MDK6LGdR/GvXJdv3nsIYA0QaZR8UpEYG+YaAb1gEQ=;
 b=kmRTjgAm/M89Z8JJfa9qP6DMYq0mcY9WlnvYpBrBZ+6CSxiaBOrMOf/w0aZt8Ccnty8a
 OShGbWInr9JnPEz1//uQLaXMFJ7rtqBBZSK3WIzQaCksehn9Avn/tLGIDE7GoGx+0w+O
 MqVMqOKMz9rpmhvsNN5f937eHzAfy468GTu+LH58iFSbBcO4EK0xSv2otw5GgauuUrWG
 8s/Sivy//zNLvy5CTYGD5HryBjS8gLOsYC++gt0wjJSL58cU8hVXgGDcA0jVhaZ2iG63
 f2UcPUTK1CPPoY6keZ7Ergv2uuykqsp6qwp+sH1TeiKo+qYEXffRHZUa5nR+eDVWdo5P WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2vq0q431ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2019 10:39:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IATY33094868;
 Fri, 18 Oct 2019 10:39:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2vq0ew2y2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2019 10:39:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IAdK63006116;
 Fri, 18 Oct 2019 10:39:21 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 18 Oct 2019 10:39:20 +0000
Date: Fri, 18 Oct 2019 13:39:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Message-ID: <20191018103910.GL21344@kadam>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1571432760-3008-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180102
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Sanju R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com,
 Colin Ian King <colin.king@canonical.com>
Subject: Re: [alsa-devel] [PATCH 6/7] ASoC: amd: ACP powergating should be
 done by controller
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sat, Oct 19, 2019 at 02:35:44AM +0530, Ravulapati Vishnu vardhan rao wrote:
> diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
> index 7f435b3..b74ecf6 100644
> --- a/sound/soc/amd/raven/pci-acp3x.c
> +++ b/sound/soc/amd/raven/pci-acp3x.c
> @@ -19,11 +19,140 @@ struct acp3x_dev_data {
>  	struct platform_device *pdev[ACP3x_DEVS];
>  };
>  
> +static int acp3x_power_on(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +	if (val) {

Just flip this around.

	if (val == 0)
		return 0;

> +		if (!((val & ACP_PGFSM_STATUS_MASK) ==
> +				ACP_POWER_ON_IN_PROGRESS))
> +			rv_writel(ACP_PGFSM_CNTL_POWER_ON_MASK,
> +				acp3x_base + mmACP_PGFSM_CONTROL);
> +		while (true) {

while (++timeout < 500) {


> +			val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +			if (!val)
> +				break;

return 0;

> +			udelay(1);
> +			if (timeout > 500) {
> +				pr_err("ACP is Not Powered ON\n");
> +				ret = -ETIMEDOUT;
> +				break;
> +			}
> +			timeout++;
> +		}
> +		if (ret) {
> +			pr_err("ACP is not powered on status:%d\n", ret);

Just one error message is enough.

	pr_err("ACP is Not Powered ON\n");
	return -ETIMEDOUT;


> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int acp3x_power_off(void __iomem *acp3x_base)
> +{
> +	u32 val;
> +	u32 timeout = 0;
> +	int ret = 0;
> +
> +	val = rv_readl(acp3x_base + mmACP_PGFSM_CONTROL);

val is not used.  We want to turn on set but not used warnings
eventually.

> +	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
> +			acp3x_base + mmACP_PGFSM_CONTROL);
> +	while (true) {
> +		val  = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
> +		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
> +			break;
> +		udelay(1);
> +		if (timeout > 500) {
> +			pr_err("ACP is Not Powered OFF\n");
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +		timeout++;
> +	}
> +	if (ret)
> +		pr_err("ACP is not powered off status:%d\n", ret);
> +	return ret;

Same as above.

> +}
> +
> +
> +static int acp3x_reset(void __iomem *acp3x_base)
> +{
> +	u32 val, timeout;
> +
> +	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (true) {

	while (++timeout < 100) {

> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
> +		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
> +							timeout > 100) {
> +			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
> +				break;


Duplicated needlessly.

> +			return -ENODEV;
> +		}
> +		timeout++;
> +		cpu_relax();
> +	}


	if (timeout == 100)
		return -ENODEV;

> +	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
> +	timeout = 0;
> +	while (true) {
> +		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);

Split the "if (!val) break;" into it's own condition instead of part of
the ||.

> +		if (!val || timeout > 100) {
> +			if (!val)
> +				break;
> +			return -ENODEV;
> +		}
> +		timeout++;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_init(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* power on */
> +	ret = acp3x_power_on(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power on failed\n");
> +		return ret;
> +	}
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int acp3x_deinit(void __iomem *acp3x_base)
> +{
> +	int ret;
> +
> +	/* Reset */
> +	ret = acp3x_reset(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x reset failed\n");
> +		return ret;
> +	}
> +	/* power off */
> +	ret = acp3x_power_off(acp3x_base);
> +	if (ret) {
> +		pr_err("ACP3x power off failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>  static int snd_acp3x_probe(struct pci_dev *pci,
>  			   const struct pci_device_id *pci_id)
>  {
>  	int ret;
> -	u32 addr, val, i;
> +	u32 addr, val, i, status;
>  	struct acp3x_dev_data *adata;
>  	struct platform_device_info pdevinfo[ACP3x_DEVS];
>  	unsigned int irqflags;
> @@ -63,6 +192,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	}
>  	pci_set_master(pci);
>  	pci_set_drvdata(pci, adata);
> +	status = acp3x_init(adata->acp3x_base);
> +	if (status)
> +		return -ENODEV;

Why do we need both "status" and "ret".  Preserve the error code?

> +
>  
>  	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
>  	switch (val) {
> @@ -132,6 +265,11 @@ static int snd_acp3x_probe(struct pci_dev *pci,
>  	return 0;
>  
>  unmap_mmio:
> +	status = acp3x_deinit(adata->acp3x_base);
> +	if (status)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>  	for (i = 0 ; i < ACP3x_DEVS ; i++)
>  		platform_device_unregister(adata->pdev[i]);
>  	kfree(adata->res);
> @@ -153,6 +291,11 @@ static void snd_acp3x_remove(struct pci_dev *pci)
>  		for (i = 0 ; i <  ACP3x_DEVS ; i++)
>  			platform_device_unregister(adata->pdev[i]);
>  	}
> +	i = acp3x_deinit(adata->acp3x_base);

Please don't re-use "i" like this.  Declare "ret" or "status" or
something.

> +	if (i)
> +		dev_err(&pci->dev, "ACP de-init failed\n");
> +	else
> +		dev_info(&pci->dev, "ACP de-initialized\n");
>  	iounmap(adata->acp3x_base);
>  
>  	pci_disable_msi(pci);

regards,
dan carpenter

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
