Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33102C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:49:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB202611CC
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB202611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1D49186E;
	Tue, 16 Nov 2021 18:48:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1D49186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637084951;
	bh=1305OtawCUzVyN9m8G+QJxi5mVeDe4M1jxp0hLgPpls=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxgoaS6UnEIvWJXOCetPDKxcmCJeIOyQQAKDgLUZMZiXICh/c9H3X7OJO7ndAC+Ug
	 J0e19hKMPGqUgIdMxaro0iK2c6H9tyhtgEhJzzfzBWr+q2kqz7ChVppNopayEqnPTI
	 745UWVLY5uIDPEHxodGBqjhHx/lVQs4ASGK9NjjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53BEEF802C4;
	Tue, 16 Nov 2021 18:48:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB052F80272; Tue, 16 Nov 2021 18:48:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DCF8F80089
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 18:48:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DCF8F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fOvbFbjq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1E1C61465;
 Tue, 16 Nov 2021 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637084890;
 bh=1305OtawCUzVyN9m8G+QJxi5mVeDe4M1jxp0hLgPpls=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=fOvbFbjqZnJrOcKfsKFVgVSNIwP1m8IMPuGskmkEsvpxiS6W5Y1ZjwxmKz9XgpCj8
 K8Uzs9ZPd3wTH0hpl/CHylKukxk6slU11dvhDDyl0LjQgGiO2G1MW0XlFBgjJJzNee
 GosTp4ubivTIrRDPjbnoqpPvI4W55u2q/sEo350jnfOPoPTqwyaM1dzVtGV0IqRtJy
 R5FThxSfMx1R9itIGEKjzetE1Wjl/onXm1ecqi+GK3AFzbDkKiPy97zaWjiDgmzTIB
 6Iiijs2VMuUvBC9/CeClc/7SPVlXYRA6R+JDRwf0gTos/byskm3/rBnVnY6/XxsPRA
 MNIoJQZ1XEaWQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
In-Reply-To: <20211116071812.18109-1-tiwai@suse.de>
References: <20211116071812.18109-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: topology: Add missing rwsem around snd_ctl_remove()
 calls
Message-Id: <163708488958.808719.11832099817956624987.b4-ty@kernel.org>
Date: Tue, 16 Nov 2021 17:48:09 +0000
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

On Tue, 16 Nov 2021 08:18:12 +0100, Takashi Iwai wrote:
> snd_ctl_remove() has to be called with card->controls_rwsem held (when
> called after the card instantiation).  This patch add the missing
> rwsem calls around it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: topology: Add missing rwsem around snd_ctl_remove() calls
      commit: 7e567b5ae06315ef2d70666b149962e2bb4b97af

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
