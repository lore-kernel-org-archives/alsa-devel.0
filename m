Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A9C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 20:37:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BC4D1799;
	Wed, 16 Mar 2022 21:36:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BC4D1799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647463032;
	bh=ftssrwglpKKVQfdsgq1xKuGibUN8q6X5uF9Eg6Rr1qs=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iRLz9KctL9ItuZGLJxrb5yjkQG+PrG43yLbpOFSSMi6fYcxgHztQ18TqIDOTleuUH
	 in+pldWIvP/UfqwIUPuFik7Zq4BGFZ43rAnv6xU2CCGKwNTqYScRv7eZ9eOYyPO0yq
	 rZxHuwKXAZ5eIWNKoM2NZMdLg6J7OuBk2raSIQ3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BDEFF804D9;
	Wed, 16 Mar 2022 21:35:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03A77F80515; Wed, 16 Mar 2022 21:35:55 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D42A0F801F5
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 21:35:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D42A0F801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UIV6sxB3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2AA13B81D42;
 Wed, 16 Mar 2022 20:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E6CC340EC;
 Wed, 16 Mar 2022 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647462943;
 bh=ftssrwglpKKVQfdsgq1xKuGibUN8q6X5uF9Eg6Rr1qs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UIV6sxB3RgWdIC/J02qcht7N50hr0GeSgxzIKXEuhX1tCV7N1fyrLlxlpS44GotSO
 Y55kydz5IQhtbPA/aD9ZAVgN6j9f6dYbgfo5HDjIziySBAL9Q6ZEDBMvZkZgXmaKmk
 rz2inRtSs1df4rM8BhIxypEfsae7/JPM4TLVOMbGcbf7ZURNZkKOJFCqUvU7hHvQMl
 sWZ31qrMHFAOeknf8t7I42AKpKNT1HBE4ZqHqaHPIzfl03MC4z6NTJly7uAVP6LBGi
 rJp9Y9wJ8tmaApGUiv295RmE+1P2Qbadyb/E2JdHdw00c78F3Y4O/s892ljDA9OKuE
 EiEfn+40w8Arw==
From: Mark Brown <broonie@kernel.org>
To: cgel.zte@gmail.com
In-Reply-To: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
References: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: ak4642: Use of_device_get_match_data()
Message-Id: <164746294144.1220201.15254830524209110436.b4-ty@kernel.org>
Date: Wed, 16 Mar 2022 20:35:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
 alsa-devel@alsa-project.org, Minghao Chi <chi.minghao@zte.com.cn>,
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

On Tue, 15 Mar 2022 02:32:26 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4642: Use of_device_get_match_data()
      commit: 835ca59799f5c60b4b54bdc7aa785c99552f63e4

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
