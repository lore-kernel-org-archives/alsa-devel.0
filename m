Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC16C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:37:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC72420737
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LIcsbEIM";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="wy6HnRUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC72420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 258591664;
	Thu, 26 Mar 2020 15:36:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 258591664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585233449;
	bh=VcCow2LUsM5eAvbRtQKzhPzWKU363zQVrwdoYIQxSBo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LIcsbEIM247KJqXksAp3viDmcbKMcXYhuxL6ERBljJGm/4/OpfHBa/AA1UkWZQIcQ
	 lL5lrvCVh+e/VZKHwjvJRmdvBFS/7pPMBwY1y80s6J/vDM7EuL7RXxySkJ7f77RbbP
	 5OtfSJzT70crQMkFc6D7OKSoHtd2c3IxqMPba7gg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A356F801F9;
	Thu, 26 Mar 2020 15:36:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40CE6F80227; Thu, 26 Mar 2020 15:36:36 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0439F8011E
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 15:36:27 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A9A02A003F;
 Thu, 26 Mar 2020 15:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A9A02A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1585233386; bh=qN7d4m15380FlROoT8A5QT9w0qFPUfcEgXb/Gs1p6lE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=wy6HnRUnH7mzdY1VKTqYdVDbs1Mfbmv169xwV6YyXVIv3IoegeK9hYufyE2AAYZ+Z
 8V/U/nPn2tnM+ZpGtgoGpkinHSLgAsupNk5k8ZVexnkt880mugA0uN7EPFh2GLUEcb
 ULVSbahCBIDYLpRABMJQFfIg8h61LYrdFZOgxoGA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 26 Mar 2020 15:36:23 +0100 (CET)
Subject: Re: sw_params for a direct-ed(dmix) hw pcm
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, sylvain.bertrand@gmail.com
References: <20200321155303.GB357@freedom> <20200325174419.GA1224@freedom>
 <alpine.DEB.2.21.2003261350380.2957@eliteleevi.tm.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9d986c48-184a-1d6e-4c5b-172a7ecd98a8@perex.cz>
Date: Thu, 26 Mar 2020 15:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003261350380.2957@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 26. 03. 20 v 13:02 Kai Vehmanen napsal(a):
> Hey,
> 
> On Wed, 25 Mar 2020, sylvain.bertrand@gmail.com wrote:
> 
>> On this issue, I am doing something fundamentaly wrong, but I don't see how to
>> do it right.
>>
>> While configuring a pcm, I should not use sw_params if it is a "direct-ed"
>> (direct::dmix) real hw pcm: in pcm_direct.c, snd_pcm_direct_sw_params
>> function is empty and it seems coherent with the fact the real hw pcm is
>> actually shared and was probably already configured.
> 
> how does the problem appear in your program?
> 
> Applications should just use the ALSA PCM API and not have any special
> casing for different types of PCMs (unless the differences show up via the
> public PCM API). If applications started doing plugin specifics, writing
> and deploying new ALSA plugins would become much harder and kind of defeat
> the whole purpose of the plugin API. In case of dmix, the
> pcm.c:snd_pcm_sw_params() should do the right thing and your application
> should get the cached values.

I agree. Also, the snd_pcm_direct_sw_params() does nothing, because the 
sw_params are already cached in the pcm structure (see comment). It means that 
the dmix (direct) plugins operates with those cached values. Just set 
sw_params like for any other PCM handle. The dmix uses those values (if possible).

						Jaroslav


> 
> Br, Kai
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
