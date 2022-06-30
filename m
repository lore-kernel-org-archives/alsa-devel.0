Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE6C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jun 2022 15:12:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D58F16F7;
	Thu, 30 Jun 2022 17:11:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D58F16F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656601948;
	bh=FyTqsR5EybY7iM7iEaNhoXEYisNEPyb47zA76fc//G8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIaFAvJVXQ5xsC6h5AScJMepoHtiskl57B8D2k+esvliJPPRiZSFdkjo6o7L7NQrx
	 gIQYddaiBWKL3+u3mrtVLnqnnbA/ACco5sa1OGZiDCff/BL5NmzZ13pCJXpSN7Zrfh
	 gQCEhrfG+TKALvasP31Qp5//mpUMopGmN5kXjJr8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 65456F8053D;
	Thu, 30 Jun 2022 17:10:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C081FF804FE; Thu, 30 Jun 2022 17:10:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31109F800F5
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2022 17:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31109F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tEJdqW3f"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 12D3D60F17;
 Thu, 30 Jun 2022 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C25C34115;
 Thu, 30 Jun 2022 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656601821;
 bh=FyTqsR5EybY7iM7iEaNhoXEYisNEPyb47zA76fc//G8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=tEJdqW3fFrs6IZJs0Z0xMIAz6dYJa3FkZbT2ZtVa+n8gnU1Rv4nfq9jAiCZ3YxTxc
 EyTCEfs0JYj54Mi5I7WLxxCKB7eBR/tq14csHutOlS8RBVIJB1vzYOEzZC2zKoBxYZ
 y6oL7c1XmowAFo+3IbUJ/Pp4bGZp1GkpJQPP1RZuRcsgxkAsyDDhwfthUl4WwaeGU2
 xXjXQBq8StJgKiCyWveWJlIUzONGwKzmnRQLJtpGOvYSShrEDzPYaaz1J/GBZyAtJy
 n1r8XiRerB2IYhUZs52bjUaBy2Hu61H0qfxU0nOjRGb1bKf2r+GjJNYb8sOMzIXT41
 kl6hSYp84J5EQ==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
In-Reply-To: <20220630123633.8047-1-srinivas.kandagatla@linaro.org>
References: <20220630123633.8047-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3] ASoC: codecs: wsa883x: add control,
 dapm widgets and map
Message-Id: <165660181971.664251.15530815759209640132.b4-ty@kernel.org>
Date: Thu, 30 Jun 2022 16:10:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com
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

On Thu, 30 Jun 2022 13:36:33 +0100, Srinivas Kandagatla wrote:
> Add controls, dapm widgets along with route.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: add control, dapm widgets and map
      commit: cdb09e6231433b65e31c40fbe298099db6513a7f

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
