Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35417C46CD2
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Jan 2024 17:30:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2224BE98;
	Sat,  6 Jan 2024 18:30:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2224BE98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704562248;
	bh=riodbO8Et/n3rInyW9GoLSaw4bncWPVHUD+iSrOZVaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Cxd2VF/MiwJ9nO3dapnXV9D5VQoM92OonFm4R6wFAmq2VKQ3Ir6yAZyWqQTC5deO9
	 3Vfc7SKKE3zo1WUnZdhb5JZrhZePPRu/KLxRGIa3BLww2dEEFF2JOkotnP8GYba9Wu
	 gLE57bXsV1SBkesdUZmyOCv8w1dQ+XwpVkUq/wkI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21F08F8057C; Sat,  6 Jan 2024 18:30:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BA95F8058C;
	Sat,  6 Jan 2024 18:30:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8F35F804CC; Sat,  6 Jan 2024 18:30:02 +0100 (CET)
Received: from omta036.useast.a.cloudfilter.net
 (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3EF60F80496
	for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2024 18:29:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EF60F80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=embeddedor.com header.i=@embeddedor.com
 header.a=rsa-sha256 header.s=default header.b=hGTQHy+d
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id LzFzrG7w68uLRMAUWrAeV4; Sat, 06 Jan 2024 17:29:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MAUVrpbHAD6lhMAUVrJcpC; Sat, 06 Jan 2024 17:29:47 +0000
X-Authority-Analysis: v=2.4 cv=LNR1/ba9 c=1 sm=1 tr=0 ts=65998e0b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=7YfXLusrAAAA:8 a=VwQbUJbxAAAA:8 a=Xv5lit1u7inJFwG0Rj4A:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=SLz71HocmBbuEhFRYD3r:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kp3nPAn0Jw9fdBJE8vaNu80tZr2D5BJIDgFDgQoUEQY=; b=hGTQHy+dR2LgB/mfwf+U3j5CEh
	k2lZZ4G2/Ubiw82MjKPvrdgU039R6nWl9t2rDbx5vzqELlRMadSf3ZQCmxmb3+tg7DuWUF9UJoRqs
	S7H/+4Ovwmu76rrnrlcwIhHvnofT0Tp4M+7Hv17AxtifNJgIJ8GN+mwsFemkbAA4tLmW3gH0tsaVN
	3bFco1r8ElQN+fanpPvv40PBFZ4AD9PvxcjgriO4gKBQC0CM9vfHHTmWCcnSl6K1vnfzCOoqDdPt9
	S2FpaWAr5kXdgZmd41jp5lLvQiJMxNjmUg9jcuOEIhzVkX4gQfAypfqptbcLeGskGsutHXFhMjaP8
	n78pEEhg==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx
 ([187.184.157.186]:54571 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rMAUU-002YaE-1R;
	Sat, 06 Jan 2024 11:29:46 -0600
Message-ID: <ea9d5db7-6be7-4cda-85d2-6039483eabb4@embeddedor.com>
Date: Sat, 6 Jan 2024 11:29:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240106171635.19881-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240106171635.19881-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rMAUU-002YaE-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10])
 [187.184.157.186]:54571
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: 
 MS4xfE2e7Pgl/TS3JzizjvkpwbeohEA5MhiRZjINSyDzmaXtFkwYFAZ05NuKgWWPM1WETpC9r//fhdkhKIh9lohua+WFuutwTU7GLnL/N5CnXxtlup+QNEwy
 dfhdaBa+GkfSTNUEvhCl8c4ZEkAu1DJ/3GjVPP5bEpHW+/dZz3g87Aoi38tiEta7jIFQ7yHxy6/3MO4ujV6PxXWL1GVJ6HOs0qiH5Jdi7xktXqVCg19cHmXw
Message-ID-Hash: 6GBE2O2NJD3JVUFHEWDELRBKRQ4WELXS
X-Message-ID-Hash: 6GBE2O2NJD3JVUFHEWDELRBKRQ4WELXS
X-MailFrom: gustavo@embeddedor.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6GBE2O2NJD3JVUFHEWDELRBKRQ4WELXS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 1/6/24 11:16, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   sound/soc/qcom/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index 756706d5b493..747041fa7866 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -73,7 +73,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>   	link = card->dai_link;
> 
>   	for_each_available_child_of_node(dev->of_node, np) {
> -		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
> +		dlc = devm_kcalloc(dev, 2, sizeof(*dlc), GFP_KERNEL);
>   		if (!dlc) {
>   			ret = -ENOMEM;
>   			goto err_put_np;
> --
> 2.25.1
> 
> 
