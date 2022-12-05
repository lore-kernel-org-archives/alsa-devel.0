Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BE2C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 16:03:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E29F177C;
	Mon,  5 Dec 2022 17:02:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E29F177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670256208;
	bh=fUCRk5umyyi3F3OQ84Ugjf+XIjegvMCAtqFGwoNUqqc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qne28IXMsTgzjws/ifjl+wp8NGM8u0tl03HPzXtaHqQ8y1PX1OpEr2ObOF75R0x0R
	 zPa+xWaX9CRa27ERDWnQhoSR71WGtmOhYuPsbjvMJZsqKlKYzi4ymMf3BvBx3g5IBk
	 AaQ1QhcE2tLC8ES+FzlBDyXBx5aVlb29W2N6qoUo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02771F80171;
	Mon,  5 Dec 2022 17:02:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D53A0F80236; Mon,  5 Dec 2022 17:02:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F361EF800BD
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 17:02:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F361EF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="o8sllyzq"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 822B661188;
 Mon,  5 Dec 2022 16:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59369C433D6;
 Mon,  5 Dec 2022 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1670256148;
 bh=fUCRk5umyyi3F3OQ84Ugjf+XIjegvMCAtqFGwoNUqqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8sllyzqWv2DzA+KUc9+w2ABl/BVpS0Lah/qIWLxT+W/phFpqpqdbXN1oOWepc2y6
 1CM6I2RlaNDAfcFYCSOSYzTwNVhYoEmdiIQoSi0gEVkPf+sgz5otQ4QNZFNjb4x0YQ
 NNzgKtGndHDakAGEC+w4etUgbRYKrSRN7qSWH+MA=
Date: Mon, 5 Dec 2022 17:02:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dawei Li <set_pte_at@outlook.com>
Subject: Re: [PATCH 4/6] xen: make remove callback of xen driver void returned
Message-ID: <Y44WEkKh9tdNjMlW@kroah.com>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232333CB411691110A8B9D96CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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

On Mon, Dec 05, 2022 at 11:36:42PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.

Please wrap changelogs at 72 columns.

And this should go through the maintainers of the Xen bus code, not me,
right?

And why wasn't this attached to the 0/6 email properly?  Did you use
different tools?  If so, our tools can't find the link to keep them in
sync either :(

thanks,

greg k-h
