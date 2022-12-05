Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D4DC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 16:01:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36963177C;
	Mon,  5 Dec 2022 17:01:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36963177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670256112;
	bh=trNrKrfKjsfA/iJHoM4RlcQMgCcsX15/LCiL4T/xuJ0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCZrb8izJ7BSduoj6RhXpy/FOdsYzirEPV9WJSS9AAzB67s3BU+86xHNt1KbmXan/
	 pedubIBrzA0PaSA2IWBWTOneOBJ/fqakm71DDsLl/PnR/4eq6DMokKQu/a63Cnvm3c
	 UrJrP7j/8IbEx2DNgSOvFTtH5Wcq6K5SRU8nMKEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D80FCF800BD;
	Mon,  5 Dec 2022 17:01:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05FAEF80236; Mon,  5 Dec 2022 17:01:00 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D171CF800BD
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 17:00:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D171CF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="EXkPiPH9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BC54BB81144;
 Mon,  5 Dec 2022 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945AC433B5;
 Mon,  5 Dec 2022 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1670256055;
 bh=trNrKrfKjsfA/iJHoM4RlcQMgCcsX15/LCiL4T/xuJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EXkPiPH9jpu2QDhpC1k592OE6zoYsvZ6Cm6TtkRBZj9flj8DPe/+/ck94MscE/Hy+
 PVn+ynbqHg6LhzriIAOKH+7f1fPldEuUHPztcK+v0tQmwdicxIaCw7If8OtrPmpjh+
 OYAzWhpAg9ucHwpcZ/6qG8GRvR0WojmPy76I8FYg=
Date: Mon, 5 Dec 2022 17:00:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dawei Li <set_pte_at@outlook.com>
Subject: Re: [PATCH 0/6] Make remove() of any bus based driver void returned
Message-ID: <Y44VtN/rmjIU6sDC@kroah.com>
References: <TYCP286MB23234ABCCF40E3FC42FD09A4CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23234ABCCF40E3FC42FD09A4CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Cc: jgross@suse.com, wei.liu@kernel.org, sstabellini@kernel.org,
 linux-hyperv@vger.kernel.org, mpe@ellerman.id.au, haiyangz@microsoft.com,
 linuxppc-dev@lists.ozlabs.org, decui@microsoft.com,
 alsa-devel@alsa-project.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 oleksandr_tyshchenko@epam.com, srinivas.kandagatla@linaro.org,
 christophe.leroy@csgroup.eu, bgoswami@quicinc.com,
 xen-devel@lists.xenproject.org, johannes@sipsolutions.net, kys@microsoft.com,
 robert.jarzmik@free.fr, roger.pau@citrix.com
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

On Mon, Dec 05, 2022 at 11:36:38PM +0800, Dawei Li wrote:
> For bus-based driver, device removal is implemented as:
> device_remove() => bus->remove() => driver->remove()
> 
> Driver core needs no feedback from bus driver about the result of
> remove callback. In which case, commit fc7a6209d571 ("bus: Make
> remove callback return void") forces bus_type::remove be void-returned.
> 
> Now we have the situation that both 1st & 2nd part of calling chain
> are void returned, so it does not make much sense for the last one
> (driver->remove) to return non-void to its caller.
> 
> So the basic idea behind this patchset is making remove() callback of
> any bus-based driver to be void returned.
> 
> This patchset includes changes for drivers below:
> 1. hyperv
> 2. macio
> 3. apr
> 4. xen
> 5. ac87
> 6. soundbus

Then that should be 6 different patchsets going to 6 different
subsystems.  No need to make this seems like a unified set of patches at
all.

> Q: Why not platform drivers?
> A: Too many of them.(maybe 4K+)

That will have to be done eventually, right?

thanks,

greg k-h
