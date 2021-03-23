Return-Path: <SRS0=iUFt=IV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 06:51:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D992A619B9
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Mar 2021 06:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D992A619B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BECD15F2;
	Tue, 23 Mar 2021 07:50:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BECD15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616482266;
	bh=dg3ddLYADr6YKw2HXZOwUsTND/PbCJkv3FHTduEjvhU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAH2vQw+u72ifGm2zYujyhs3Efpyyqn9stuawKmSNPcTF1NJ2xz2YF+kIv7EkczW8
	 kkPla5EdWMCfW7O8yXJoIlJ2BwRV92FxvmJJOMs1fx4ymhIgvjrgoeca8EAxzRyvDV
	 tHSeuCJH2zuDTJX+FhYwcgmcp+z9I7FFd7UtTN7g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70D24F8025F;
	Tue, 23 Mar 2021 07:50:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74366F8028D; Tue, 23 Mar 2021 07:50:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8DD5F8025F
 for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2021 07:50:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8DD5F8025F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QCoSS159"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B20619B6;
 Tue, 23 Mar 2021 06:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616482205;
 bh=dg3ddLYADr6YKw2HXZOwUsTND/PbCJkv3FHTduEjvhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QCoSS159+jleeyQemzoaX7u/khOPpcdnOMgWemTHx9bFpJAhmGbFEVWjAUNaBncUK
 X87Wb1KE8aA0dsRTlEPnpcQcVy8O/KVNYojEe5FFwuiqOn2UDEUVVqD86wC6CoM73E
 iZg6/Pa7hgmRkGZMhAFcsRY13tt76S7zBuOoYsyAXOov21DivqrMeC1dzPwxZ+ToL/
 rDfUCifObsoaQipXSNNaRDvkx/gCn8UQd4Ei1jtMTqu4XepfuN/YeytiNvIRW75ZXY
 EdosRtG0HFlhBV/j9i+YAdrbNYO2LnRZvwdOJqXem/p9qKNpowiyKhZ1pVm91jyEuV
 rieHrE0P/ysGw==
Date: Tue, 23 Mar 2021 12:20:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/5] soundwire: add missing \n in dev_err()
Message-ID: <YFmPmSPQjvFiI4L2@vkoul-mobl.Dlink>
References: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 23-03-21, 08:58, Bard Liao wrote:
> We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
> adding new ones...

Applied, thanks

-- 
~Vinod
