Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CBDC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 17:36:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBFEF1B63;
	Fri, 25 Feb 2022 18:35:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBFEF1B63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645810604;
	bh=VUyk+0Rt0niqIIBYP+6jIEiVC7FOQTCn1N4XUFQUgZM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ezVd5HyMO8OtUgebIXEwd0gJK+Pfuh5kSmYFZKvIlLDEnLAmPVYKP57C6ZB8IvyOI
	 SXw2YLeBoRroiFaRM7S/qjFeBZQ8t+wzucrZm58Kjo+VQy+1o2mCbj6dzVsr2ttkal
	 yn6lYT83fH6zGcZp84PCNrEx5B9VEQlAqkN9aZEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5622AF80132;
	Fri, 25 Feb 2022 18:35:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50522F8012F; Fri, 25 Feb 2022 18:35:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CADE0F800E1
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 18:35:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CADE0F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MBFZSmEl"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D949461CB9;
 Fri, 25 Feb 2022 17:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE256C340F4;
 Fri, 25 Feb 2022 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645810547;
 bh=VUyk+0Rt0niqIIBYP+6jIEiVC7FOQTCn1N4XUFQUgZM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MBFZSmElRL/jG1J8ljmju8Qi9MU648AkAIgQypo+FSH8Jn58vmrFOY1PsZ7o4Xl+4
 xCKVYDNUEU2IqtEHznXsodfi9HqDrvC8VQj7/dssQmOu9T42Pv9sR+V0PoLriscq8w
 M8dPDH5ckw/2jqcpdh5Dxny8ZrnUw0gvUD1yxCKP+utoBGMo8u9Vk1JA225iXeZqcK
 z5NmAfggdf0nW1mv1EuK1GuzX5zjMIPVrcDSQAId1VBPTzoOo034DYlpm1N+3JW/WZ
 FIt4Izca/ATdJJUaG+TjkW3FBc1Y/Vs4QkSbNkhr3WWHymWPs71Fb808XyHVey+BP8
 Tklod54ZmXiDQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, oder_chiou@realtek.com,
 Jia-Ju Bai <baijiaju1990@gmail.com>
In-Reply-To: <20220225131030.27248-1-baijiaju1990@gmail.com>
References: <20220225131030.27248-1-baijiaju1990@gmail.com>
Subject: Re: [PATCH] ALSA: rt5663: check the return value of devm_kzalloc() in
 rt5663_parse_dp()
Message-Id: <164581054563.2548431.3919783433655964558.b4-ty@kernel.org>
Date: Fri, 25 Feb 2022 17:35:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Fri, 25 Feb 2022 05:10:30 -0800, Jia-Ju Bai wrote:
> The function devm_kzalloc() in rt5663_parse_dp() can fail, so its return
> value should be checked.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: rt5663: check the return value of devm_kzalloc() in rt5663_parse_dp()
      commit: 4d06f92f38b799295ae22c98be7a20cac3e2a1a7

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
