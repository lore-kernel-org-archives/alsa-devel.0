Return-Path: <SRS0=Qxit=FX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA8C4361B
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Dec 2020 10:18:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9219A23BDE
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Dec 2020 10:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9219A23BDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CA7B1763;
	Sat, 19 Dec 2020 11:17:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CA7B1763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608373121;
	bh=YRvAz0CqpMjKMO8Ya8TCsaRFdYvlwyfNhLhYfC7Z+UQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g9LG/qMFZ3wqNzX9dodzicc+mfjeYfzEIPnO+asv4IbtgHVaMmy+kHel6D3UXV/L+
	 tMLBPOMagZcZ8YO/PBk+mQwv5AEU5Vaw4r1Dl3eL7dV5MzVanrJwNmADOyL9DU1OYh
	 clExt5FWRvQxpjHZc9fimZoC4W8ps6XX5pCFht/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97573F80259;
	Sat, 19 Dec 2020 11:17:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21EB9F80260; Sat, 19 Dec 2020 11:17:49 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0B98F8011B
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2020 11:17:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0B98F8011B
Received: from [114.253.250.41] (helo=[192.168.0.106])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kqZJ2-0004iX-LA; Sat, 19 Dec 2020 10:17:45 +0000
Subject: Re: [RFC][PATCH v2 1/1] alsa: jack: implement software jack injection
 via debugfs
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20201216114628.35739-1-hui.wang@canonical.com>
 <20201216114628.35739-2-hui.wang@canonical.com>
 <alpine.DEB.2.22.394.2012171749580.864696@eliteleevi.tm.intel.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <9ce39687-0775-e594-9c16-80cf54cb2b9a@canonical.com>
Date: Sat, 19 Dec 2020 18:17:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2012171749580.864696@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


On 12/18/20 12:45 AM, Kai Vehmanen wrote:
> Hey,
>
> I gave a quick test spin and features seems to work as advertized. A few
> minor comments on the code. If Jaroslav you think this would be ok as an
> approach, I can give a more extensive test run on this.
[snip]
> sound-core/
> ├── card0
> │   ├── HDMI!DP,pcm=10 Jack
> this combination of "!,= " characters in filenames is a bit non-unixy,
> but maybe in 2020 we are ready for this.
OK, will try to remove those characters.
>> +static void _snd_jack_report(struct snd_jack *jack, int status, bool from_inject)
>> +{
>> +	struct snd_jack_kctl *jack_kctl;
[snip]
>> +	char *tname;
>> +
>> +	/* the folder's name can't contains '/', need to replace it with '!' as lib/kobject.c does */
>> +	tname = kstrdup(jack_kctl->kctl->id.name, GFP_KERNEL);
> This goes over 100-column limit and triggers a checkpatch complaint.

Got it, will fix it.

Thanks.

>
> Br, Kai
