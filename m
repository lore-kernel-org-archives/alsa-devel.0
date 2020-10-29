Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D9C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:28:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098732076E
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NRyJ8w0S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVQf49Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098732076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 985F5950;
	Thu, 29 Oct 2020 17:27:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 985F5950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603988877;
	bh=t+PBJ0NHId5QAZDzuBrDGNlV6g1PCH9iZXJKI+sMxMw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRyJ8w0SGYHl0IE5OAwi0N3rGs0r5mBQ5gb/7IDcZuBOiv/MkM2KiCV1nNTP5tb/I
	 w2yNbjZqIKhr42zybVsUwuaK4nHjpn5B8E/8eAtQMg973SIWSaz6mS7oGjVzUl3oBK
	 KPujVPPKR+wRiTLirnJ5vux4GBzQxYp4S2r+bV/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 199A9F800D8;
	Thu, 29 Oct 2020 17:27:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEF42F8020D; Thu, 29 Oct 2020 17:27:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C66BF800D8
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 17:27:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C66BF800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AVQf49Um"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 611922076E;
 Thu, 29 Oct 2020 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603988817;
 bh=t+PBJ0NHId5QAZDzuBrDGNlV6g1PCH9iZXJKI+sMxMw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=AVQf49UmZSCKirXj8VEFT7AM5GxmOOW2d1zUOMzZL+fF9cKQfQPy+RA/vxrnvAdIl
 YNViTwonflNW7tToWEuTx/vKAURkz4BULmyNJGUGG++LI65Lizy/glAXE1wFc93ssu
 8XBUL51CsE7vfoA3hxd4g6Tgv/G9qmhgdf5E2m4I=
Date: Thu, 29 Oct 2020 16:26:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20201029101550.31695-1-srinivas.kandagatla@linaro.org>
References: <20201029101550.31695-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: dt-bindings: sm8250: update compatibles
Message-Id: <160398881039.39922.12061096532284319098.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 robh+dt@kernel.org
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

On Thu, 29 Oct 2020 10:15:49 +0000, Srinivas Kandagatla wrote:
> Update compatible string as board compatible and device compatible
> should not be same!. New compatible is now suffixed with -sndcard
> to be inline with other Qualcomm Sound cards.
> 
> This also fixes the warnings/error reported by dt_binding_check.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: dt-bindings: sm8250: update compatibles
      commit: a889583a19206636082c44625141b26392e46a62
[2/2] ASoC: qcom: sm8250: update compatible with new bindings
      commit: bbc4e1bb5fd6577ed668e7c2ba0705dff1783bce

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
