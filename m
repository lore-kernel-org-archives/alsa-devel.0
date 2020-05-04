Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420AEC3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 11:45:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC9B20752
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 11:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hGi3Rq9a";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Mp7rpDWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC9B20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1255E1706;
	Mon,  4 May 2020 13:44:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1255E1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588592745;
	bh=L1rzVjGXsAe85p2uvgCJHlbW21K3F8V62fTx1DuGBnk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hGi3Rq9aWett1HYz9cK4EYlGNDFiZL5+G8RceNhQAexg3Umr0xs5OsNv1nDRUOLUG
	 rlVaqTAPXRZ2ghYB7b/4feSSkWS5tPidODcV08wocCxoYF0rvBTvhp+25ZgtAFHT1c
	 j6fy8vFlOQ6qJ9giG6+fN4SvS8TFEMqnLe3n3Lts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A019BF800E5;
	Mon,  4 May 2020 13:44:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3E7FF80249; Mon,  4 May 2020 13:44:52 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C71BCF800E5
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2020 13:44:46 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BAF03A003F;
 Mon,  4 May 2020 13:44:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BAF03A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1588592685; bh=J/mc9UF/+OAAPRKpPayYkMwPS1PrhljRq9EVzFgF3JM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Mp7rpDWTYB8DAp9AAfVZPRqvkT0rsKllp4yVWxL8ToIQeZ2aDbX0GYpfd9GqbaW9G
 WUSnhe3hD+BpjXDvQ7uSjfhXsffelbc4NoM/K8MPpfHpmnL/WNGKRI87MO6H3QHE2m
 sgu360l897/4EPAUiaDWOP1FsqdF+AW5qHt+mdhA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 May 2020 13:44:41 +0200 (CEST)
Subject: Re: [PATCH v4] topology: Add topology file for generic HDA DSP
 machine driver
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200421202615.4111-1-mateusz.gorski@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a7053ec1-e5f8-bf74-23b3-677e64ee8433@perex.cz>
Date: Mon, 4 May 2020 13:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421202615.4111-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, tiwai@suse.com
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

Dne 21. 04. 20 v 22:26 Mateusz Gorski napsal(a):
> Provide conf file with topology for generic HDA DSP machine
> driver configuration. This topology is meant to be used with Intel
> Skylake SST driver.
> 
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
> 
> Changes in v4:
> - changed get and put enum ops for DMIC paths
> - removed "write" and "read_write" rights for DMIC multi-config enums
> 
>   .../hda-dsp/skl_hda_dsp_generic-tplg.conf     | 8265 +++++++++++++++++
>   1 file changed, 8265 insertions(+)
>   create mode 100644 topology/hda-dsp/skl_hda_dsp_generic-tplg.conf



Applied to the alsa-topology-conf repository. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
