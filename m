Return-Path: <SRS0=Xi7p=LT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB4FC2B9F4
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 09:07:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8935D61429
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8935D61429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 402941662;
	Fri, 25 Jun 2021 11:06:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 402941662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624612021;
	bh=oPst9wXrB7pNSlvyTv2LWwo9ezaM2uzqpuXn8qutLjE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfceyRDXKk3Dd3VYgs+DPri24XicPcpc/OUKraeBjaVbEG141n3cITEhZApMVEDxU
	 s+rNzhHzsrRWVkHdDHehwR4NGhpA9wJZOWGZaTw1pH/VsLbkAoDoBc6Kd3UjSBggMP
	 1H2PAwi6a3azyDrDhXwJk1xXDHe3+/W+O7LYcwO0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3E52F8016D;
	Fri, 25 Jun 2021 11:06:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69A41F801D5; Fri, 25 Jun 2021 11:06:09 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04D3EF800E1
 for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2021 11:06:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04D3EF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="mAyiUL6g"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15P92VtW007281; Fri, 25 Jun 2021 09:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NZWJv2xcbxD1nxp9+aq9ApwvBM61K+hAFTVm04AAlxo=;
 b=mAyiUL6gbde5gEqazg/Bxb72lclHE1OqXwJ/cwmheyBiiB0/RN8euYX2yyNTSgGGSd96
 8TahK6dXpafdic0+TC+ynCXU2D2rnsoqtPzxY2goj5iPaxTleZDkpmeTz2a70W2mP4yM
 TlZrjIFsDjDRqqDbtkD4AM/OhHBuCfUd35SIxfYDMofE1yan4QejDbnnjtrqfnUnv/+b
 4RndWtPkBZKlP29otGhBzoALNqB3nl/6cpiMufAToCiz7QCeBCmuUN0ifW2XO+rpnC4p
 lIjs3dxRQndUGKYFZjqjvHsQWnWmHh8+17V599PPDHLQFrTcNanUsRlrzrZ6vm0lD1dN mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39d24a8wxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jun 2021 09:05:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P8xajb119590;
 Fri, 25 Jun 2021 09:05:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 39d243702m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jun 2021 09:05:58 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15P90xQ8124911;
 Fri, 25 Jun 2021 09:05:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 39d243701y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Jun 2021 09:05:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15P95l7J031960;
 Fri, 25 Jun 2021 09:05:52 GMT
Received: from kadam (/102.222.70.252) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 25 Jun 2021 02:05:46 -0700
Date: Fri, 25 Jun 2021 12:05:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, clemens@ladisch.de,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire-lib: Fix 'amdtp_domain_start()' when no
 AMDTP_OUT_STREAM stream is found
Message-ID: <20210625090538.GG2040@kadam>
References: <9c9a53a4905984a570ba5672cbab84f2027dedc1.1624560484.git.christophe.jaillet@wanadoo.fr>
 <YNTzrtrmDBdg2ec6@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTzrtrmDBdg2ec6@workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: T9AK70S8GuSoI4Tm38q7WxPBlNMpYa3r
X-Proofpoint-ORIG-GUID: T9AK70S8GuSoI4Tm38q7WxPBlNMpYa3r
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

On Fri, Jun 25, 2021 at 06:05:50AM +0900, Takashi Sakamoto wrote:
> 
> In kernel v5.10 or later, we can use 'list_entry_is_head()' macro added
> by a commit e130816164e2 ("include/linux/list.h: add a macro to test if
> entry is pointing to the head").

Someone needs to backport that all the way back...

regards,
dan carpenter

