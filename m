Return-Path: <SRS0=S7Ib=7P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB345C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:31:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67832206A2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JmdqY7T4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CV1fSdhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67832206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6A16845;
	Tue,  2 Jun 2020 14:30:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6A16845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591101066;
	bh=BHi55n0YQoY4/VnLLIam4yvstPKeMxKk+nFqwlwEmCw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JmdqY7T4qcSB0B1yIGS8mdf4xCNEUXOPm5Ed66sa2vcLZPPfTYjb2ILtueuhUPLxD
	 EGElty3kuOU+dqwseVG0XhZoFY7rRw0z0B5f6naOI7qAM88SDXVIVzrIQzhBbaVTc/
	 U/IHcpxhzpncnqyvqh4NmXmhZGyLUeyYGAs0I/q8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26844F80260;
	Tue,  2 Jun 2020 14:30:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EED3F8026F; Tue,  2 Jun 2020 14:30:13 +0200 (CEST)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCFC4F800BC
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2020 14:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCFC4F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="CV1fSdhu"
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CMgWu171643;
 Tue, 2 Jun 2020 12:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lu3BbalZdQaF6ggOh0dU1HA0oIChyA8n999bSv8rs1I=;
 b=CV1fSdhuZ0iQ3oob4rEqjrNg24OX373xXBOPl1MYMnHZ+u9uHPq2swUHPIQeBLeslUiX
 F+0N4Tgi0js6b9BgLW0nH54Su+lgf64krT/SddzqlAK8t3jKwzgJ3wim7zt9xtrK9yZN
 AAyzcpKLqd4PWVaftAf/MOefzKXmPyIZIyX3lHNYdvIJQRfluRzzWYJuuOSCdlj1rKsk
 HSbfYeH7HxXNc1LxsBkYS/mwjhbiKdgfWsO2g8lzPJRYTU+wh5MrbvV1GFOdB6USgQf5
 4R0lFB5Vz63JGGC6H14lpzjc1j6BqiAazYj3RKg7MAgXol3sMApfg2VCZkrYnl3DI2xe Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 31dkrugt0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 02 Jun 2020 12:30:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052CHPkG125784;
 Tue, 2 Jun 2020 12:30:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 31c12p3dr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Jun 2020 12:30:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052CTo0j015127;
 Tue, 2 Jun 2020 12:29:54 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 02 Jun 2020 05:29:50 -0700
Date: Tue, 2 Jun 2020 15:29:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: Re: [RESEND PATCH v1 3/6] staging: greybus: audio: Resolve
 compilation errors for GB codec module
Message-ID: <20200602122940.GF30374@kadam>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
 <cce5aa43533d872d84be1abc514074a7705f9a54.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce5aa43533d872d84be1abc514074a7705f9a54.1591040859.git.vaibhav.sr@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020088
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alex Elder <elder@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 greybus-dev@lists.linaro.org, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, Jun 02, 2020 at 10:51:12AM +0530, Vaibhav Agarwal wrote:
> Due to dependencies on ASoC framework changes, GB dummy codec module
> compilation is currently disabled. This patch updates codec driver as
> per the latest ASoC APIs.
> 
> Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 87 +++++++++++++--------------
>  drivers/staging/greybus/audio_codec.h |  2 +-
>  2 files changed, 44 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index a2ee587e5a79..bbd072acda5c 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -832,7 +832,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
>  int gbaudio_register_module(struct gbaudio_module_info *module)
>  {
>  	int ret;
> -	struct snd_soc_codec *codec;
> +	struct snd_soc_component *component;

I quite like the "component" pointer because it's assigned once at the
start of the function and used consistently throughout.  The other
pointers I complained about were just temporary pointers which meant
different things depending on which line you were on.  They made the
code harder to read.

My only quible is that in the next patch it's called "comp" and here
it's called "component".  Let's just use "comp" for all the local
variables.


regards,
dan carpenter
