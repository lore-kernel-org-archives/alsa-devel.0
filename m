Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB133C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 15:46:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42C0DF7;
	Mon,  9 May 2022 17:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42C0DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652111199;
	bh=b+0bTNxvxsgDQNXw7Vjz5YHZ8VLG91q1lL5GmMMGn2M=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSKxZ9dSI3qqOQEOUXa0ZExptD+HkA8xVlTmE86WwMYaTNQTOixp5FxjUNt79sJni
	 csBzllVouE1xKDbp4b3LmBcou+ZsOJO9Ez9l2KfbZsjKoKXk32athxj0CymUFDpp1Z
	 sEhLFyZ5IDnUuxUuShc07fWeE9gE0qTXCnfhCXqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1279F8025D;
	Mon,  9 May 2022 17:45:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73D88F80269; Mon,  9 May 2022 17:45:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B903F800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 17:45:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B903F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="s+x9C0GG"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 741E0B8172F;
 Mon,  9 May 2022 15:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25F9C385B1;
 Mon,  9 May 2022 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652111139;
 bh=b+0bTNxvxsgDQNXw7Vjz5YHZ8VLG91q1lL5GmMMGn2M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=s+x9C0GGh4n8hjY6+DdrcoFVtXDfvVE3eSUlgBZRcq6dDybjYiZ9on7NpDX7xH6Av
 47Q4RRrDlU7mayUQX3MbIcHWvO0pp/UgNRlly0ocFP8DU8dxpoEzH5dTh1g9PZ+QBa
 aPBjPJmRwQk8decE0QWsM4HJY5pDPlENEgxuN7Mp760I2QXWdOFOU0jZN7VVEvjcg3
 9ILHZX78SPM5E3TMiCKryWDVJmI/fZhvIF3v0SVeMKmRNhg6IEzwb8pxz+I4ns0+jV
 7i0iTFTqjKQRdOp3pSzV3LurduMJV0VIsYFk+5yf29X9Q8sgJljYJ6B2WIBEUBvrOK
 lP/4KEkI3/QUA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, cgel.zte@gmail.com
In-Reply-To: <20220505021733.54275-1-chi.minghao@zte.com.cn>
References: <20220505021733.54275-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: uniphier: simplify the return expression of
 uniphier_aio_compr_set_params()
Message-Id: <165211113755.774487.2751485031602325886.b4-ty@kernel.org>
Date: Mon, 09 May 2022 16:45:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: zealci@zte.com.cn, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, chi.minghao@zte.com.cn,
 linux-kernel@vger.kernel.org
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

On Thu, 5 May 2022 02:17:33 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: uniphier: simplify the return expression of uniphier_aio_compr_set_params()
      commit: ef1258a7820d99cc7999cafbd8ea78a24559ff12

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
