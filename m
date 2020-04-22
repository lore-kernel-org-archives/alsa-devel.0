Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A68C54FCB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:05:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441620776
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cm1eP56L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="jeUmwDU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3A73169D;
	Wed, 22 Apr 2020 19:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3A73169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587575145;
	bh=BH8tpbpe981/e0pANkwZtQltucd09KtWoHay2+u8+iI=;
	h=From:Subject:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cm1eP56LRND8FJPjRNNMcA7z8oeP72ZIF41H0mDwLbZbJiJWpnXLGM4xMchHs1sdW
	 NBnLOL73brlERfXlSpD+4nF0yWH96CCX6a8v5GmPZo6F+D99nHrR49xGxLv7mzft/e
	 RtTM2Pk9MTk1PMQ2vzWgZvzjvlgbuPPgrd3Ks4ag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 525B8F80142;
	Wed, 22 Apr 2020 19:04:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE86FF801D9; Wed, 22 Apr 2020 19:04:50 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A203EF80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 19:04:43 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CA56FA003F;
 Wed, 22 Apr 2020 19:04:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CA56FA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1587575081; bh=/R1VvLAqQHPrpWwdJMq8nH56YnfP3SEUEtkNev9MYy8=;
 h=From:Subject:To:Cc:Date:From;
 b=jeUmwDU6kYtjs0becdQug3xHsWiU20eWa0EDHG+Zs5ps6b0I134//RtJ9OQs9inT2
 jgqnQQJqKHeXsTKHP/qbG8jSCw6eNif7sW0Auzpx54+hG1xWOx/HQ+fd/Zfb2VTMID
 F8jV5ENVy0AyHTOnwOEFL7hKcZOTyWjpoj9+uwps=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 22 Apr 2020 19:04:36 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
Subject: ASoC driver names
To: Mark Brown <broonie@kernel.org>
Message-ID: <c57f21dc-412d-3057-6150-b96d96a20727@perex.cz>
Date: Wed, 22 Apr 2020 19:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Hi all,

   I am fighting actually with the ASoC driver names. The current situation, 
where each hardware variant (card name) is mapped to the driver name is not 
very practical (and not correct). The driver name should describe the common 
part (usually the controller - like 'HDA-Intel' or bus 'USB-Audio').

   I am talking about the situation, where the ASoC card name is set via the 
device tree (snd_soc_of_parse_card_name) like in [1], but the change may be 
considered for other drivers like Intel SST:

Card driver name: Lenovo-YOGA-C63
Card name: Lenovo-YOGA-C630-13Q50
Card long name: LENOVO-81JL-LenovoYOGAC630_13Q50-LNVNB161216

[1] 
https://github.com/alsa-project/alsa-tests/pull/3/commits/1b5a552cff06c6039fbcf41b3117fc73712010df

   My question is, can we change / add the more apropriate driver names 
conditionally with a new kernel CONFIG option? Will you accept this change?

   The goal is to group the related UCM2 configurations and do the required 
split inside the UCM2 top-level configuration file based on card components 
string or other card identificators (related to the driver).

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
