Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146FCC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:10:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5D6207FB
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hg3cJl1m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlVwr4YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5D6207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F14C1181B;
	Thu,  1 Oct 2020 15:09:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F14C1181B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601557819;
	bh=FuTcyzN69KQMKYEsIBhcZpgp6OtwEYBmbAsEgSU4O4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hg3cJl1mUULePPGX5T3i64unb7PbP0zxtZE4nc1Ie5Ml7iP4GBY6RHDqvNp/TqFQH
	 /aYj2PTDMkLR9eRzlIj+2qoiihlF0ZQljNdZIuXK0ns5qbATtcBf7D5mVeoCZ2YFf0
	 J7eoHVutwuUjX7bg9ZiQrQYvQRxmYwn6BOOvvih8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40C3AF801DB;
	Thu,  1 Oct 2020 15:09:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61AC0F801F5; Thu,  1 Oct 2020 15:09:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44278F801D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 15:09:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44278F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FlVwr4YX"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72CD8207FB;
 Thu,  1 Oct 2020 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601557747;
 bh=FuTcyzN69KQMKYEsIBhcZpgp6OtwEYBmbAsEgSU4O4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FlVwr4YXaUjGDI/byB4LQN3LpBItOp6LGCPyeddE+e8p1Jw35498WFuSk+YDjyWNU
 YeZG9gj10e+1xcZygD9Tvj3fbi03DzbdZ5YyVBkOHfHaSuYIkzKf+3cntoFQNzmlhR
 9fbdRVJ1WQY5vlzrj86iR5Prctf7L0NyAKp3eG1w=
Date: Thu, 1 Oct 2020 15:09:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH 3/6] ASoC: SOF: Create client driver for IPC test
Message-ID: <20201001130907.GD2378679@kroah.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20200930225051.889607-4-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930225051.889607-4-david.m.ertman@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, broonie@kernel.org, parav@nvidia.com,
 jgg@nvidia.com
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

On Wed, Sep 30, 2020 at 03:50:48PM -0700, Dave Ertman wrote:
> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> Create an SOF client driver for IPC flood test. This
> driver is used to set up the debugfs entries and the
> read/write ops for initiating the IPC flood test that
> would be used to measure the min/max/avg response times
> for sending IPCs to the DSP.
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Co-developed-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Am I reading this series correct in that this is the only "user" of the
new ancilicary bus/driver code?

If so, why is it even needed?  These are just debugfs files for testing,
why does that need to be in a separate device?  What is being "shared"
here that needs multiple struct devices to handle?

confused,

greg k-h
