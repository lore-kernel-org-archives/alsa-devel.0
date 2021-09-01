Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95044C432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 18:18:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FAB61053
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 18:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09FAB61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2F0B1795;
	Wed,  1 Sep 2021 20:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2F0B1795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630520296;
	bh=TCwn2zHhiNl+xNHKQcLyVHNlG5BPP37Mw+e4SSsNapM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXlAap6u/NU1cCuuxKyhiHJHNncbGhu8BAiotEvHUqyb3dCyk300kmAxNhT4AnFE+
	 osvRYjbcFA+ateCP9/M5QVTNkBccBzKUV8wcNnfQYkte3aHJU0EnB8+8mXRVTPI77q
	 qeJPNXP4o5DfUkP02IIkC3avDmBOlPReKZOfZLlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56529F804F3;
	Wed,  1 Sep 2021 20:15:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C086F804ED; Wed,  1 Sep 2021 20:15:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44311F804C2
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 20:15:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44311F804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="G2gV7lHN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62AF8610D1;
 Wed,  1 Sep 2021 18:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630520132;
 bh=TCwn2zHhiNl+xNHKQcLyVHNlG5BPP37Mw+e4SSsNapM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G2gV7lHNxAGxVARGb0Vdi9l3Mw/rl2Q+pVXYxxNtlbGoPPgv27fX6nC9ZoVz5wwCI
 8lXhoaH8CoDYuARL9pBQcEUG64TQOsQTYYf5glOmrSeopTRP3Myvo++a0IiIbtXn4a
 mjWgK0+SNiHyRr5UHYmXHVrH7pTFN66c7kI91jGS44YimaSIA9cIE5kBjyErDxVbFy
 qiYyMGJIFgSlprBelp8KjDWMjLBXxVqkZxaJApyqRKdqPWzwb2ckbphGEwQb0o6Asm
 PPGWJmj+RGXunbbIa68WZ3m2frSR6w06QzL81JUYuFcQGCWGl9u0cXyipNDBoFE746
 QsArmL1qH3+6A==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph: respawn Platform Support
Date: Wed,  1 Sep 2021 19:14:46 +0100
Message-Id: <163051912510.21630.17622384259619987053.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <878s0jzrpf.wl-kuninori.morimoto.gx@renesas.com>
References: <878s0jzrpf.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Olivier MOYSAN <olivier.moysan@foss.st.com>
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

On 30 Aug 2021 09:44:44 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit 63f2f9cceb09f8 ("ASoC: audio-graph: remove Platform support")
> removed Platform support from audio-graph, because it doesn't have
> "plat" support on DT (simple-card has).
> But, Platform support is needed if user is using
> snd_dmaengine_pcm_register() which adds generic DMA as Platform.
> And this Platform dev is using CPU dev.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph: respawn Platform Support
      commit: 5f939f49771002f347039edf984aca42f30fc31a

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
