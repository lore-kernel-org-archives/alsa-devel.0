Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE6BC43334
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jul 2022 14:31:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58D4B172A;
	Wed, 13 Jul 2022 16:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58D4B172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657722716;
	bh=6nZ1TG8+FX7o9uUu9puByYsWCfEB7XzK8cXS4yDrZ7c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWVYTb1B1+z8BGflMfmT4LALgfpXxW2DMuDUMSVr6M+lzcHvnA4P1tTvKsFqnHQo2
	 80aAK6ocZK+KMAun7IoDfO048BiqLn4i0nOwGicrXmvakZ5dv/cmQO9c4lTZNoZE3/
	 zrf6/zhi9hU+e7w36t6hOUkiae+6hvqNfIyNuOQg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D76F3F8019B;
	Wed, 13 Jul 2022 16:31:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9D9DF804CA; Wed, 13 Jul 2022 16:31:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F174F80249
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2022 16:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F174F80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZzgVs6+L"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BFA7A61DE6;
 Wed, 13 Jul 2022 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EDFC3411E;
 Wed, 13 Jul 2022 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657722655;
 bh=6nZ1TG8+FX7o9uUu9puByYsWCfEB7XzK8cXS4yDrZ7c=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=ZzgVs6+LW/RrGqeOsJ0CKqZeje/PndobfJWHYvVuYpbHw5ekedzkBc9vfuAmboqg8
 5p8qW45tarcY+UNrdgf27q/oLGdY2k5UUhcxT2imDxR34yv3I56tOjFyBfbBtzu0mh
 dGuedP9uvoyRkG2hP9Gt/Lc4Ft8aR03Q8MiNRiM0TtFZANM/OkpAMf2Z6vJluZXoGS
 RFad7owiyL4Mj7D7CeW18P3caM09tMgUIii+SKD2ha1LUSOJhAt0zAokM+zsYNUnGp
 PKWNhhT8BVEvvKF7w0KvkeJPZhVqbjmj8iD70wRZVbsSs0hCp9FXB5Ptt8zfi4xvwr
 C5yywJcbvkJ1A==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, windhl@126.com, lgirdwood@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
In-Reply-To: <20220713071200.366729-1-windhl@126.com>
References: <20220713071200.366729-1-windhl@126.com>
Subject: Re: [PATCH] ASoc: audio-graph-card2: Fix refcount leak bug in
 __graph_get_type()
Message-Id: <165772265387.116109.8832104294002903684.b4-ty@kernel.org>
Date: Wed, 13 Jul 2022 15:30:53 +0100
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

On Wed, 13 Jul 2022 15:12:00 +0800, Liang He wrote:
> We should call of_node_put() for the reference before its replacement
> as it returned by of_get_parent() which has increased the refcount.
> Besides, we should also call of_node_put() before return.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: audio-graph-card2: Fix refcount leak bug in __graph_get_type()
      commit: eda26893dabfc6da7a1e1ff5f8628ed9faab3ab9

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
