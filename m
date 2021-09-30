Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFDC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 19:41:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5185C61A0B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 19:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5185C61A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D15716B0;
	Thu, 30 Sep 2021 21:40:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D15716B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633030877;
	bh=hGWo5HXsnHZZeJfns2xmrslBSvmFMMlZ9maHX9plNvU=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EOalaflwcVznWIdqflnv/hAuBRT/+U1aSn5x7raK+CIpq3ut1i5c62bD3wnJAoqah
	 f2hM5WmwnsP6ap+znIeYNEvExkdtw7jdPuNMxQHwHyQR1BLT201yR6OUOCQum3GbDc
	 wprzpMIswoHncz5YLzLMscvrrL5zHnxa5Ep28ADc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E4EF80218;
	Thu, 30 Sep 2021 21:40:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4722F804AD; Thu, 30 Sep 2021 21:40:23 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADA5DF80218
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 21:40:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADA5DF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kHC7GVlk"
Received: by mail-vk1-xa34.google.com with SMTP id x207so3436367vke.2
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=r4IQajFARE7AcwggSm5zaTXDvt4Je3KIStkMiNqkVa8=;
 b=kHC7GVlkQWyvh9A8tuLXP/XaGrBuPO8twka2zDMUjbW94dKe2BmR2c9VbLgbV6ZjWA
 1bnmUyD3Dr4bs5KVXqFXJt74B0s3wuf+lj90loYlzVWDcMn6Ac5x3rcZmbqZUhMwSVKj
 bcluexBV3rqAEr0LkmwzURrvWBMfpnIt3A/XNVC23b7XmjK2YoqvJk2sSrQsgCV/JW8X
 4helBaQrd6pVRUxicGQ1AAhCb3ro5W1U1Um0wZcm53sjSb5d1w+exnW1njlNTpbRpH6X
 EAdEXFbF/l7xP4YKtPT0Nv/nLH14qNdUWGyCQp/ZADNo85+wf9jlwMIFlFnahrFZ62aI
 v/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=r4IQajFARE7AcwggSm5zaTXDvt4Je3KIStkMiNqkVa8=;
 b=kAgyzp6lAJNkHbu9sRXfP9ERo3d9YwFFNu8O+uMkikTbXwT2wwqQfpjTUOzbqlRfPN
 Vo0QamilJtiTmRYQdfxarPgZdHB9WeZ1thatsHO1PkmPqvIyrkHQrOuWiVBc8z+bvTGH
 MRznLokzhkev8TviZfFB8E/58KfHEAawZXMC3mZZD6Fjv5CVfq+7LV6WmwNz9ZUSnlXq
 +RRan7mc2k0XeLHvmHv7kyioaqwDYiMvT0eIFgvKBUvkJXUAJaVK1eByCOWsC66Kij6B
 j5e3VoiNgpazAp8EgWt7RawxNs0vSVav0kFw2rf1toKE53LrRsWQ7CX1SApjMdZJtEsZ
 /isg==
X-Gm-Message-State: AOAM531eVFHTvxuotkgFJVc56gCE62iiOARuo4RnHrA4yJaaX9RnTPmH
 diQJ4HNi8OANUJbsXAqbsRw=
X-Google-Smtp-Source: ABdhPJyB3XN1Eyk8Pp9zJ8musZhobfLksEm/q7Ro8rWSJkwLu1jKnRqOBpduDowN35R5+UKnfOwQsg==
X-Received: by 2002:a1f:abc9:: with SMTP id u192mr6264396vke.17.1633030816619; 
 Thu, 30 Sep 2021 12:40:16 -0700 (PDT)
Received: from geday ([2804:7f2:8280:7522:98f0:31ff:fe93:2dc7])
 by smtp.gmail.com with ESMTPSA id q26sm2156867vkn.40.2021.09.30.12.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 12:40:16 -0700 (PDT)
Date: Thu, 30 Sep 2021 16:40:14 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: disable implicit feedback sync for
 Behringer UFX1204 and UFX1604
Message-ID: <YVYSnoQ7nxLXT0Dq@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org
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

Hi Takashi,

Hopefully you will be able to apply this cleanly to branch master of your
sound.git.

Thanks!
Geraldo Nascimento

---

Behringer UFX1204 and UFX1604 have Synchronous endpoints to which
current ALSA code applies implicit feedback sync as if they were
Asynchronous endpoints. This breaks UAC compliance and is unneeded.

The commit 5e35dc0338d85ccebacf3f77eca1e5dea73155e8 and subsequent
1a15718b41df026cffd0e42cfdc38a1384ce19f9 were meant to clear up noise.

Unfortunately, noise persisted for those using higher sample rates and
this was only solved by commit d2e8f641257d0d3af6e45d6ac2d6f9d56b8ea964

Since there are no more reports of noise, let's get rid of the
implicit-fb quirks breaking UAC compliance.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 23767a14d126..70319c822c10 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -54,8 +54,6 @@ static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
 
 	/* Fixed EP */
 	/* FIXME: check the availability of generic matching */
-	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0001, 0x81, 1), /* Behringer UFX1604 */
-	IMPLICIT_FB_FIXED_DEV(0x1397, 0x0002, 0x81, 1), /* Behringer UFX1204 */
 	IMPLICIT_FB_FIXED_DEV(0x2466, 0x8010, 0x81, 2), /* Fractal Audio Axe-Fx III */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0001, 0x81, 2), /* Solid State Logic SSL2 */
 	IMPLICIT_FB_FIXED_DEV(0x31e9, 0x0002, 0x81, 2), /* Solid State Logic SSL2+ */
