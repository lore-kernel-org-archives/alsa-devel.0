Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750F5C48297
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Feb 2024 07:41:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9146850;
	Mon, 12 Feb 2024 08:41:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9146850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707723696;
	bh=UEPUmfwTzhCWgki7FMLU8n07rTkE3BfTUOwthJ67cWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=noK3sneKvVLeDkwPub5eSvZE7c9i9UR8/fRgyXu65fO+SNkSV1DIHQDSSvLxG0s/v
	 HaEqsKdp7YiHs36W69EskbnqX3JPWJ58H93yjuybOnRzEfa2wxfYVN2zmq+Qe0fTlg
	 xX01n4qhZVwiuf8EO8kbP1tlnrJuJ9F8hoSwEHvI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2329F805AC; Mon, 12 Feb 2024 08:40:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E23C2F805AA;
	Mon, 12 Feb 2024 08:40:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F906F8025A; Mon, 12 Feb 2024 08:40:49 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0EB6F800EE
	for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2024 08:40:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0EB6F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=k1ObsQp9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9B588CE0222;
	Mon, 12 Feb 2024 07:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE0EC433C7;
	Mon, 12 Feb 2024 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707723628;
	bh=UEPUmfwTzhCWgki7FMLU8n07rTkE3BfTUOwthJ67cWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1ObsQp9N2jjwaV/FwvatefdJtCLIB0BL3/uic8FkXplH130/F3aP5OM4qgp5Kkpz
	 hVef4e19PDjTyt6lZY7A1zba8MWONVKa5kRahh6XCXAt+/XoGMKFBUBrrCDNJjT1To
	 WxlhsJd0QcZ619orJYBBTSVvI7bHAGTXH+J743rY=
Date: Sun, 11 Feb 2024 21:04:18 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] Subject: [PATCH] sound: drivers: fix typo 'reguest' to
 'request'
Message-ID: <2024021133-strict-unwary-0487@gregkh>
References: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>
Message-ID-Hash: DVZKZMSXGFAFQWDPAI5DD2JRKXPEGNIH
X-Message-ID-Hash: DVZKZMSXGFAFQWDPAI5DD2JRKXPEGNIH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DVZKZMSXGFAFQWDPAI5DD2JRKXPEGNIH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Feb 12, 2024 at 02:28:46AM +0800, Yinchuan Guo wrote:
> This patch fixes a widespread spelling mistake of the word "request"
> (incorrectly spelled as "reguest") across multiple files.
> 
> Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
> ---
>  drivers/mfd/da9063-irq.c      | 2 +-
>  drivers/scsi/lpfc/lpfc_sli.c  | 2 +-
>  drivers/tty/serial/max310x.c  | 2 +-
>  drivers/tty/serial/sccnxp.c   | 2 +-

These are not sound driver changes.

And your subject line is very odd.

Please try working on drivers/staging/* code first, before branching out
into other parts of the kerneln so that you can learn how the process
works without wasting other subsystem maintainer's time with invalid
patches.

thanks,

greg k-h
