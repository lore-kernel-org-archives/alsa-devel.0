Return-Path: <SRS0=I7Cd=GH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A84C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 15:21:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA4622211
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jan 2021 15:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA4622211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 312951674;
	Mon,  4 Jan 2021 16:20:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 312951674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609773697;
	bh=sl7QPMLwU90CoA161NtzEHw5VEr4bZVTKRNo6BU9a60=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=siTM/ObzTU5rHeVKLwNYxbcVn/6bwXfKZgP+lsXIc0N4qmSeOpp5bB+uC2B9Y5tni
	 DQzA0dP/7vxDXE6Zvjwp1Mz5FHsjOXHwrDGm4+YCRBLiyH+pTxVCBcthC0QAFQrrPm
	 5hDNU4rA2Uwmz70Wg+oKrLL93FWWc1pL+gJj/T3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD56BF80158;
	Mon,  4 Jan 2021 16:20:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75E15F80166; Mon,  4 Jan 2021 16:20:44 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2192F8012C
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2021 16:20:34 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 20DA3A0048;
 Mon,  4 Jan 2021 16:20:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 20DA3A0048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1609773634; bh=eq0qZuW5s/ZZeSQ94GZR5i6q1BS9RNCk6nlEElDYM5U=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=qP5tMe+aucy2QWiqfIZri2COPv0G5Rh34TM/Djo8bDp5JEIgHGuUbSYA0Lh66UhIf
 crDWoPNzb9kinoShJR2/xvUW3WRfmkGIZPKU+zUifiZ+YB38x9MmYxsCkWtrC74OMn
 ZXR7MB/laZPpqINtkhFUvzFlzAZPeRwLCXPdCjSc=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  4 Jan 2021 16:20:30 +0100 (CET)
Subject: Re: [RFC][PATCH v3 1/4] alsa: jack: implement software jack injection
 via debugfs
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de, kai.vehmanen@linux.intel.com
References: <20201228080003.19127-1-hui.wang@canonical.com>
 <20201228080003.19127-2-hui.wang@canonical.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <18eee6df-c77d-0672-2e58-7fa9a442ce40@perex.cz>
Date: Mon, 4 Jan 2021 16:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201228080003.19127-2-hui.wang@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 28. 12. 20 v 9:00 Hui Wang napsal(a):

> +static ssize_t sw_inject_enable_write(struct file *file,
> +				      const char __user *from, size_t count, loff_t *ppos)
> +{
> +	struct snd_jack_kctl *jack_kctl = file->private_data;
> +	char *buf;
> +	int ret, err;
> +	unsigned long enable;
> +
> +	buf = kzalloc(count, GFP_KERNEL);

Debugfs fops allocations should use kvzalloc() / kvfree().

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
