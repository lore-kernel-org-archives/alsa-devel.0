Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09495C4321E
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Dec 2022 17:05:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2A0D16D3;
	Sun,  4 Dec 2022 18:04:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2A0D16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670173533;
	bh=ck5rflBx3FfQDLoWYGE2aQMg+fZAGDUHXRcq7ClZGHI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfoZgBhGpMbOCvP8hmMt3yUrg+Nc6TO5wYJirWxfk5g5ql/A4l7jkbwtyAsFswB3G
	 KoJWMOmnRReMYZadD6KqXsbOxmFTvTF3fwILmKczVhPuTg9KNOTzrQl4RFG+eSFQ58
	 49acNpEgoVYdY7+nT138TV1sSbKpE7fqMehHV3/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C6BDF80155;
	Sun,  4 Dec 2022 18:04:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61D22F8025A; Sun,  4 Dec 2022 18:04:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0201AF800BD
 for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2022 18:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0201AF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Cn4omvvk"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4F8FD60EB7;
 Sun,  4 Dec 2022 17:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B176C433D6;
 Sun,  4 Dec 2022 17:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670173476;
 bh=ck5rflBx3FfQDLoWYGE2aQMg+fZAGDUHXRcq7ClZGHI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Cn4omvvkrWxICxl0+z2L/dVSGXUfY71c0BG8YrnvnFdncD6ePkVzznLW9HGElBiGA
 zgmlyxltfOe5IMJiyRl0ZNdzyhAzw2xehYr1o73j3lqs8yEPFugHn4M3unv/XmZqVP
 1rcvMBj7D5nttNQWaX2akZ0sYgS58Y8ILl1OVXCxUHs+o67akmFA1NW6Mp73MTZIdm
 K59hjyp1i0b3jekOKkRSwnFedwV49Lu6GJmdOMqLYvtb19bs8ZfayctcNkOHO7zxDI
 VKqE1rkDgIPKu7zw6FvAMtelpXnxuIiNbGXtDdgo1xHDFPWRzT3STJPO3Y/VDVIrgD
 7A6Bfd/1tJ7fg==
From: Mark Brown <broonie@kernel.org>
To: Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20221130184644.464820-1-broonie@kernel.org>
References: <20221130184644.464820-1-broonie@kernel.org>
Subject: Re: [PATCH v1 0/2] ASoC/tda998x: Fix reporting of nonexistent capture
 streams
Message-Id: <167017347802.1275554.11223295205961784080.b4-ty@kernel.org>
Date: Sun, 04 Dec 2022 17:04:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
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

On Wed, 30 Nov 2022 18:46:42 +0000, Mark Brown wrote:
> The recently added pcm-test selftest has pointed out that systems with
> the tda998x driver end up advertising that they support capture when in
> reality as far as I can see the tda998x devices are transmit only.  The
> DAIs registered through hdmi-codec are bidirectional, meaning that for
> I2S systems when combined with a typical bidrectional CPU DAI the
> overall capability of the PCM is bidirectional.  In most cases the I2S
> links will clock OK but no useful audio will be returned which isn't so
> bad but we should still not advertise the useless capability, and some
> systems may notice problems for example due to pinmux management.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: hdmi-codec: Allow playback and capture to be disabled
      commit: f77a066f4ed307db93aafee621e2683c3bda98ce
[2/2] drm: tda99x: Don't advertise non-existent capture support
      commit: a04f1c81316d27e140c3df5561e5ef87794cd4bc

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
