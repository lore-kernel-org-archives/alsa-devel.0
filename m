Return-Path: <SRS0=8dQ6=KP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70822C433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 08:09:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9047661059
	for <alsa-devel@archiver.kernel.org>; Thu, 20 May 2021 08:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED45D166F;
	Thu, 20 May 2021 10:09:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED45D166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621498194;
	bh=hIXxaBsMtmojjRrN4aU6p1HA3px7SdEwYtbZnXFU6KA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urT1abtsA18Yq9UH4X9PAlWeuLgrTRg1BY+5vVfCItnL2jvdjMi0GvT2yHG+VW8V7
	 bDNZBdT7vEbsUJsn5CLIVYY4sYyveDfT9ncB4ar89kF77lbrRIdn5Sk3qwUsf1CtBG
	 DUWVrE3F+K0RE64PwvqiXKGg6oh5Q205e6DG+7cI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F676F8020B;
	Thu, 20 May 2021 10:09:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7BC9F80217; Thu, 20 May 2021 10:09:01 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07B19F800C1
 for <alsa-devel@alsa-project.org>; Thu, 20 May 2021 10:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07B19F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="lZRM0yvX"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14K88FjL029921; Thu, 20 May 2021 08:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=TCqMkzDutkyaXi15pZPbSrB8zxnQY7KYHLWydr0RW9w=;
 b=lZRM0yvX1+ZALA3+i1dI+diAeuKjTMhiLr/Cuz22nf8xdW73VGk7w/PQtI54vcxaT1Ux
 8zi8FHelNqw/JqI3Jlz1jtXhTtkRN1fEP+8l8jQM7g66MP7q3iQbZEpgE4QTZb9fu+V5
 G/1rXJsEfkaxXZscYhWvZY7gMeZLNkh74lIeBxIqZQ+qtDcYHwGYc+VjDP31gwxJsYQr
 uynGenfQFdBc1BZqvtlU+mZhKCGhQ6Sny3nlfDfcDaGSu1DNyefGIMKCRYZRll3pz0G+
 5AAfjZlm7suh1DSaqseQw1WIHhkuNzIpXW4G3xJggXn+B3npJTf2eJrVMcC3azuysgPR Pg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 38n4ukrbm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 08:08:56 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14K833Z3083488;
 Thu, 20 May 2021 08:08:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 38meegs8a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 08:08:55 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14K84GZm087357;
 Thu, 20 May 2021 08:08:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 38meegs89x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 May 2021 08:08:54 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14K88mH2013906;
 Thu, 20 May 2021 08:08:48 GMT
Received: from kadam (/41.212.42.34) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 May 2021 01:08:48 -0700
Date: Thu, 20 May 2021 11:08:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: topology: Fix a small leak in
 soc_tplg_dapm_graph_elems_load()
Message-ID: <20210520080840.GE1955@kadam>
References: <YKXunAOB1DJ4dT5p@mwanda>
 <fe3d1825-aaae-0426-ad18-0e543f3fea1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe3d1825-aaae-0426-ad18-0e543f3fea1f@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: GLB8r8qiyAa9WQHSttgMHbbXz7-rQozE
X-Proofpoint-ORIG-GUID: GLB8r8qiyAa9WQHSttgMHbbXz7-rQozE
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
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

On Thu, May 20, 2021 at 09:54:42AM +0200, Amadeusz Sławiński wrote:
> On 5/20/2021 7:07 AM, Dan Carpenter wrote:
> > We have to kfree(routes) on this error path.
> > 
> > Fixes: ff9226224437 ("ASoC: topology: Change allocations to resource managed")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   sound/soc/soc-topology.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> > index 6b7a813bc264..5730fcaa7bc6 100644
> > --- a/sound/soc/soc-topology.c
> > +++ b/sound/soc/soc-topology.c
> > @@ -1135,8 +1135,10 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
> >   	 */
> >   	for (i = 0; i < count; i++) {
> >   		routes[i] = devm_kzalloc(tplg->dev, sizeof(*routes[i]), GFP_KERNEL);
> > -		if (!routes[i])
> > -			return -ENOMEM;
> > +		if (!routes[i]) {
> > +			ret = -ENOMEM;
> > +			goto free_routes;
> > +		}
> >   	}
> >   	for (i = 0; i < count; i++) {
> > @@ -1198,6 +1200,7 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
> >   	 * The memory allocated for each dapm route will be freed
> >   	 * when it is removed in remove_route().
> >   	 */
> > +free_routes:
> >   	kfree(routes);
> >   	return ret;
> > 
> 
> Yes, that's right, however looking at this function again, I wonder if
> instead we can just get rid of the routes array and kcalloc call?
> 
> Something along those lines (hope that copy paste won't mess it up):
> 

It did mess it up but I got the idea.  Yeah, that's way better.

regards,
dan carpenter

