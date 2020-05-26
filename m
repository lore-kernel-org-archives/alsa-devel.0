Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16333C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 10:27:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C66207CB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HCbhhpOM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JT4RV0mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C66207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA179172C;
	Tue, 26 May 2020 12:26:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA179172C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590488867;
	bh=DKpU7WzLU9UwgNy4Y9je7fwjsa1rKeRAPHen4gixhls=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCbhhpOMa3gdlyLo/4BWWcmrw7V1myEs7mQFu+Wj4w0OA2xCxrLDqdfOCsHN8SLDV
	 clp+FqNkIGbmjmOGoUz8ILZMLvotQTbW89w0V7DSTRj8GaDTKj5Xh5IvSABfqI0GIZ
	 jEgvkeTcexkIMOYB0BuIazLBd9k5Q/YEZnVpq6r4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 740F1F80131;
	Tue, 26 May 2020 12:26:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB4A2F80150; Tue, 26 May 2020 12:26:54 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E3AAF80131
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 12:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E3AAF80131
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JT4RV0mM"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QAQjkT081195;
 Tue, 26 May 2020 05:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1590488805;
 bh=vdH3rMMJrkdgphKuaXQ5IO32KVwoCjnEB2v3zBfzIPM=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=JT4RV0mM/EMrnxsTPJldtOSCFBht4DucNA90MRLqYqZzuCzISqdhdxOMtmkaovCL8
 4Vh0yzIiiNLrzrC/Py7th1HPimPvMCUsHuiUo5/G84yhfi1XJiYxIY9zIdrEC/lmbe
 ZtUE2VcErU4eLYXwnaBmjdO9eSEdMJswhlYAe374=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04QAQjKx037891
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 May 2020 05:26:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 05:26:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 05:26:44 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QAQgba105108;
 Tue, 26 May 2020 05:26:42 -0500
Subject: Re: [PATCH] [v2] ASoC: ti: Fix runtime PM imbalance in
 omap2_mcbsp_set_clks_src
To: Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
References: <20200525085848.4227-1-dinghao.liu@zju.edu.cn>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <0d556082-9095-eaf6-7123-471ec09b031b@ti.com>
Date: Tue, 26 May 2020 13:27:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200525085848.4227-1-dinghao.liu@zju.edu.cn>
Content-Type: multipart/mixed; boundary="------------66CB105DE74DA43F47C7D236"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

--------------66CB105DE74DA43F47C7D236
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 25/05/2020 11.58, Dinghao Liu wrote:
> When clk_set_parent() returns an error code, a pairing
> runtime PM usage counter increment is needed to keep the
> counter balanced.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>=20
> Changelog:
>=20
> v2: - Fix this in a cleaner way.

Thanks for the update,
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/ti/omap-mcbsp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 3d41ca2238d4..d7406cc3c2a5 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -77,18 +77,15 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcb=
sp *mcbsp, u8 fck_src_id)
>  	pm_runtime_put_sync(mcbsp->dev);
> =20
>  	r =3D clk_set_parent(mcbsp->fclk, fck_src);
> -	if (r) {
> +	if (r)
>  		dev_err(mcbsp->dev, "CLKS: could not clk_set_parent() to %s\n",
>  			src);
> -		clk_put(fck_src);
> -		return r;
> -	}
> =20
>  	pm_runtime_get_sync(mcbsp->dev);
> =20
>  	clk_put(fck_src);
> =20
> -	return 0;
> +	return r;
>  }
> =20
>  static irqreturn_t omap_mcbsp_irq_handler(int irq, void *data)
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------66CB105DE74DA43F47C7D236
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFki4nsBCAD3BM+Ogt951JlaDloruEjoZk/Z+/37CjP0fY2mqLhBOzkpx95u
X1Fquf0KfVk+ZzCd25XGOZEtpZNlXfbxRr2iRWPS5RW2FeLYGvg2TTJCpSr+ugKu
OOec6KECCUotGbGhpYwBrbarJNEwDcAzPK7UJYa1rhWOmkpZJ1hXF1hUghB84q35
8DmN4sGLcsIbVdRFZ1tWFh4vGBFV9LsoDZIrnnANb6/XMX78s+tr3RG3GZBaFPl8
jO5IIv0UIGNUKaYlNVFYthjGCzOqtstHchWuK9eQkR7m1+Vc+ezh1qK0VJydIcjn
OtoMZZL7RAz13LB9vmcJjbQPnI7dJojz/M7zABEBAAG0JlBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+iQFOBBMBCAA4FiEE+dBcpRFvJjZw+uta
LCayis85LN4FAlki4nsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQLCay
is85LN4QjggAzxxxXqiWpA3vuj9yrlGLft3BeGKWqF8+RzdeRvshtNdpGeIFf+r5
AJVR71R1w89Qeb4DGXus7qsKiafdFGG7yxbuhw8a5wUm+ZncBXA+ETn3OyVtl8g8
r/ZcPX420jClBNTVuL0sSnyqDFDrt5f+uAFOIwsnHdpns174Zu9QhgYxdvdZ+jMh
Psb745O9EVeNvdfUIRdrVjb4IhJKNIzkb0Tulsz5xeCJReUYpxZU1jzEq3YZqIou
+fi+oS4wlJuSoxKKTmIXtSeEy/weStF1XHMo6vLYqzaK4FyIuclqeuYUYSVy2425
7TMXugaI+O85AEI6KW8MCcu1NucSfAWUabkBDQRZIuJ7AQgAypKq8iIugpHxWA2c
Ck6MQdPBT6cOEVK0tjeHaHAVOUPiw9Pq+ssMifdIkDdqXNZ3RLH/X2svYvd8c81C
egqshfB8nkJ5EKmQc9d7s0EwnYT8OwsoVb3c2WXnsdcKEyu2nHgyeJEUpPpMPyLc
+PWhoREifttab4sOPktepdnUbvrDK/gkjHmiG6+L2owSn637N+Apo3/eQuDajfEu
kybxK19ReRcp6dbqWSBGSeNB32c/zv1ka37bTMNVUY39Rl+/8lA/utLfrMeACHRO
FGO1BexMASKUdmlB0v9n4BaJFGrAJYAFJBNHLCDemqkU7gjaiimuHSjwuP0Wk7Ct
KQJfVQARAQABiQE2BBgBCAAgFiEE+dBcpRFvJjZw+utaLCayis85LN4FAlki4nsC
GwwACgkQLCayis85LN7kCwgAoy9r3ZQfJNOXO1q/YQfpEELHn0p8LpwliSDUS1xL
sswyxtZS8LlW8PjlTXuBLu38Vfr0vGav7oyV7TkhnKT3oBOLXanyZqwgyZSKNEGB
PB4v3Fo7YTzpfSofiwuz03uyfjTxiMGjonxSb+YxM7HBHfzjrOKKlg02fK+lWNZo
m5lXugeWD7U6JJguNdYfr+U4zYIblelUImcIE+wnR0oLzUEVDIWSpVrl/OqS3Rzo
mw8wBsHksTHrbgUnKL0SCzYc90BTeKbyjEBnVDr+dlfbxRxkB8h9RMPMdjodvXzS
Gfsa9V/k4XAsh7iX9EUVBbnmjA61ySxU/w98h96jMuteTg=3D=3D
=3DeQmw
-----END PGP PUBLIC KEY BLOCK-----

--------------66CB105DE74DA43F47C7D236--
