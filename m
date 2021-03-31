Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A25C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 15:50:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3823B61004
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 15:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3823B61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A2BD1657;
	Wed, 31 Mar 2021 17:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A2BD1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617205797;
	bh=J242/NbTOFQruKkTsBUMXjsDtW/KiQMFDij8NuPdH6Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=quDnHus1qw/mnnynrB0Tvz2U2K+UqguAG4RBVpzXMa26bESg8QKadPreLJtpgUgCu
	 We5m7OGUu4RMQ24KNodtVTm+eXEmeg1w0AV48zbTOtny8lE06ZqBFHqPpTnty7m7Cv
	 cN0gKCa6b3rIrM4fsKEpO/651yDRQw+bRk5ZxxGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A5DF2F8015A;
	Wed, 31 Mar 2021 17:49:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2E16F80166; Wed, 31 Mar 2021 17:49:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1419F8013C
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 17:48:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1419F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gvfhSOr9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5EC61002;
 Wed, 31 Mar 2021 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617205734;
 bh=J242/NbTOFQruKkTsBUMXjsDtW/KiQMFDij8NuPdH6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gvfhSOr93va1KKhQ/pkAClMn5YNQb+aM3SBgYufVYewD2N48nVvzYrplqtQAv0Yia
 k6cSEILjhNV9oz5qXAihoLKKRXLNKpe1pTmpoaRHe8IBjLINZVSLNyCgPqiL6SS3N+
 CKb9ppUZOOOU9q6QH19NBZErNAs+7y858xx914NuuxhLfhlTgcrcEuK7s0Svtl9qyk
 W8tM+VToG4SDEphdQNCWZN2PL9PoEBPenGIaOOQBG7izDjPuuNJojKCSTnRwDTW1Kh
 NFLC6xg6N2AAiqKc7hP1ci+yXVIZ/ohdXLwPeRN87r6ppui7tR67+bi16ZgUwP0Svg
 hZmA6FkTzhctg==
Date: Wed, 31 Mar 2021 21:18:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: qcom: use signed variable for error return
Message-ID: <YGSZ4sAwMUA5kQsc@vkoul-mobl.Dlink>
References: <20210331072111.2945945-1-vkoul@kernel.org>
 <9cdef4e9-a38a-6c77-1b23-739f85384b12@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdef4e9-a38a-6c77-1b23-739f85384b12@linux.intel.com>
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On 31-03-21, 09:41, Pierre-Louis Bossart wrote:
> 
> 
> On 3/31/21 2:21 AM, Vinod Koul wrote:
> > We get warning for using a unsigned variable being compared to less than
> > zero. The comparison is correct as it checks for errors from previous
> > call to qcom_swrm_get_alert_slave_dev_num(), so we should use a signed
> > variable instead.
> > 
> > drivers/soundwire/qcom.c: qcom_swrm_irq_handler() warn: impossible
> > condition '(devnum < 0) => (0-255 < 0)'
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/soundwire/qcom.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> > index b08ecb9b418c..55ed133c6704 100644
> > --- a/drivers/soundwire/qcom.c
> > +++ b/drivers/soundwire/qcom.c
> > @@ -428,7 +428,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> >   	struct qcom_swrm_ctrl *swrm = dev_id;
> >   	u32 value, intr_sts, intr_sts_masked, slave_status;
> >   	u32 i;
> > -	u8 devnum = 0;
> > +	s8 devnum = 0;
> 
> it's not great to store negative error codes with s8. That works in this
> specific case because the function only returns -EINVAL.

Yeah I did check EINVAL was the case which would work but in general I
agree that makes sense, I discussed with Srini on IRC and looks like I
havent posted v2, should hit the pipes shortly

-- 
~Vinod
