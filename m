Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E8C61DD6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:10:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57222601F3;
	Tue,  1 Sep 2026 23:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57222601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788296998;
	bh=+OA5vMSMjCEp6/4769qoMYB8eVlYEFpTbyDvApnFha4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e2gkipudB1INTyS1tpIDdELmXEjUJlgOzXlRpgRCM2VjQ6plxKTT1JlsmU2ymYveC
	 9zAIt3lx/VwBCahUt428rYAcMb3okRdRoAZC0FPHTXPSgqrrv0lyCVkvHiZ6O0MZhi
	 yOetQUAmR0yH2NBOnweXhBvnymwxq+N5rmMnK31s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D47DBF80601; Tue,  1 Sep 2026 23:09:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DD34F805F2;
	Tue,  1 Sep 2026 23:09:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D78FBF804CC; Tue,  1 Sep 2026 23:09:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788296954;
	b=ftr2MK4uGDTSE9U7cPH49bpwqI7BWZUsbUbZpwjO/XaI6REBDqNbztdt7WSvsh0PaQ7i
	 X9YyXq3H7s3ZfdrPQDzSi+/uh5w125v1J2NlDNTecGUdwuGC+uYIcszY6uxrVPXSs6ZMI
	 qodmSf7J5mLnZATgbqN8cIkX7Wej9YWSk6vAJusOi8uZOkklPeOD3x9wWA4RZm7Q3vxjH
	 sGqhkDLzK2RrikP5iWTfzVL3igNubrLZYMzB70Qr1O+yF7I/KVYlGMuyn8ONcnPebEW0j
	 +Ob5tn0xZb7MQI8rr2tmbSGXNN5Kx2e2X83YVcNqyM9bnu0dhHzZrXqowHbHN9/Atpg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788296954;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=+OA5vMSMjCEp6/4769qoMYB8eVlYEFpTbyDvApnFha4=;
	b=TFV/tMiwFa2Q/WxjoDHOYa0Zaih21B6bmgUekHQ3pm5PKlxs1x8M42FiseTA8/j2zooN
	 8ID9C0GEyoYNJctzefgRAE0/UkhSnP6BeoDvqyYTfW1hqhAM0CIrxqbfamSAfyzxSRVN2
	 Ud1iaeOIb+Ca0K3zJ1+p+2XDAAhgAyg9dV3Y8/LmtSD7r6I2EtNqigI5riHjW9g7QdVzO
	 hpTfYZhikYG1v2xwvSu4oHlGeUxjOTfihWHulGKeEEDH50B8Z5uoYD6A+FTRV93p6QIuC
	 e1feqtM3vRgT8G2ja8aPrrWmiDzmeJt9imTTLPyK50401ygdq4cuC6Ypz2pHvWbzggw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lYAxlJUC;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4129F801F5
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 23:09:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4129F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lYAxlJUC
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 42B56600D4;
	Tue,  1 Sep 2026 21:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E551F000E9;
	Tue,  1 Sep 2026 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296951;
	bh=EarfI07b4faCMfStMSWv9oifHhmJFDes/d+au4AWdbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lYAxlJUCWZaykVoJN4hEU0N3I1KxHi0USZ/m43FOeKdK4GGIDQFPmAQieeXJ6pbE/
	 XuSNeywBwqSfTtXIyyQoSCYknyPkKwVteTk7ntV704oQvQXqRTsFrjks084U1LmAEt
	 201QtIgrnvbcWEFThyxg6AhXy7ifrWBS5+FnW1ez2f9yMVlPd5+fzaBbGCqTfdhnSA
	 yWcEe42Rnm36mQ8CMQtb5rieZcBgfv+JeMcgkDakLMQaTZ/3uGA6yhKU8sBJnyegsB
	 EAjIve+88fqD9Y4pxJfzxOWoPiZaRYAsZg6Dl02gsL83PuqGGRNEnEetT6l2AK/Ok6
	 sY/PT3A/YLo/A==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, eraleexxx@gmail.com,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Zhang Heng <zhangheng@kylinos.cn>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Tommaso Soncin <soncintommaso@gmail.com>,
 Gustavo Salvini <guspatagonico@gmail.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260901102338.26403-1-syed.sabakareem@amd.com>
References: <20260901102338.26403-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entry for HP 255R G10 laptop
Message-Id: <178828236358.33904.2458159027970109435.b4-ty@b4>
Date: Tue, 01 Sep 2026 18:06:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+OA5vMSMjCEp6/4769qoMYB8eVlYEFpTbyDvApnFha4=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBqlz7xgFRoa0UJ9CO0snX4HCv2QxEE7moASbCJ3
 Wm4fqcLgiKJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc+8QAKCRAk1otyXVSH
 0PJRB/j4ud182qV5LoZYGEDWZ33ioEjymNrgY9z4teQiuSkkmA3E5d6vwFMuRH1NtUuIuKdTi4X
 v64Ngi5GPipb7xVX6EbBGUUAPX4piSSTOvl4cU9H5CMs6sLADb3LHcVZRP8uCM9i5w0n2i251/H
 jSVT/yo3S6yKXbRU9Gw8zdd90MEG2L3l0lOiGgZ8ktwRwErgvOBrfsn54X8uUZq2uqYIFtjrda/
 fg8anNnZKx4noiUrkoQFLdL0PKeVCLM83fip60AElET71LxLJ+0BndCV5JDjkZ/AaB9o0jjaOWx
 U02by+p3qWBCKuZ5zE7r0bOyuvyXuGuGz8qXmSQ6P59NA2w=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: BP72FHZAWCDZN67VGZJEUO4KXM3PEVEO
X-Message-ID-Hash: BP72FHZAWCDZN67VGZJEUO4KXM3PEVEO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BP72FHZAWCDZN67VGZJEUO4KXM3PEVEO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 01 Sep 2026 15:53:26 +0530, Syed Saba Kareem wrote:
> ASoC: amd: yc: Add DMI entry for HP 255R G10 laptop

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: amd: yc: Add DMI entry for HP 255R G10 laptop
      https://git.kernel.org/broonie/sound/c/00aef6b609bf

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

