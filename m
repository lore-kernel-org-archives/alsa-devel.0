Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F5DC001E0
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Aug 2023 14:34:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40292826;
	Thu, 10 Aug 2023 16:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40292826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691678072;
	bh=IKeq5Z2PbwGi23k/nvlp7YWjgFV2LYLVb7jhG7tG1lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g3uSG+DHkUH93a3UOB6OZ6frh85IStdKgBmKQz5NbJGTvWWRnvGjvtM1AToLjKeoh
	 lLgU/VztT1sb+ekaRiYI2X5yVDwk2aDY4uqg3g4DU9ujLJDHLHBQQ03mapZrNAhQOB
	 X5PcUOqBOAXsbg3ymFg0Mg7gBXuOV51llcXhFfrc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2D63F80558; Thu, 10 Aug 2023 16:33:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C105F8016E;
	Thu, 10 Aug 2023 16:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED2AEF8016E; Thu, 10 Aug 2023 16:33:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8634AF800EE;
	Thu, 10 Aug 2023 16:33:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8634AF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QbrDaeXc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1889362B5D;
	Thu, 10 Aug 2023 14:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7B6C433C7;
	Thu, 10 Aug 2023 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691678004;
	bh=IKeq5Z2PbwGi23k/nvlp7YWjgFV2LYLVb7jhG7tG1lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbrDaeXcavNd7O6sJOBertdJqILy71c2hhn2rB/wwEj8QW3rxy7TXvVe6NovYdA1B
	 O0XO1sJAHzH18kOm7Vyi7m59Qir3sVomJ/bCV0iwnWfrXFw0ZzyGChQ3RrAKUDmb4E
	 sHLt4D/mo6IIIuxi/BxLUTwtN9U7uaG8VRGQTgmbHdttTsBiURo3cGv1Xy024RBYP9
	 fzCcztjzVYyEqUdi95AVqEYqlsVzfdQSDfOSZA0YCqgb47K3R2dS8XAqaoQrsTsjZi
	 9ACHR0ImHce4PkFNASr13ujsCbtyYj0mBdS8WLgFx7XL2F8NwvdmylvkiFKBzipbYy
	 SOubf9/oAuxoQ==
Date: Thu, 10 Aug 2023 07:33:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
	ndesaulniers@google.com, trix@redhat.com, rander.wang@intel.com,
	sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] ASoC: SOF: Intel: Initialize chip in
 hda_sdw_check_wakeen_irq()
Message-ID: <20230810143321.GA1549244@dev-arch.thelio-3990X>
References: 
 <20230809-intel-hda-missing-chip-init-v1-1-61557ca6fa8a@kernel.org>
 <8eed2099-2853-df8d-92db-921d0702f512@linux.intel.com>
 <20230809190212.GB3355565@dev-arch.thelio-3990X>
 <2a2de1b5-4dd5-f170-bb0b-61d39230c3a7@linux.intel.com>
 <20230809200906.GA4016444@dev-arch.thelio-3990X>
 <d224ef41-373f-186b-1ba2-86f00ea8fbce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d224ef41-373f-186b-1ba2-86f00ea8fbce@linux.intel.com>
Message-ID-Hash: RMZMJCK2LJLU26NAD2APQTLH3QJ6AH2D
X-Message-ID-Hash: RMZMJCK2LJLU26NAD2APQTLH3QJ6AH2D
X-MailFrom: nathan@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RMZMJCK2LJLU26NAD2APQTLH3QJ6AH2D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Aug 09, 2023 at 03:42:44PM -0500, Pierre-Louis Bossart wrote:
> 
> > Ah, I still think you will need to pass CC to make directly, rather than
> > through the environment but you should be able to prevent
> > merge_config.sh from getting in the way by passing '-m' to avoid having
> > it invoke make itself, then you can add a 'make olddefconfig' step after
> > that, perhaps something like this?
> > 
> >   - name: build start
> >     run: |
> >       export ARCH=x86_64 KCFLAGS="-Wall -Werror"
> >       export MAKEFLAGS=j"$(nproc)"
> >       bash kconfig/kconfig-sof-default.sh -m
> 
> The -m doesn't work since it's added last, but it's not even needed. The
> sequence below re-adds clang, that's just fine.

Ah right!

> >       make CC=clang olddefconfig
> >       make CC=clang sound/
> >       make CC=clang drivers/soundwire/
> >       make CC=clang
> The fun part now is that I get tons of unrelated errors - but at least
> that's a sign we're using the clang compiler

> sound/pci/hda/hda_bind.c:232:18: error: format string is not a string
> literal (potentially insecure) [-Werror,-Wformat-security]

Heh, I suppose that is somewhat self inflicted with the '-Wall -Wextra',
as '-Wformat-security' gets re-enabled after being disabled in the main
Makefile. May be worth sticking a '-Wno-format-security' back on there.
Glad to hear that it is working now and thank you for testing with clang
to help catch issues before they make it to a tree :)

Cheers,
Nathan
