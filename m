Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F0AC5479D
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 16:51:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C32EC93D;
	Mon,  9 Jan 2023 17:51:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C32EC93D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673283113;
	bh=crfH3DNuxnnnEgBLc4QnnpaR6XIAnGQOnWmoA6qkFFo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pDTwrOLaiTLRmbhPgx139gceRyE4f8Sg88omKsZIVrARUtlRUplYapc7j7oOXupB+
	 EIcT7JAFPPiaMJJ3L0SGdgb2b2SZXRI0bqN/xfS7GNjNboTjBBukYij77RBWFzQHU3
	 s8JOeSDL6+HpwLSoVRULXrVxAanMGDPaA3ULKznA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D59B0F80571;
	Mon,  9 Jan 2023 17:49:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64DCBF80568; Mon,  9 Jan 2023 17:49:23 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6E0DF8055A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 17:49:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6E0DF8055A
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i7nz99UU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 73791611EC;
 Mon,  9 Jan 2023 16:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECA7C433F1;
 Mon,  9 Jan 2023 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673282959;
 bh=crfH3DNuxnnnEgBLc4QnnpaR6XIAnGQOnWmoA6qkFFo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=i7nz99UUUB6mq8L6gizntMmjWgzo0ggwV1fA/GkVuSeGE/DYjSDy4egfwgjFO7lkn
 n3E1W93PxQVkOojQkLMT9IvVzW3BQ8k91d9Zvnssn4pVzbzmAejw923qZani6LdgTe
 U2vuEB6YPEa57xrjp/pae4pMRCKio68lLDZ9yjcySuwPOYJ6wBQtbK3Im7i0hwz3KC
 bKsTMg5FDAMq0S/Fsmth7TzthwKfInp33J8GtUk4/xxzgS6EqkWtBGeQL4fxx1P1u7
 Kwk3yxKCGB+O/FcjS0A8hQFmP2MP+RB4/0+pGU5XZ2MyANpiYZejzq899YftK02PGc
 xJ+PbTWkjkulA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20230105-wsometimes-uninitialized-pci-ps-c-v2-1-c50321676325@kernel.org>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v2-1-c50321676325@kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Message-Id: <167328295784.323147.10320883556735377893.b4-ty@kernel.org>
Date: Mon, 09 Jan 2023 16:49:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, trix@redhat.com, llvm@lists.linux.dev,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org, Syed.SabaKareem@amd.com,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 05 Jan 2023 17:43:39 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: ps: Fix uninitialized ret in create_acp64_platform_devs()
      commit: de1cae22898cf10aacc735a21d799b5bbce4496c

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
