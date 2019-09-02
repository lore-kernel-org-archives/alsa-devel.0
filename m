Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AFAC3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:02:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8D8217D7
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GBdaqcHO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IokDy13u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8D8217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0C2116F4;
	Mon,  2 Sep 2019 18:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0C2116F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567440152;
	bh=/+c7CAlgS+w2mrSo84aBZDuUL6GtS3HlPOUz5JKX1P4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBdaqcHOVuxi6SjBsf1VuAAX1traJem878cjKyQZiHo5TQVK1ygOhCcdZF/X9YLjd
	 Uu+Yjzb7KmF+Qax7p+BKjL0Bn8hHHmgd9btmAxu7SfxmkUwNIybKuDvHEye7Jp/gx3
	 MJUw0CTtBR0GTdKKLg+QEXjtb1PthFHXEc7/T6Ro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67571F80448;
	Mon,  2 Sep 2019 18:01:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB504F8044A; Mon,  2 Sep 2019 18:00:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27753F802E0
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 18:00:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27753F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IokDy13u"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C89E921881;
 Mon,  2 Sep 2019 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567440055;
 bh=mJwEXeh9CSD/UGKpq5I8/EKKhuH0yp4LBIc3MRNKusI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IokDy13upxRjfjtUAgiANVVb5OnMLv/ypAQlXMRYwgf7PNYfawBES++kL3BndpSyq
 wmRXla5ruFdg/4tW1jDyC7volEhHr3UqY75gAI2gconNIjwmU+MH2nmHgpOo8zWGXa
 yjHRGES2Yuocvxc4Ka10XexzBKcrvhehbuY4UkEs=
Date: Mon, 2 Sep 2019 18:00:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Message-ID: <20190902160044.GC21884@kroah.com>
References: <20190830214730.27842-1-benquike@gmail.com>
 <CAKpmkkWv2cjrJCkVhGmEMnLG2_kCNxdbt29dZ8j-UM8Cf3quGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKpmkkWv2cjrJCkVhGmEMnLG2_kCNxdbt29dZ8j-UM8Cf3quGQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Wenwen Wang <wang6495@umn.edu>, Mathias Payer <mathias.payer@nebelwelt.net>,
 stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH 2/2] Fix a stack buffer overflow bug in
	check_input_term
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

On Fri, Aug 30, 2019 at 05:51:17PM -0400, Hui Peng wrote:
> This is the backported patch for the following fix to v4.4.x and v4.14.x:
> 19bce474c45b ("ALSA: usb-audio: Fix a stack buffer overflow bug in
> check_input_term")

Now queued up, thanks.

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
