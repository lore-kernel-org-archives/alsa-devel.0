Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF7C33CB2
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:04:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A1E20CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QfAOjUmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A1E20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B14FD1670;
	Fri, 31 Jan 2020 12:03:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B14FD1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580468686;
	bh=gGbVBmzYbe4qKPHSfaDCRY4pFW3ft8tcraE5/XyUkRA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QfAOjUmDsiYwsN2um6PNTsyjoJZcWnJW4XJc6SwQaR9Hi/pltAFoWQ+sBBlDo+E1a
	 Oq1bxk8PReGoKTeQ1SW12nxRFV4FG06JCiKL06w+U0ofVEugZ106V1U1NfTHxbZM5f
	 LB0t7TX63mZvdxDYVpuWRh++2v4SNIawazWZgKq0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DBFEF80218;
	Fri, 31 Jan 2020 12:03:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC7B3F8021E; Fri, 31 Jan 2020 12:03:54 +0100 (CET)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9880F80082
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 12:03:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9880F80082
Received: from aquila.ladisch.de (unknown [46.114.33.10])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 890ED5786012;
 Fri, 31 Jan 2020 12:03:49 +0100 (CET)
To: Ben Dooks <ben.dooks@codethink.co.uk>
References: <29db3df4-6f51-7c0f-1eef-90171f1d233a@codethink.co.uk>
 <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
 <b4a416fb-f2b1-660d-27e3-aebf602178f9@codethink.co.uk>
 <680e2dfd-6f4f-5c96-63b7-97520961dc82@gmail.com>
 <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
 <507dcd5a-672b-61ac-aa7f-af5ff01accff@codethink.co.uk>
 <a2744ea0-cf6d-d083-75e6-853746195001@gmail.com>
 <28cafc56-095b-68c6-638d-270608a2983f@codethink.co.uk>
 <3d8544be-af20-f382-85fd-32183365267b@nvidia.com>
 <1b3c2af4-510e-306c-749a-efffc994b20a@gmail.com>
 <20200128121315.GD4689@sirena.org.uk>
 <047c8caa-e715-5295-9794-67ff3e10cea2@gmail.com>
 <70f344bf-f991-606c-55ab-bdadea27d233@nvidia.com>
 <2ff97414-f0a5-7224-0e53-6cad2ed0ccd2@gmail.com>
 <35667c85-67b5-6f6f-ffe8-4fe3455ea4bb@codethink.co.uk>
 <96ed04cb-24ab-7e4d-bd44-6a4bb7c046ac@ladisch.de>
 <8161fc88-fa8c-ec92-cc14-1caa5c6f2fe7@codethink.co.uk>
 <182fd434-f15a-f049-1ba1-83bd864b4590@ladisch.de>
 <6ceb0c37867dd9ec9c5285e4470d462b@codethink.co.uk>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <dbd01efe-bada-5b20-2c5e-ccd0e8f2f5ad@ladisch.de>
Date: Fri, 31 Jan 2020 12:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6ceb0c37867dd9ec9c5285e4470d462b@codethink.co.uk>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.101.4 at webclient5
X-Virus-Status: Clean
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [alsa-devel] (no subject)
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

Ben Dooks wrote:
> On 2020-01-30 14:58, Clemens Ladisch wrote:
>> Ben Dooks wrote:
>>> On 30/01/2020 09:31, Clemens Ladisch wrote:
>>>> S24_LE:  24-bit samples in 32-bit words, aligned to the LSB
>>>> S32_LE:  24-bit samples in 32-bit words, aligned to the MSB
>>>>
>>>> It is very unlikely that your hardware implements S24_LE.
>>>
>>> Which is wrong, since this is exactly what the hardware implements.
>>>
>>> The DMA fetches 32 bit words, and then the front end dispatches only
>>> 24 bits of these to the I2S/TDM
>>
>> Which 24 bits?  Is the padding in the first byte (S32_LE) or in the
>> last byte (S24_LE)?
>
> I think the low 24 bits are sent from the 32 bit word.

This would indeed by S24_LE.  If you change the driver to say that it
supports _only_ S24_LE, is the data then played correctly?


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
