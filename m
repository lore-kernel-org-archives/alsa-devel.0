Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40333C001B0
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 20:34:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EF9A826;
	Tue,  8 Aug 2023 22:33:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EF9A826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691526883;
	bh=ml8jDgUG2KwsqhNQBURf1IbWBkdHXDt+I7v9LKUEo3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N4GYjUsmya1GtSGH6JwfHAe+8mQHSZI0YSEkf24gy9rPgnpp6cwyKD+4qDXpC1lol
	 UUQ0dp2T64bsmEa61X9KaSOJRnIgFkqy2kSjOftcWdd/DRB0cBzdSF1+3Ibs2CDeZ0
	 PIBYmLFd4mDkdI7Dizs7xwWaZge9Wl6UYbp3C9cQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C34CCF8057A; Tue,  8 Aug 2023 22:32:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 431A8F8056F;
	Tue,  8 Aug 2023 22:32:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A597F80557; Tue,  8 Aug 2023 22:32:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99FE5F80534
	for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2023 22:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99FE5F80534
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Je6zQFJU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 66D9162C87;
	Tue,  8 Aug 2023 20:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D474C433C9;
	Tue,  8 Aug 2023 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691526766;
	bh=ml8jDgUG2KwsqhNQBURf1IbWBkdHXDt+I7v9LKUEo3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Je6zQFJUmgtb/KUhwwLqn3dU8EsvFxXdv8Jx9vwP9NujqK7rNlVkk8wWQ8BTFlQix
	 4Dbp2r/K/uhJBK/GyiRYDhrOBdk4ed5QSuYwqiv3SY/3OVtHR3FAP64XCv4Q0JvUKC
	 ZFhrFeZuVZH0uSl+GG/Ywp056W9to41drxEP9ebGECHjYU4J2D8G6Aq5Zf5g6/SdLn
	 B/pe6m7OEOrhfWDi1vMZfbhdO1Uov400U7Zb0EQl203RXR7C20Wm3Dciq06NhYSbpc
	 vkwZHfhJF9Zpe6oCO087sGnrQE111QpP9H4IjN6olMsTwVMHycDkhvcS6tI2e7nid1
	 y8nFSc1Z/CkIQ==
From: Mark Brown <broonie@kernel.org>
To: Weidong Wang <wangweidong.a@awinic.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230808125703.1611325-1-arnd@kernel.org>
References: <20230808125703.1611325-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: aw88261: avoid uninitialized variable
 warning
Message-Id: <169152676489.192712.6832901777571090965.b4-ty@kernel.org>
Date: Tue, 08 Aug 2023 21:32:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: JY2OF4DVIUEVIOKQHOZAFWMG7N4G6WNI
X-Message-ID-Hash: JY2OF4DVIUEVIOKQHOZAFWMG7N4G6WNI
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JY2OF4DVIUEVIOKQHOZAFWMG7N4G6WNI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 08 Aug 2023 14:56:54 +0200, Arnd Bergmann wrote:
> aw88261_reg_update() returns an unintialized error code in the
> success path:
> 
> sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its condition is always true
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88261: avoid uninitialized variable warning
      commit: 87b56172431bc2e8c497d2f10ee8245313167bd9

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

