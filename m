Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDABC5478C
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:34:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F360A4A;
	Fri, 23 Feb 2024 07:34:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F360A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708670060;
	bh=dThcPl3XK7RY5dgaObaEGYKBmy4AdP7HURVc8OjMtqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KOM8q1TC7JJEhzyQwEaoTxPEXgqeydY5PaFHdkSFdaQZNBzikf8Uxjodg93/+9dFi
	 oJbbZDkD7Y4yomRCaZ8b+KGVCC3u+0L8RbrJWiwl9BpPV4i4F72hIhuXd8lrRmwb0t
	 LEIDHrG1tTSx1smdRTo2LVlb0XD66m/5V9fTNP74=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14D28F805A1; Fri, 23 Feb 2024 07:33:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7354F80568;
	Fri, 23 Feb 2024 07:33:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B08BF80496; Fri, 23 Feb 2024 07:33:39 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98E98F800ED
	for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2024 07:33:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98E98F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=bbGXLkDp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7DC1A61715;
	Fri, 23 Feb 2024 06:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D37C433C7;
	Fri, 23 Feb 2024 06:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708670006;
	bh=dThcPl3XK7RY5dgaObaEGYKBmy4AdP7HURVc8OjMtqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbGXLkDp5iFFUzcPFhjNZZZda8EkIIp350je1FEuGhT5XE9PiyT3g+NZVCSI4OQlr
	 BXX4mdQwq6AsXhyKzVQIGo1aw0RDEUt2j1Y+Kla2HPDX1pizKfWy/4sdcbYlIIBe3+
	 4dkOcnvQXydNa9kd53NyHNIzLFoUnBVnHjU20F2c=
Date: Fri, 23 Feb 2024 07:33:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Marc Herbert <marc.herbert@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/3] sysfs: Group visibility fixups
Message-ID: <2024022342-unbroken-september-e58d@gregkh>
References: 
 <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
Message-ID-Hash: IPK4CCOT5WDVWW4YDD2JKRLK3Z3HERVH
X-Message-ID-Hash: IPK4CCOT5WDVWW4YDD2JKRLK3Z3HERVH
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPK4CCOT5WDVWW4YDD2JKRLK3Z3HERVH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Feb 22, 2024 at 12:40:48PM -0800, Dan Williams wrote:
> Hey Greg,
> 
> Marc was able to get me a backtrace for that bootup hang scenario that
> Pierre noted here [1]. A Tested-by is still pending, but I am certain
> this is the issue, and it may impact more than just the one platform if
> that "empty_attrs" pattern has been repeated anywhere else in the
> kernel.
> 
> I also took some time to document how to use the helpers a bit better,
> and introduce DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() for cases where all
> that matters is group visibility and not per attribute visibility.
> 
> [1]: http://lore.kernel.org/r/b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com

I'll just queue these up now on my normal driver-core-next branch, and
not worry about a stable tag as I doubt anyone wants that now.  But if
they do, please let me know and I can provide one.

thanks for the quick fixes!

greg k-h
