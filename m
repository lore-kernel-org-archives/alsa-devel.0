Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E276C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994C661184
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994C661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E4D0178F;
	Tue, 11 May 2021 10:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E4D0178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620722082;
	bh=YKWOq5o3HhQKTZsQen7jsuSJsP9ocdlM8lx4R1/2yUs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfQdapVhuO/jQ5/8uZHa4kARSaz4HKa1mnLqi0D8xMoCt6lM4v4H1Ff7thws4rx4K
	 1IatzsrncQe3iJl/pMduC/AZ62N+5ezM4JKtf0gAY8HrHbO7dqwn+BiopqqMeV1S4R
	 1emts2kX2YWXnpZFh7h6a9bZWKKpF5KxNFG7sJzo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67BC9F8051B;
	Tue, 11 May 2021 10:28:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E0DCF804B1; Tue, 11 May 2021 10:28:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1E49F8013A
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:28:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1E49F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bQGjdUAu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9360C61948;
 Tue, 11 May 2021 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721694;
 bh=YKWOq5o3HhQKTZsQen7jsuSJsP9ocdlM8lx4R1/2yUs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQGjdUAuch3Cp9R2Iagl62AjhX/O584npGj3eJqIIP1e96T7A5KrqT2f9bkbGwV1R
 eQlnxZOCSe2oOYXhF1c/QnvlOOLjQMEMUnUXbJes4oLIQfLs6uC+W3HlP+itm/iPSi
 ZJ4mPc6Xk+3J7/szVzvd0H0Le6QxW/6EMNHu86ThW/kR6HHvlGZqkX7fP3wMGhlY2r
 xveCk0zuPxQ5dr0l6t5V8Xgvp65TUodBrgCPl+auDKuixtOF9h1fzxr2BYmVPPyO40
 CcSDzU9ten2c4iAS79+gojcCc7gPOci6RPCMMaMd03F+k1F4RwRAwV7oxDv3kLyZHq
 OlYscbc45RUcA==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: add missing
 MODULE_DEVICE_TABLE
Date: Tue, 11 May 2021 09:26:00 +0100
Message-Id: <162072058170.33157.1978725298165946792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510103844.1532-1-srinivas.kandagatla@linaro.org>
References: <20210510103844.1532-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

On Mon, 10 May 2021 11:38:44 +0100, Srinivas Kandagatla wrote:
> Fix module loading by adding missing MODULE_DEVICE_TABLE.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: add missing MODULE_DEVICE_TABLE
      commit: d4335d058f8430a0ce2b43dab9531f3a3cf9fe2c

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
