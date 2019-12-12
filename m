Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A241C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:15:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B9E2073B
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vg/+LZIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B9E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 167AD1614;
	Thu, 12 Dec 2019 01:14:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 167AD1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576109745;
	bh=fZ29i+n/303R6ttIYGJU+wh/BZdDKaaYhYWFAnaQzbc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vg/+LZIGSuJPFjfj1KOtbKFrD5KH4aCjZ0D7ZHjR5qQccQP3RTGjMcuIOb3VqvkQ0
	 0JmBr0K9AruY+iHdDG/WLwOjum8O5O5NfVnxcOgdui/uvScB63dAiIP4k1FdKL7v/Q
	 XvuvFDx2FwCfEZO46daV9KPPW7KbEN6Y4oQfbuWI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9591FF8019B;
	Thu, 12 Dec 2019 01:14:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9BFBF801F4; Thu, 12 Dec 2019 01:14:52 +0100 (CET)
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D344BF800EC
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 01:14:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D344BF800EC
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1ifC7r-0000O6-5Q; Thu, 12 Dec 2019 00:14:39 +0000
Message-ID: <0e00090ef6fcf310159d6ce23f2c92f511dd01de.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, Takashi Iwai
 <tiwai@suse.com>
Date: Thu, 12 Dec 2019 00:14:38 +0000
In-Reply-To: <20191211212025.1981822-7-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
 <20191211212025.1981822-7-arnd@arndb.de>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Cc: Baolin Wang <baolin.wang@linaro.org>, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [alsa-devel] [Y2038] [PATCH v7 6/9] ALSA: Avoid using timespec
 for struct snd_timer_tread
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

On Wed, 2019-12-11 at 22:20 +0100, Arnd Bergmann wrote:
[...] 
> +static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
> +				unsigned int cmd, bool compat)
> +{
> +	int __user *p = argp;
> +	int xarg, old_tread;
> +
> +	if (tu->timeri)	/* too late */
> +		return -EBUSY;
> +	if (get_user(xarg, p))
> +		return -EFAULT;
> +
> +	old_tread = tu->tread;
> +
> +	if (!xarg)
> +		tu->tread = TREAD_FORMAT_NONE;
> +	else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
> +		 (IS_ENABLED(CONFIG_64BITS) && !compat))

This needs to check for CONFIG_64BIT not CONFIG_64BITS.

[...]
> @@ -2145,14 +2202,34 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
>  		tu->qused--;
>  		spin_unlock_irq(&tu->qlock);
>  
> -		if (tu->tread) {
> -			if (copy_to_user(buffer, &tu->tqueue[qhead],
> -					 sizeof(struct snd_timer_tread)))
> +		tread = &tu->tqueue[qhead];
> +
> +		switch (tu->tread) {
> +		case TREAD_FORMAT_TIME64:
> +			if (copy_to_user(buffer, tread,
> +					 sizeof(struct snd_timer_tread64)))
>  				err = -EFAULT;
> -		} else {
> +			break;
> +		case TREAD_FORMAT_TIME32:
> +			memset(&tread32, 0, sizeof(tread32));
> +			tread32 = (struct snd_timer_tread32) {
> +				.event = tread->event,
> +				.tstamp_sec = tread->tstamp_sec,
> +				.tstamp_sec = tread->tstamp_nsec,
> +				.val = tread->val,
> +			};
> +
> +			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
> +				err = -EFAULT;
> +			break;
> +		case TREAD_FORMAT_NONE:
>  			if (copy_to_user(buffer, &tu->queue[qhead],
>  					 sizeof(struct snd_timer_read)))
>  				err = -EFAULT;
> +			break;
> +		default:
> +			err = -ENOTSUPP;
[...]

This is not a valid error code for returning to user-space, but this
case should be impossible so I don't think it matters.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
