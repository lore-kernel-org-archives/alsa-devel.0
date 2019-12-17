Return-Path: <SRS0=Cvq+=2H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20905C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:18:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F62A2146E
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PkULKcpe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrqWdS5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F62A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6346B850;
	Tue, 17 Dec 2019 16:17:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6346B850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576595887;
	bh=QWsmTmqhght41QqM7EiPh00j8hVjPFBNXGWmE3EgWQA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PkULKcpebAsFZf5kf+M8xY527KiMNfm1mwKjqCVvqrzMUaDO9sKlSNhkS7HfsluMD
	 hx8GSbEwiZ0++S4I6HxYhcA1cG/QjJtOx9IXExPKkRzzShSGZQodGVFD3kjCjhGS48
	 t/ZSVjxAdXbZJfcHARlKFZA6KJN1mFKDSw4gdsK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1CF1F80218;
	Tue, 17 Dec 2019 16:17:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7C73F80234; Tue, 17 Dec 2019 16:17:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AFE9F8020B
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2019 16:17:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AFE9F8020B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hrqWdS5v"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6809E2146E;
 Tue, 17 Dec 2019 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576595828;
 bh=il1CvCc9YvCKbEZZGWzWIzWhs7dSJR3F9V+6YYPouT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrqWdS5vHLlXxM/XFKetJ7/abKxVz1BiJLGP3Lp/LrbG8dvDVbo6G4lp/c2EsGhjw
 1+5jAyMfIwd0oPbC3UJYEa9sR4HEzzk4Ss88c0ZzN+ixABvoDIWSTU6F+2p0A1gECT
 FznJoURH/gUoIQE+dYmC8ChHNoYTeTd9bWZNZfH8=
Date: Tue, 17 Dec 2019 16:17:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Chang <richtek.jeff.chang@gmail.com>
Message-ID: <20191217151706.GA3654493@kroah.com>
References: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, jeff_chang@richtek.com, broonie@kernel.org,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp
	Driver
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

On Thu, Dec 12, 2019 at 07:08:54PM +0800, Jeff Chang wrote:
ookup("ext_dev_io", NULL);
> +	if (!d->rt_root) {
> +		d->rt_root = debugfs_create_dir("ext_dev_io", NULL);
> +		if (!d->rt_root)
> +			return -ENODEV;

No need to ever check the result of this function

> +		d->rt_dir_create = true;
> +	}
> +	d->ic_root = debugfs_create_dir(di->dirname, d->rt_root);
> +	if (!d->ic_root)
> +		goto err_cleanup_rt;

Same here.

> +	if (!debugfs_create_u16("reg", 0644, d->ic_root, &d->reg))
> +		goto err_cleanup_ic;

No need to ever check any result of any debugfs_create_* function.  In
fact, this function doesn't even return a value anymore, so if you tried
to build this against Linus's latest tree, it wouldn't work :)

thanks,

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
