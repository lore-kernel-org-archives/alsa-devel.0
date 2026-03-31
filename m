Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C6F10F92E9
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:16:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26D41601CA;
	Tue, 31 Mar 2026 20:16:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26D41601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774980982;
	bh=1On3tkfHtuUqZ42tiX/Gjl/3ZJcPlfdKDseI5KMbl/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NzF8XYywRncn3ZtFUyFd+O92bI818vZd/CAVoW15jdFSNPjv3x13BdXFXkzaVJBUY
	 tJB/44w2WJvhJ8/KHfFrEi6bhLEJwsAl/wJlJvHfNg/qyPgXyS4iag0xcvxq+OxlG/
	 tIQpmIVeRMdjY/tlyA398bqiWl5iE4Exa4CzWj5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79EE3F805ED; Tue, 31 Mar 2026 20:15:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D026CF805F1;
	Tue, 31 Mar 2026 20:15:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76942F805E5; Tue, 31 Mar 2026 20:15:46 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2380F80524
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 20:15:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2380F80524
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UadG3Cj6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 96BF76012B;
	Tue, 31 Mar 2026 18:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A575C19424;
	Tue, 31 Mar 2026 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980942;
	bh=1On3tkfHtuUqZ42tiX/Gjl/3ZJcPlfdKDseI5KMbl/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UadG3Cj6L4Z5uqIWsomnsYZ0S03hIxnhuABS1zQZg/lsFQUSc4rdFd6ZzWwWoMQAI
	 gIX0uzBVhj2Nm8cNHtlFsoF9pFxTmFZLU6Rgpsg1Nn6FTosIKs9WQT7mioLuq0ErSo
	 Uul1o0JweqXEkJ8lqr1fPQkvM/aYYrwRlbhCt6L56xIk8kSVJp2epvD70EVrTyESOA
	 n8POqGs4OjPXC/dxLIC3scKUatVlZ/F5AomIUU9FjMcNx0Lh5sWvsjnLJvVmy35Nx5
	 +MyTNMYu1SZvNKRbJ/eD9zUj4gJBbHBcmwJOVH6jDZA1urIsC6I5RallKPuAvK+kPc
	 XHCwvlLXlQYAQ==
From: Mark Brown <broonie@kernel.org>
To: Sachin Mokashi <sachin.mokashi@intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, pierre-louis.bossart@linux.dev, cezary.rojewski@intel.com
In-Reply-To: <20260327131439.1330373-1-sachin.mokashi@intel.com>
References: <20260327131439.1330373-1-sachin.mokashi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: ehl_rt5660: Use the correct rtd->dev
 device in hw_params
Message-Id: <177495703872.39905.15311038962779078112.b4-ty@b4>
Date: Tue, 31 Mar 2026 12:37:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-3ac6c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1On3tkfHtuUqZ42tiX/Gjl/3ZJcPlfdKDseI5KMbl/U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpzA9MzIesCcqy5Q2j6NfNOjKKNT73PpIzYa+ln
 wU40Kya1tqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacwPTAAKCRAk1otyXVSH
 0B9eB/oD4qGFG6k63uo6Fiffbo59pSZwlBunB0QGGImyonglp7YOBjiyQH0hqCDQM4nLDvyUVYd
 4kOejhfMeKmgyPT5/3GmeEi1ez6yQeP2DJqPF8KDaNcRFjenyW3HjrrJnjBQe0Fkdi64IxoRtfq
 PD9s/nwWGfO9GQzTNSK3Zfb+94BY5L6vqNqWM8RVbsV7LRqxjT6etMleE1GXwfDkP/drCNrsose
 X6GIk3UTr22z3Ua6iEaKcMESzpFSXXCVVQv2r5DfKHf8cp2KbFUmc9VAgwe1IGm5KprOS7Dtt4b
 8ywjU4x1VjPz4yU4oLFlh+dKadoPFhky8t2g2+D8WCS+oJ7I
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: UHLM7ORY5DBFA5RMK6HCGTXIYQHJ6LU7
X-Message-ID-Hash: UHLM7ORY5DBFA5RMK6HCGTXIYQHJ6LU7
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHLM7ORY5DBFA5RMK6HCGTXIYQHJ6LU7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 27 Mar 2026 09:14:39 -0400, Sachin Mokashi wrote:
> ASoC: Intel: ehl_rt5660: Use the correct rtd->dev device in hw_params

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] ASoC: Intel: ehl_rt5660: Use the correct rtd->dev device in hw_params
      https://git.kernel.org/broonie/sound/c/51e3eb3d074a

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

