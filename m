Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26438C83F14
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Aug 2023 13:10:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A2C4825;
	Wed, 30 Aug 2023 15:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A2C4825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693401054;
	bh=xNeYPaIsp0N2auKe4Qq/fQZICajEY63xgjrSgWhJ31g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=moSbzlvHMmUUFzDl0efu5vtuB2F7I9dC62UGwoQWU/3ZtrrrwG/cHN3L+xOto/19k
	 avqwINidtRJYBaU8L2gR2F+iAWLdK+CWQqJcoyOQwIWNUsjBgViH3HzHwwraEaR9dq
	 RIMziOxeJxeBUyb+N7neG5cwgFUANXfeh5JdxuQg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA6D2F8025F; Wed, 30 Aug 2023 15:09:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54371F80155;
	Wed, 30 Aug 2023 15:09:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64B61F80155; Wed, 30 Aug 2023 15:09:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A8756F80074
	for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2023 15:09:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8756F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=KfadQ7yI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1V1dpfHc
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91A7B1F74B;
	Wed, 30 Aug 2023 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1693400953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuVvhURDtGRQlvTadeA6aCDvBZgXloZzfcYZfjtuzM=;
	b=KfadQ7yIrlUDo2YW9sOO9D5qxJMv8qRcoZQ7ACOzgg6XPfrJ22yJnsnLNcVsta2dwPmpsc
	jc1uqDxLZVH8CPiVodVT5LY8TVdE2kmkuzmWgsLPw8g1/e1F2+o5xLwdAxU6DqBUMfj90u
	AMPsW6DjM9ltvRHKzS8dqv9xiZ4FBCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693400953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuVvhURDtGRQlvTadeA6aCDvBZgXloZzfcYZfjtuzM=;
	b=1V1dpfHcczSnaLtK8dcEzEwlziQ2b1sVXbXN6IbJFbPrJdf87mBPil+65a2eXQ9QwB1yhL
	se1NyP3K/EYjnEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 737D513441;
	Wed, 30 Aug 2023 13:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id G0qzG3k/72QqXgAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 30 Aug 2023 13:09:13 +0000
Date: Wed, 30 Aug 2023 15:09:13 +0200
Message-ID: <87cyz4he2u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	regressions@lists.linux.dev
Subject: Re: mainline build failure due to ace6d1448138 ("mfd: cs42l43: Add
 support for cs42l43 core driver")
In-Reply-To: <ZO8oNb2hpegB6BbE@debian>
References: <ZO8oNb2hpegB6BbE@debian>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Message-ID-Hash: W2NXKXO4Y5BYS33N2VTSRIB6T3ABPXX5
X-Message-ID-Hash: W2NXKXO4Y5BYS33N2VTSRIB6T3ABPXX5
X-MailFrom: tiwai@suse.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W2NXKXO4Y5BYS33N2VTSRIB6T3ABPXX5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 30 Aug 2023 13:29:57 +0200,
Sudip Mukherjee (Codethink) wrote:
> 
> Hi All,
> 
> The latest mainline kernel branch fails to build alpha, csky and s390
> allmodconfig with the error:
> 
> drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
>  1138 | static int cs42l43_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
>  1124 | static int cs42l43_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
>  1106 | static int cs42l43_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
>  1076 | static int cs42l43_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~
> 
> git bisect pointed to ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> 
> I will be happy to test any patch or provide any extra log if needed.

Adding __maybe_unused for those PM functions should work around it,
something like below.  Could you check it?
If it's confirmed to work, I'll submit properly.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] mfd: cs42l43: Fix unused function errors for PM callbacks

Add __maybe_unused prefix for suppressing the build errors due to
defined-but-not-used PM callbacks.

Reported-by: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mfd/cs42l43.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae82..e94b73e6869a 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1073,7 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
 }
 EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
 
-static int cs42l43_suspend(struct device *dev)
+static int __maybe_unused cs42l43_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
 	int ret;
@@ -1103,7 +1103,7 @@ static int cs42l43_suspend(struct device *dev)
 	return 0;
 }
 
-static int cs42l43_resume(struct device *dev)
+static int __maybe_unused cs42l43_resume(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
 	int ret;
@@ -1121,7 +1121,7 @@ static int cs42l43_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l43_runtime_suspend(struct device *dev)
+static int __maybe_unused cs42l43_runtime_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
 
@@ -1135,7 +1135,7 @@ static int cs42l43_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cs42l43_runtime_resume(struct device *dev)
+static int __maybe_unused cs42l43_runtime_resume(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
 	unsigned int reset_canary;
-- 
2.35.3

