Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB4CC43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:55:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81240206B5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jfGQ9PJ8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAijrfA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81240206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19EE0173C;
	Tue,  8 Sep 2020 13:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19EE0173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599566157;
	bh=MLbB+MGwr/r5a0jx3JnLPatiU4On+aPxTZ/schrAPb8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jfGQ9PJ8+WYj9EeNbJGuvihQ4isQyUpnELaeRN/dnPYbQ4fUney92/6Pnz37KGcjc
	 ZPMmW8UlCPB9RlpQy5BDmQRxF32bcviR/+yld6ggUO2aYjPjqOR4cQyZjnYK5ZGoNo
	 AIE6m0VtDbfP4xaMIR8W//1vIrUi9JkIefEDHM4Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 957E3F801F2;
	Tue,  8 Sep 2020 13:55:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C20C4F80264; Tue,  8 Sep 2020 13:55:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FB94F8015F
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 13:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB94F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JAijrfA7"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A67B72067C;
 Tue,  8 Sep 2020 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599566094;
 bh=MLbB+MGwr/r5a0jx3JnLPatiU4On+aPxTZ/schrAPb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JAijrfA70TLd2SlHXaPJ7sJAG2b3/itt6wTJkQ9xzFwtj9xstl1hwVKhAvEnYhTXX
 nT6c2aribxoYEyWLw2ee+agJ+24B1WaYjoa7se3qUTwLH8zr9WxA6oA8Y7Vnmd5KOH
 IFHKJKT4NpDrV3A4iWY4YidN6r/Se+41BPyNMr84=
Date: Tue, 8 Sep 2020 13:55:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] Revert "ALSA: hda: Add support for Loongson 7A1000
 controller"
Message-ID: <20200908115506.GA1624115@kroah.com>
References: <1598348388-2518-1-git-send-email-yangtiezhu@loongson.cn>
 <s5hsgcb59gw.wl-tiwai@suse.de>
 <CAAhV-H5V5adhY2OjJLxW7x3zDaHGgBxxy45hjf22+qMSEBQuww@mail.gmail.com>
 <bf50515b-a018-a66d-188a-4901428e66a6@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf50515b-a018-a66d-188a-4901428e66a6@loongson.cn>
Cc: alsa-devel@alsa-project.org, Huacai Chen <chenhuacai@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Takashi Iwai <tiwai@suse.de>,
 Xuefeng Li <lixuefeng@loongson.cn>
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

On Tue, Sep 08, 2020 at 11:09:31AM +0800, Tiezhu Yang wrote:
> On 09/08/2020 08:37 AM, Huacai Chen wrote:
> > Hi, all
> > 
> > This patch should be backported to 5.4.
> 
> Hi,
> 
> Commit 61eee4a7fc40 ("ALSA: hda: Add support for Loongson
> 7A1000 controller") has been not yet merged into 5.4, so no
> need to backport.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/pci/hda/hda_intel.c?h=v5.4

It showed up in 5.4.62, so yes, it does need to go there.

thanks,

greg k-h
