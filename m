Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CFC64E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:05:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE6F2085B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="haEuhCCB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="ONa+YRUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5DCE16D2;
	Tue,  1 Dec 2020 09:04:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5DCE16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606809915;
	bh=lniwxISatJF+S9Xbuf8TAltr+GjgHXKWLfK5Kkbj4KU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=haEuhCCB1/ZOcFAdgbv+NcejbC6nIyBhyfroTETdwgYlvRL+0m8znG0hcDEMQaKkG
	 Ls+m/Ioy6y2Fss2yveaJA/oolFRvA/V/ymvD4iOHsnP8Ax0+ErJ82eJXU7HLghTQOt
	 mgwCIdmVbgCfFZLUthWuEJMf1lIJfcPOuyg+Cvoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D551F8016C;
	Tue,  1 Dec 2020 09:04:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1AD7F80158; Tue,  1 Dec 2020 09:04:23 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7D9CF80158
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 09:04:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7D9CF80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="ONa+YRUM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lniwxISatJF+S9Xbuf8TAltr+GjgHXKWLfK5Kkbj4KU=; b=ONa+YRUMJj05Xzc+SiVtB8ZYQG
 A7pNP6l6z0sKPZuclQ4Zku0pJXE5qgnx717tmXNEPwdDgj6FSAhLEVBsSSBAV9Xns4ZZ6gaF7xl/3
 rvaSboBHLCKEa/Qc404Oak+u8/T8nZveSodpzcj6TrCvH+WGR/Qsd7m0+qX6N5LD+2fW6qZRpnWb2
 SREfljoAiHEs+ymJtRpmaCKWqjVcNvyV2QVcH7tQXI7pQeNTnsRYv56gIQshPqQm/hxyVzBVBT9HM
 e0b7GBDuDkEHULUIVCrx8lVlQSYhfqX+vbTMbRGTM9OffsePu2EJE2BwsaavvWEZnXCGH0E2MNzcd
 /eX3CTGQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1kk0dy-0000hH-OX; Tue, 01 Dec 2020 09:04:14 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
 by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1kk0dy-000XVE-KI; Tue, 01 Dec 2020 09:04:14 +0100
Subject: Re: [PATCH] ASoC: adau1372: Add missing KConfig dependencies
To: Mark Brown <broonie@kernel.org>
References: <20201201075435.29909-1-lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7fe9edc1-eac9-aede-9480-dc0ca1f0dcc1@metafoo.de>
Date: Tue, 1 Dec 2020 09:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201075435.29909-1-lars@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26004/Mon Nov 30 15:29:06 2020)
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>
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

On 12/1/20 8:54 AM, Lars-Peter Clausen wrote:
> The I2C and SPI version of the adau1372 driver respectively depend on the
> I2C and SPI framework being enabled. Otherwise compile or linker errors
> will occur when building the driver.
>
> Add the proper Kconfig dependencies to ensure that the drivers are only
> selectable if the required framework is enabled.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Ah, just saw Alexandre was faster. Please ignore this one.


