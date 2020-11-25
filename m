Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13695C5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 05:03:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072E22075A
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 05:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I/48yRcC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHxY11tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072E22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEFD7170C;
	Wed, 25 Nov 2020 06:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEFD7170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606280620;
	bh=Z2MumUoWaErnDkqpEsdXBKAkVR9BygO6dPF4F2sLmas=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/48yRcCgAVSimf9hPtWQzDWHmWJveiwZB3uL5S3ypsba7jwcS9ra7qxtIePojHgj
	 bVkVI7ikUTaHot/o3fSkSbIkfKSBxVYt2WoJXFJnQL/y8pIDWva5EDq4kB/ZFB5l7+
	 MP0q5Zy7uG6QAoSIpcXp+UMkmgefcmzYR9FPvu9A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D4F8F80128;
	Wed, 25 Nov 2020 06:02:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1484F8019D; Wed, 25 Nov 2020 06:02:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB992F80128
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 06:02:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB992F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aHxY11tK"
Received: from localhost (unknown [122.179.120.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BDC72075A;
 Wed, 25 Nov 2020 05:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606280560;
 bh=Z2MumUoWaErnDkqpEsdXBKAkVR9BygO6dPF4F2sLmas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aHxY11tKenZKqF/Bb1Eu00O6dpub0GG89Z7v3SGCpvjK7QbthgBDQBYpAWBpuL8b9
 C2rvJtedchduzLIbo+lNNzmGolr3g4Z0G3wsDkfgXm98wqk1ZQk87Z5Mp3fsQ2ww/t
 ocLi+wOw3bikjCAc0Vjv7R4e3oh4D56b9REIyi7w=
Date: Wed, 25 Nov 2020 10:32:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/5] soundwire: only clear valid interrupts
Message-ID: <20201125050235.GB8403@vkoul-mobl>
References: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
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

On 24-11-20, 09:33, Bard Liao wrote:
> We wrote 1 to the handled interrupts bits along with 0 to all other bits
> to the SoundWire DPx interrupt register. However, DP0 has reserved fields
> and the read-only SDCA_CASCADE bit. DPN also has reserved fields. We should
> not try to write values in these fields.
> Besides, we deal with pending interrupts in a loop but we didn't reset the
> slave_notify status.

Applied, thanks

-- 
~Vinod
