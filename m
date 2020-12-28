Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420EFC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 14:35:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FEF2063A
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 14:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FEF2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3CF71714;
	Mon, 28 Dec 2020 15:34:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3CF71714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609166122;
	bh=ogKcYkMw9ARzUKF21VmoE9vp/OT8fP5rL3ZGtMvoMDg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWEQu3gLGyO4kiOQapP0F0LZ04/OktI5v69PRBMwP+ihBJ7jZRjK0gkZ17yD+FLFf
	 YKp6/s57aIA83j1b8BDjKqOQ/6XtvkDvBYUpkm4nUq3PmLwEYjJANWriXXRx/KMYwp
	 fj/pL56lGETOyobcxGkB8EpAwGfyr2c1JS1NYsvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8875DF801ED;
	Mon, 28 Dec 2020 15:34:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E890F801F5; Mon, 28 Dec 2020 15:34:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68925F80169
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 15:34:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68925F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="fYWTZ9tz"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196CE208B6;
 Mon, 28 Dec 2020 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1609166059;
 bh=ogKcYkMw9ARzUKF21VmoE9vp/OT8fP5rL3ZGtMvoMDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fYWTZ9tzG3dASXGRvFijK93GYHKBOz+qKNOQu/g4BlfZya9eLTcntZ7Nlql4qaUTq
 7CR2tycoArNSxqesLE+c3Jf+PQr8YYxT3b5c2VUhjiB7UBKl+I/3Z7vvWII1xqDh71
 7U0C+AVXy+mLmO1zHTTSO5tfbYjxs+uxrb73DWbc=
Date: Mon, 28 Dec 2020 15:25:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+nq1JJLxyVr7Ih+@kroah.com>
References: <20201222040645.1323611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jassi Brar <jaswinder.singh@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dmaengine@vger.kernel.org
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

On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
