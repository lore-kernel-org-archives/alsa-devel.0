Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D7C43381
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 12:08:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A602C64FF1
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 12:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A602C64FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59058176D;
	Wed, 10 Mar 2021 13:07:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59058176D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615378080;
	bh=GVRxbE5XCkimPxYjriDb+gFAOIRYYFsaiOlWdBVZhf4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFZ11icJOlhude1rHbxz/VN70/WqIwTj9FZnh2fz7C20fjxidSZf97FgaLw3ZubBP
	 k/KQgNaTODkGLIOTsAliy+uSrSB1j+lG5YC6hHcLRyU6T+CINl1XAcP5inSND2pIKk
	 9z/nijA8jlWBRuGKVRkMJZ1+XyZFxdW6l9Hqvt8o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91289F8010D;
	Wed, 10 Mar 2021 13:07:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17B54F801D8; Wed, 10 Mar 2021 13:07:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCBF3F8014E
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 13:06:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCBF3F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="rbBzgN3M"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79A7C64FEE;
 Wed, 10 Mar 2021 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1615378010;
 bh=GVRxbE5XCkimPxYjriDb+gFAOIRYYFsaiOlWdBVZhf4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rbBzgN3MceSCRkawOIYTVt/xQ29z/XcWin60DdHq+4t3a/B0LVY/mKbiokW4bZtoK
 oNix2OYalCr/M9TuKN90rPdlMW/qksckaZY45Ge7xU1GUFJiz/osyofoA15Qdkvh/E
 HShx3s9rSS1csqtcEqZmAwRrGfkkjbesqFz5Siv4=
Date: Wed, 10 Mar 2021 13:06:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: Intel: broadwell: fix mutual exclusion
 with catpt driver
Message-ID: <YEi2Vwid7ESsBRCb@kroah.com>
References: <20210309221618.246754-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309221618.246754-1-pierre-louis.bossart@linux.intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 alsa-devel@alsa-project.org, stable@vger.kernel.org,
 David Ward <david.ward@ll.mit.edu>, broonie@kernel.org
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

On Tue, Mar 09, 2021 at 04:16:18PM -0600, Pierre-Louis Bossart wrote:
> In v5.10, the "haswell" driver was replaced by the "catpt" driver, but
> the mutual exclusion with the SOF driver was not updated. This leads
> to errors with card names and UCM profiles not being loaded by
> PulseAudio.
> 
> This fix should only be applied on v5.10-stable, the mutual exclusion
> was removed in 5.11.
> 
> Reported-by: David Ward <david.ward@ll.mit.edu>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211985
> Fixes: 6cbfa11d2694 ("ASoC: Intel: Select catpt and deprecate haswell")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Cc: <stable@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sasha Levin <sashal@kernel.org>
> ---
> v2: added Mark and Cezary tags, fixed stable address, added
> maintainers
> 

Now queued up, thanks.

greg k-h
