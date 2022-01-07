Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4941C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Jan 2022 18:26:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 061871887;
	Fri,  7 Jan 2022 19:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 061871887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641579971;
	bh=tsLw6qH+LuSALQHTIjAbk4+AZXCbsB1aP4URIe91FBI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R01b4vuG2ByYccZpm8iU5kwZJ3g+NJsZIOda4s27Si5W8YFU1oT85q3UGgo8BfOcv
	 NLLrmcKOkdIhLThqTLisRtjyz9OVasuVzNxmTBeB89Bh2W7FSp90ssYCEKZDqVsIYp
	 V3scZ2/XOPNd6/8r+2wvJ/q0vTTzeB0R1cHlcLGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 722FFF8014B;
	Fri,  7 Jan 2022 19:25:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3750BF80249; Fri,  7 Jan 2022 19:25:19 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5FD7F8007E
 for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2022 19:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5FD7F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vCNhpVif"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1249C61FAB;
 Fri,  7 Jan 2022 18:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E514C36AE0;
 Fri,  7 Jan 2022 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641579910;
 bh=tsLw6qH+LuSALQHTIjAbk4+AZXCbsB1aP4URIe91FBI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=vCNhpVifNUuhgX/85W6sh+CZPfivQ6JlvPKEoetPaJ7Z4juDaKrkpzXkAUoCb5xlC
 CpfSmgUeApqedpvj+afUhFKtqJN/eH+HL1pCzPpaaLX8i2yXJ7/x5elDGvr+tNyAb7
 XsjIWOk4PGtfXkSfxQ3FAQZtuZPqy8D49pk4M+sq+yKhNw948xAg/ZYhapRycBqnKp
 sl+VBZpugEHLdm2EWeNhCNaXlQeJtddSlpX7OMg2hHtykaPn4H3X4b98eeM7n8UAFW
 mZkRG9MgVjD0pmUnnrqpJvNOEadVscwT1NF7s52wjSj64roN8faDLn0O5yqHJIiJO4
 VB+GclK9aTRSw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20220107160636.6555-1-ckeepax@opensource.cirrus.com>
References: <20220107160636.6555-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] Add low power hibernation support to cs35l41
Message-Id: <164157990887.718238.2102065918969683711.b4-ty@kernel.org>
Date: Fri, 07 Jan 2022 18:25:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 david.rhodes@cirrus.com, lgirdwood@gmail.com, tiwai@suse.com
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

On Fri, 7 Jan 2022 16:06:34 +0000, Charles Keepax wrote:
> This patch series adds support for the low power hibernation feature
> on cs35l41. This allows the DSP memory to be retained whilst the
> device enters a very low power state.
> 
> These patches will cause some very minor conflicts with Lucas's
> currently outstanding work on the HDA version of cs35l41.  Whilst
> things will still build (well now I fixed my silly mistake), this
> patch adds a test key function his code will now have to call.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l41: Update handling of test key registers
      commit: d92321bbe46b0ecae0941461379d39599610d869
[2/2] ASoC: cs35l41: Add support for hibernate memory retention mode
      commit: f517ba4924ad026f2583553db02f3c8bc69de88b

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
