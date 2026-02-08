Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F64AEF06EE
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Feb 2026 21:22:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB9E601FF;
	Sun,  8 Feb 2026 22:22:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB9E601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770585748;
	bh=wG2Czxba3jBUtDYEP03z3BSVfH9BgzaCkKXFXxUgMJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dmci0U3YQz9IG2wNZQ86Bb1Q0xdr0fIzjMa6wC1Iwm4GhBhOytFCXlA7uJBjTbo1P
	 CqgJkHGQTPsHZoWXHLfsymBj9iXa39+E0wjV4IUX7psQLK3AHU7tdq5gaGeRP4hdtS
	 mQBxtM91NmO/0gQIQRtqVY09+LJH9ameJPnnrmeI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B177F805E1; Sun,  8 Feb 2026 22:21:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82E4EF805F2;
	Sun,  8 Feb 2026 22:21:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CAD7F8047D; Sun,  8 Feb 2026 22:21:45 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3244CF80093
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2026 22:21:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3244CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R1CcVF7g
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F15B600BB;
	Sun,  8 Feb 2026 21:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CDDC116C6;
	Sun,  8 Feb 2026 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770585695;
	bh=wG2Czxba3jBUtDYEP03z3BSVfH9BgzaCkKXFXxUgMJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R1CcVF7glaSQlsj4cJPcbz2Pfi307Gbd5Uop6i5Leauixn7BNQWSmBeffXulMzbqA
	 0hh9xJNPNas6af2dS7acY93EqSpqExY4S4glYAWfNIWHGJmBo0t8vj9/3PdIK5PQAW
	 Qza4KAxB5F6x5XhDm9eCL1qgIw5Bdv+f+jmsh5gh7ju1WaNccOsrLyGZKJts7QJIdj
	 QdUM4IgktDX0xTW/9HFYqjcxEme/D+QZcwiWG/k3NkKwmv/IgJZvrqqEWUy8NNzxaJ
	 aoXVXvYSf0fV+SjBydukAWMKl3Fpb1DAkfk+JbEDebF2goDqPDEmB3UUPVPEl1vV+R
	 CtUnhVRxMED5w==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, mario.limonciello@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260207062433.1465232-1-Vijendar.Mukunda@amd.com>
References: <20260207062433.1465232-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: maintainer information
Message-Id: <177058569295.654564.1440552951713342235.b4-ty@kernel.org>
Date: Sun, 08 Feb 2026 21:21:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: CLR5FDCKYWU2VQLHPCRH5EIDYY6I3MQ5
X-Message-ID-Hash: CLR5FDCKYWU2VQLHPCRH5EIDYY6I3MQ5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CLR5FDCKYWU2VQLHPCRH5EIDYY6I3MQ5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 07 Feb 2026 11:53:51 +0530, Vijendar Mukunda wrote:
> Update MAINTAINERS file for AMD ASoC drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: maintainer information
      commit: 77d31948a88368f1e8516cb74614ab2e0340e840

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

