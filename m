Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C5C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 15:49:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6177D61B66
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 15:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6177D61B66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FBD91F0C;
	Tue, 27 Jul 2021 17:49:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FBD91F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627400991;
	bh=qeFjoGXtsM0UG2sIzpn+TpGKqYiJO8llu5W6BinX7Gg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bGOso94E0wu732Gt11nN0u3vD7jZvjVxBGfdP2/tr7/F2xdBfDGLlr5Y8k0CvHVtI
	 Gu+K7l+aVNzqnXOG/s5i6Gi8V8DcqLGalqmbtBbgdM1dmWGV/RuSTHlH/BlIAqD5A9
	 iMkcZdnQDHq+qZliRTbL39bxk06Km4nsmeTiHx34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E1EFF80276;
	Tue, 27 Jul 2021 17:47:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3142F8027C; Tue, 27 Jul 2021 17:47:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAE0DF804F1
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 17:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAE0DF804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bAgT/OD+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D396261B60;
 Tue, 27 Jul 2021 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627400847;
 bh=qeFjoGXtsM0UG2sIzpn+TpGKqYiJO8llu5W6BinX7Gg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bAgT/OD+2nY0sUv3SUrFtqIQVK3FzII8/QXQarIivuJVkzJfOAzNIOLSFDj90zBcQ
 sD6ywpHbLg6/t9pJzXoBArtbZ+3WwZR9EGVGR/BVf3uI33zQ4MN4+LqabJT6cgLzUG
 Bm9dFFx5Aor7qifB/USSgpFPOH/Op7amLMVVjnkGE9WnsIvNQrFs12dmhAU0LuGqh5
 V+p0TB9qz7dumjq0kBUXpKNDnuXmaYjRSPyrGBpkBbeE10MNvZSeGZvWHGrbBNYQsb
 OZ/QYJIcGsaMXihqeoPy5XfPBc0lXkYASAQYl7S/9f4mhh4FvMuZ4P6OUysAyTo9u5
 IuC1PJr0Dr4hw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: enforce exclusion between HDaudio
 and SoundWire
Date: Tue, 27 Jul 2021 16:46:28 +0100
Message-Id: <162739969149.18968.5796411375941420278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210726182855.179943-1-pierre-louis.bossart@linux.intel.com>
References: <20210726182855.179943-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

On Mon, 26 Jul 2021 13:28:55 -0500, Pierre-Louis Bossart wrote:
> On some platforms with an external HDaudio codec, the DSDT reports the
> presence of SoundWire devices. Pin-mux restrictions and board reworks
> usually prevent coexistence between the two types of links, let's
> prevent unnecessary operations from starting.
> 
> In the case of a single iDISP codec being detected, we still start the
> links even if no SoundWire machine configuration was detected, so that
> we can double-check what the hardware is and add the missing
> configuration if applicable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: enforce exclusion between HDaudio and SoundWire
      commit: 61bef9e68dca4316e1fc5fdf5f0c270bdbd65657

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
