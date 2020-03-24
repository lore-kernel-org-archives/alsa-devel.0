Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200DFC43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:19:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A238E20714
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rYQwAhLy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=domdv.de header.i=@domdv.de header.b="ElIA44D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=domdv.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E066A1661;
	Tue, 24 Mar 2020 19:18:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E066A1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585073975;
	bh=QOOPI/VXWBn/mdhzJiza6F9JJx5nC+5Bgn4DCJYlZUE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYQwAhLyzrqFy06u4eDWe6pGRjbBE4RWkASnJzdHoa3YJtKGbKFhPOCkz9BWAxPXW
	 iuYkdRbiepBNHIVW2ZJzLcP2mH+GdQVKtFtekazr8HePr7eTyitj3yQzwge2+jsPzf
	 6uxyTW4mhhcNqDSNunIvBMyLGMXzdXlC8NU9no18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72718F801F8;
	Tue, 24 Mar 2020 19:18:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48192F801F9; Tue, 24 Mar 2020 19:18:42 +0100 (CET)
Received: from zeus.domdv.de (zeus.domdv.de [IPv6:2a02:2ad0:c00::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3CCDF800B9
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 19:18:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3CCDF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=domdv.de header.i=@domdv.de
 header.b="ElIA44D4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
 s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H8ka1z3sv0qvqn3Ts1AAhUov9MztEy90r4kqB/61JZ0=; b=ElIA44D44eRv6osP3NIDUYDt+I
 CiTbQP1YF3vWh4dxulKkS99UJiEkf80+7ihpcmKnKT875EOKvw3Zr2/HdPtNqUCQb/HkJGt1BbQo0
 DqLdEYNTf9lAbbK9xHW3vQrJQe5a1+frGOXZjZXV/1wlrWFdzc7RQVXOkJ+okFBKPOwg=;
Received: from [fd06:8443:81a1:74b0::212] (port=4306 helo=castor.lan.domdv.de)
 by zeus.domdv.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ast@domdv.de>)
 id 1jGo7K-0006ew-Rk; Tue, 24 Mar 2020 19:17:34 +0100
Received: from woody.lan.domdv.de ([10.1.9.28]
 helo=host028-server-9.lan.domdv.de)
 by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <ast@domdv.de>)
 id 1jGo7K-0006dl-KU; Tue, 24 Mar 2020 19:17:34 +0100
Message-ID: <1de1fb84a2cbe5c5c106befb101e2a1dd9a7900d.camel@domdv.de>
Subject: Re: [PATCH 1/3] ALSA USB MIDI: Fix port starvation
From: Andreas Steinmetz <ast@domdv.de>
To: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 24 Mar 2020 19:17:34 +0100
In-Reply-To: <2601eab3-9f73-f628-3f2f-24d4686916f9@ladisch.de>
References: <c9aed355adc93d5de0cc4c740d16d19e3e210f79.camel@domdv.de>
 <36c09bfb-7d28-84c5-acba-9c74ad153a83@ladisch.de>
 <4f3995a9c08c41bb0a5170e78941f47e6ac33d0f.camel@domdv.de>
 <2c80b1eb-cf19-0882-5ec2-3f95cf253a51@ladisch.de>
 <0a66efeb806871d82bd750ff6219c516e48be66f.camel@domdv.de>
 <2601eab3-9f73-f628-3f2f-24d4686916f9@ladisch.de>
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

On Wed, 2020-03-18 at 10:35 +0100, Clemens Ladisch wrote:
> I think the lowest-hanging fruit are the hardcoded 0x10, and that
> port->active is not a single bitfield; the latter will make
> searching for active ports easier.  I'll create patches for this.

I've created a small test utility that may be useful to test
patches. See https://github.com/not1337/rawmidiperf

BTW: Have you you already have something to look at?

Regards
Andreas

