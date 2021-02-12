Return-Path: <SRS0=tzFk=HO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D529CC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 09:58:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EC864E6C
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Feb 2021 09:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EC864E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CF8816F0;
	Fri, 12 Feb 2021 10:57:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CF8816F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613123903;
	bh=UjnIs0u3f3L4ePgi2T1ZQfD4S4Tq+hizYjfrxaamiqE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I9yANDOYqAN7mRllNcmaqUWlO+5UCLiQ72d2JYy3Vnc0cwXq1+1uTsBCKxJ+UxdXX
	 Zh80JLR+HWKaxMg9ACswtvBIZkJMIlaP5j9xsHCZhweEYJ9lE3+q573NIyJg/Okts+
	 4IOASDvx5/p5KQVSPm/B5AJEAiKhk+iGjx2FylY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 077F6F8016C;
	Fri, 12 Feb 2021 10:57:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05606F8022B; Fri, 12 Feb 2021 10:57:31 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5835F8014D
 for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2021 10:57:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5835F8014D
IronPort-SDR: NmvUL8PPAObkWu+rPKfBRD1d3ByhKydLahN9JiXgifbn14sjAmN48DjNU58nVz1WRFd848MyI0
 AE5A4YGOG2qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="201531684"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; d="scan'208";a="201531684"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 01:57:21 -0800
IronPort-SDR: 7BZmDxV1thQ9FAbREqf9on2BaL+4UH19D08FpO6h7gx58HBkHL2YpYNx9uCKbkFfL36VfNO3fD
 BeenFnc6IkjA==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; d="scan'208";a="397921048"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2021 01:57:19 -0800
Date: Fri, 12 Feb 2021 11:53:51 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: =?ISO-8859-2?Q?Amadeusz_S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: relax ABI checks and avoid unnecessary warnings
In-Reply-To: <4471ebc1-9c51-7345-12bf-74af55a6bbc2@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2102121150290.864696@eliteleevi.tm.intel.com>
References: <20210211172440.2371447-1-kai.vehmanen@linux.intel.com>
 <4471ebc1-9c51-7345-12bf-74af55a6bbc2@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.22.394.2102121150470.864696@eliteleevi.tm.intel.com>
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 daniel.baluta@nxp.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com
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

Hi,

On Fri, 12 Feb 2021, Amadeusz S³awiñski wrote:

> On 2/11/2021 6:24 PM, Kai Vehmanen wrote:
> > With recent SOF 1.7 pre-releases, kernel has been emitting following
> > warnings at probe:
> > 
> > [10006.645216] sof-audio-pci 0000:00:1f.3: warn: FW ABI is more recent than
> > kernel
> > [10006.652137] sof-audio-pci 0000:00:1f.3: warn: topology ABI is more recent
> > than kernel
[...]
> > --- a/sound/soc/sof/topology.c
> > +++ b/sound/soc/sof/topology.c
> > @@ -3658,7 +3658,7 @@ static int sof_manifest(struct snd_soc_component
> > *scomp, int index,
> >   		return -EINVAL;
> >   	}
> >   -	if (abi_version > SOF_ABI_VERSION) {
> > +	if (SOF_ABI_VERSION_MINOR(abi_version) > SOF_ABI_MINOR) {
> >   		if (!IS_ENABLED(CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS)) {
> >   			dev_warn(scomp->dev, "warn: topology ABI is more
> > recent than kernel\n");
> >   		} else {
> > 
> > base-commit: ec9d68508ff65df1dc24cf8100eb40ddd196c2fd
> > 
> 
> Shouldn't you also look at major version?
> Seems to me like with this check for example 2.1.0 compared to 3.0.0 will
> compare 1 and 0 and tell you that you have too new version. Even if 2 is less
> than 3.

ack on that. The diff is a bit hard to follow as the checks I modify here, 
in topology.c and ipc.c, are both preceded by a check with 
SOF_ABI_VERSION_INCOMPATIBLE(). If major version doens't match, we return 
an error earlier. So thus we only need to check the minor version here.

Br, Kai
