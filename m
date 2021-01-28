Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E4C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:56:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290D764DE5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290D764DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FCE016AD;
	Thu, 28 Jan 2021 21:56:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FCE016AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611867411;
	bh=1Q3JBbzrKlWRCyGG2/vnKM+0MChylTS66CNfZCbA83s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lGA8aCNBUkOuWUFU2PUYn7jI9OubSCchjwk8Y3jvmmftSHXWz5Eb6yLUinA4CGF+3
	 FH/Hgis68IhpAJau1y3FXs0WojvyUKxEjZaOhB/wJKPZu3XNIhQQN0oE/FSbgncdcR
	 EfaX+fjLTFThaNNEy0fc/mZ0r1ANQxP3Y7+mkOGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 970EEF80217;
	Thu, 28 Jan 2021 21:55:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F18BF80217; Thu, 28 Jan 2021 21:55:31 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC6CBF800D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 21:55:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC6CBF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W2AmedK8"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EB9964DDB;
 Thu, 28 Jan 2021 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611867326;
 bh=1Q3JBbzrKlWRCyGG2/vnKM+0MChylTS66CNfZCbA83s=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=W2AmedK8qteza6t210CV/04DlkSh4wmuXEyHvn4+d6/UTDb61kzk9dk14593RdgV4
 qtMMwcvtaDyY0uXkqcu95Gef2utD3hbfV/CPk+chhWQGJEbdjgNrc7ZNm/jMSXQDpM
 ZCEoQAwZE6OglIFrQ6G1n/uVfSHfGQaC+vAGYZsUEt/nf+LYbAn0XyzleKxVkGcSLe
 2kEC4PXDzBeDDalioxGRjR2BE/RVIaGpSpj5sg14PAXienTIlTCaIbmHTKIMZIFlog
 mXrVlnMqAaRtMgMbifNMncXHgvbADwA36ARZn1eLqpIbd4YLlxipUWhaX/nred/guT
 +SGS1DMIBqUzw==
From: Mark Brown <broonie@kernel.org>
To: bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 perex@perex.cz, devicetree@vger.kernel.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
In-Reply-To: <20210127151824.8929-1-srivasam@codeaurora.org>
References: <20210127151824.8929-1-srivasam@codeaurora.org>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: Remove bit clock state check
Message-Id: <161186727762.43763.16675933644941230011.b4-ty@kernel.org>
Date: Thu, 28 Jan 2021 20:54:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 27 Jan 2021 20:48:24 +0530, Srinivasa Rao Mandadapu wrote:
> No need of BCLK state maintenance from driver side as
> clock_enable and clk_disable API's maintaing state counter.
> 
> One of the major issue was spotted when Headset jack inserted
> while playback continues, due to same PCM device node opens twice
> for playaback/capture and closes once for capture and playback continues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: Remove bit clock state check
      commit: 6c28377b7114d04cf82eedffe9dcc8fa66ecec48

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
