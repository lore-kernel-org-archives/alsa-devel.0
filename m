Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5524C3F2CE
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CE724673
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k5RJrOq8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Zr9+Yku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CE724673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EC19836;
	Wed,  4 Mar 2020 17:59:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EC19836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583341204;
	bh=FQJSk9E9cGV2olbAq15IXg0ngbl4HxcZVCftTjJCUfY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=k5RJrOq8zziS2H8P6G5s5QakrQuvAU+PyyXSMYH2CUJwRf/Mxk0K28R8kZE9uzO51
	 MoB+VhTzmny2TCr6CKW5DROOb/uC2rwFoPaTjl5J30AJwKezpB8VN/zBz6ZzT/th2+
	 SCQ68yPBEUOwUlNvg5qbUeE1hy2a4mUSnMO+15KM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15798F801EC;
	Wed,  4 Mar 2020 17:59:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F01AF801ED; Wed,  4 Mar 2020 17:59:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD907F800D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 17:59:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD907F800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2Zr9+Yku"
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 600C921D56;
 Wed,  4 Mar 2020 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583341146;
 bh=FQJSk9E9cGV2olbAq15IXg0ngbl4HxcZVCftTjJCUfY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=2Zr9+YkuiQdVRJO0bZKlDvnpapkcJZFRtX9xUaJMXM5KPRxd3LP586Og89lfK0nag
 Y30aIlJgJd3hhq46DRh7mi7mSly3xSJ0C3/8elWdxa/ClPJ4YpCYE4l/kQHsij+QyA
 ijNVi4YJUhxK5oQdpc1Pj7MpJuuri/cKNVv31U7s=
Date: Wed, 4 Mar 2020 10:59:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 00/10] PCI: Add and use constant PCI_STATUS_ERROR_BITS
 and helper pci_status_get_and_clear_errors
Message-ID: <20200304165904.GA231103@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303.185937.1365050844508788930.davem@davemloft.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org, nic_swsd@realtek.com,
 linux-pci@vger.kernel.org, clemens@ladisch.de, tiwai@suse.com,
 stephen@networkplumber.org, netdev@vger.kernel.org, hkallweit1@gmail.com,
 linux-kernel@vger.kernel.org, mlindner@marvell.com
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

On Tue, Mar 03, 2020 at 06:59:37PM -0800, David Miller wrote:
> 
> Bjorn, please review and let me know if it is OK to merge this via the
> networking tree.

I acked the relevant patches and you're welcome to merge it via
networking.  Thanks!
