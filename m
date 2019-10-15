Return-Path: <SRS0=gwzj=YI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C6ECE588
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:46:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F47E2089C
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k3XuYCAj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyUD/4NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F47E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 515F184C;
	Tue, 15 Oct 2019 12:45:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 515F184C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571136388;
	bh=m3zDplhGVLysMNmMfp7d7ECk+eNjKrp/LaGA3xJItSM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3XuYCAjg73WLQauZFLNf2iQkWCrgvGtRZ99E6CxRXPadDg2WFfT+aTcgnqQyDxWJ
	 1FGfHuXZiZ2Hp8Z4DkQOUTsVJ6Bl6e9iBQwH6uiN4BHsl8j00qvbTeHTVmkb7LtXGB
	 x8pv+QAbUMnVv0i+0GI4L+yXCqZVRkF9dlvEGoMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1EA3F80323;
	Tue, 15 Oct 2019 12:45:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B0A6F804AA; Tue, 15 Oct 2019 12:45:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0137FF80323
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 12:45:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0137FF80323
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PyUD/4NO"
Received: from localhost (unknown [171.76.96.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D741F2086A;
 Tue, 15 Oct 2019 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571136331;
 bh=77WBH2h9bRchd3kaucl/YpLXYB2oYx+m7W/9F0lJXvk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PyUD/4NOrGSzWLXzapptVHYY7NBEA/f14KabnbZdQCl9yYXhRHHK5fNn6TQ+lYLco
 9UMGzrfIREaj2fHCHC1soEe6LP/nWEmlZczRND4gokDE9nCh9CH4xT4tAqati0PFls
 VGB5xQ5P4mYFXr3JVBie0/AXxoUNqMnz7fA9uHMo=
Date: Tue, 15 Oct 2019 16:15:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Message-ID: <20191015104527.GX2654@vkoul-mobl>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd685232ea511251eeb9554172f1524eabf9a46e.1570097621.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Sanyog Kale <sanyog.r.kale@intel.com>, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] soundwire: depend on ACPI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gMDMtMTAtMTksIDEyOjEzLCBNaWNoYWwgU3VjaGFuZWsgd3JvdGU6Cj4gVGhlIGRldmljZSBj
YW5ub3QgYmUgcHJvYmVkIG9uICFBQ1BJIGFuZCBnaXZlcyB0aGlzIHdhcm5pbmc6Cj4gCj4gZHJp
dmVycy9zb3VuZHdpcmUvc2xhdmUuYzoxNjoxMjogd2FybmluZzog4oCYc2R3X3NsYXZlX2FkZOKA
mSBkZWZpbmVkIGJ1dAo+IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0KPiAgc3RhdGljIGlu
dCBzZHdfc2xhdmVfYWRkKHN0cnVjdCBzZHdfYnVzICpidXMsCgpBcHBsaWVkIGJvdGgsIHRoYW5r
cwotLSAKflZpbm9kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
