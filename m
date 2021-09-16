Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7FC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:17:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BD361246
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84BD361246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2078F187D;
	Thu, 16 Sep 2021 17:16:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2078F187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805427;
	bh=/AKMHzTSPVI/qO/ETd5TIGSPS0Fx+JquISeWLW/PHP4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IOohv8KSZmG4lqeCpwxmHUnpUhOTPlErHtqKY8ogrNfgJ8OWa/kOnUpFyVFbERCKv
	 OUdqJWDnCUlueG26yJ61YSiF5PkPGYMqaMRAAq5wykTKSUMD+L+P35hmyDShnQ6Aae
	 /Qc6RtVWT5k0zQVMf2JUVtj2zG0SRSJTPqWX3KeE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05E9BF804AE;
	Thu, 16 Sep 2021 17:15:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59244F80271; Thu, 16 Sep 2021 17:15:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27FC6F8025E
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27FC6F8025E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QoQUKAAQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5722861216;
 Thu, 16 Sep 2021 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805325;
 bh=/AKMHzTSPVI/qO/ETd5TIGSPS0Fx+JquISeWLW/PHP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QoQUKAAQnGEPoA54WXjwVRuEdCxBnpTVrOEsmGt6u4qR0Vu33efC6J647/slHeE75
 3VRh6X7z2qDJpZ/jUsey/XPj1mesb2MwQNm6vXIRzHH6X/T+sfXVDu6fDKwkkA4ydz
 BWI2ac0+uYEAp6lbPQmX4sztj12H3LH01K8bOv6e/k+UT/bPGrmBgF0Vs7Mn2QzW2v
 w3nSzPlERfMqsMEtK4iQFKAWjbzMQgNRT3xND2Dc4k0/mlyxEwZDc52Wua1jTJcuYe
 b7ds1d/bs1z3SAs4xIi0Kt7JIECKhMeFgQhaGtNh27eNMrxA/l3qu0eW8cxcQZ33pi
 s0z3E/8/cLu2w==
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
 Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as
 fallback
Date: Thu, 16 Sep 2021 16:14:31 +0100
Message-Id: <163180495858.19842.9757319545626804609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
References: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Thu, 16 Sep 2021 11:27:49 +0100, Vitaly Rodionov wrote:
> For some headsets CS42L42 autodetect mode is not working correctly.
> They will be detected as unknown types or as headphones. According
> to the CS42L42 datasheet, if the headset autodetect failed,
> then the driver should switch to manual mode and perform a manual steps sequence.
> These steps were missing in the current driver code. This patch will add manual
> mode fallback steps in case autodetect failed. The default behavior is not affected,
> manual mode runs only when autodetect failed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Implement Manual Type detection as fallback
      commit: 12451814496a5433f41843ca4e3d9961d69304f7

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
