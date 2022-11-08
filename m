Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6B2C4332F
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Nov 2022 11:37:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C24863E8;
	Tue,  8 Nov 2022 12:36:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C24863E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667907464;
	bh=VgqgIoAj2SBmiomdoMM90yhg2jHfgFnU1Eocn1q7GuE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nClU4a08zdY6huEjtGwe4kyfnmCuTj+TDway/UpAFgkWHDz7bxftDLfhRA5exuc7/
	 UWOnUqfxzHdkug/KDTFm12rzFNHtPCal196lGULAJgVIvTLC9qOBP4rxXXk05qFkO3
	 iPVldSupDrTO6j9QnpqhV2v3VQ66hq7s982879rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CA3FF8016E;
	Tue,  8 Nov 2022 12:36:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46388F801D8; Tue,  8 Nov 2022 12:36:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7C8DFF800F4
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2022 12:36:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C8DFF800F4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1667907408658472061-webhooks-bot@alsa-project.org>
References: <1667907408658472061-webhooks-bot@alsa-project.org>
Subject: pcm_old.h does not work with LTO
Message-Id: <20221108113652.46388F801D8@alsa1.perex.cz>
Date: Tue,  8 Nov 2022 12:36:52 +0100 (CET)
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

alsa-project/alsa-lib issue #281 was opened from kkofler:

Applications using `ALSA_PCM_OLD_HW_PARAMS_API` and/or `ALSA_PCM_OLD_SW_PARAMS_API` get miscompiled if they are compiled with `-flto` (GCC link-time optimization (LTO)). See https://bugzilla.redhat.com/show_bug.cgi?id=1910437 and in particular https://bugzilla.redhat.com/show_bug.cgi?id=1910437#c23 .

The issue is that the `pcm_old.h` header uses constructs like:
```c
asm(".symver snd_pcm_hw_params_set_rate_near,snd_pcm_hw_params_set_rate_near@ALSA_0.9");
```
which do not seem to work with LTO enabled. Maybe this needs to use the `symver` attribute instead?

In any case, what happens is that the caller in the application attempts to call the new function `snd_pcm_hw_params_set_rate_near@ALSA_0.9.0rc4` with the ABI of the old one `snd_pcm_hw_params_set_rate_near@ALSA_0.9`, so an integer is passed where ALSA expects a pointer, leading to a segfault (or worse).

The workaround is to compile the application without LTO enabled (which makes it work fine), but I believe that this is an upstream ALSA issue and should be fixed in the ALSA header files.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/281
Repository URL: https://github.com/alsa-project/alsa-lib
