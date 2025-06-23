Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F1C77B7C
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:01:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64A8B60200;
	Mon, 23 Jun 2025 18:01:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64A8B60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750694503;
	bh=/aUOJv/viu6L1AUibOr3RuEmcn+q750DtLVDPmszDgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ryt/DtMy04NUTTeh+FvmDW0/epJDhwYLwMZ0qRquyCEN1hFOVz9BhSVZZZfeF/xCP
	 dzDm/qu9BrPI14MXB+hMfs/KPdG46IYXRk8/krxKaw3z35TDs/whwqwQ9cpbRuficV
	 tvrBkFDfDCzL7Iv7jtjzmCu30jsD1YcqaieZPmvY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15DB0F80610; Mon, 23 Jun 2025 18:00:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 014D0F80610;
	Mon, 23 Jun 2025 18:00:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F37BF80424; Mon, 23 Jun 2025 18:00:35 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CE67F80087
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2025 18:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CE67F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tx1i6ZV5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9D6A7A52031;
	Mon, 23 Jun 2025 16:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C48EC4CEEF;
	Mon, 23 Jun 2025 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750694431;
	bh=/aUOJv/viu6L1AUibOr3RuEmcn+q750DtLVDPmszDgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tx1i6ZV5zyxqyV9XllQV0BVMS5W1QMs5TL38OHLQdoIMR5uZY8SQt3OHTFrTLwrVS
	 fnk91QOz+5j/WakGql7BRD1Bp+P+MimG7U6hM3oSN/hHfLEbhIWl071CjoDBpNOakh
	 SrLrsaFJMxEEtpaNsRS7mcJUALcus7xm7aoYcj+VGmcd3UofqWcpVNWv3trEHZFi5x
	 3CFy8yXR+tpYduzjzkrnrCQYYL6QoYue+e/wxfxj//8vWOkQg2LK390q8/aYiMrHjU
	 +uME7CsPaP9JyLHxne2WnsgDxMoxKFU+v7mile+TOZkxoygjlLR/L0mEIYoPIQ0/eD
	 bpU8uR/L7SGPQ==
From: Mark Brown <broonie@kernel.org>
To: Yuzuru10 <yuzuru_10@proton.me>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250622225754.20856-1-yuzuru_10@proton.me>
References: <20250622225754.20856-1-yuzuru_10@proton.me>
Subject: Re: [PATCH] ASoC: amd: yc: add quirk for Acer Nitro ANV15-41
 internal mic
Message-Id: <175069443023.140181.7183611735574302998.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 17:00:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49
Message-ID-Hash: EHN7JKVY6XKLIT3DTHSIEC5VRQ3WEJFY
X-Message-ID-Hash: EHN7JKVY6XKLIT3DTHSIEC5VRQ3WEJFY
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EHN7JKVY6XKLIT3DTHSIEC5VRQ3WEJFY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 22 Jun 2025 22:58:00 +0000, Yuzuru10 wrote:
> This patch adds DMI-based quirk for the Acer Nitro ANV15-41,
> allowing the internal microphone to be detected correctly on
> machines with "RB" as board vendor.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic
      commit: 7186b81807b4a08f8bf834b6bdc72d6ed8ba1587

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

