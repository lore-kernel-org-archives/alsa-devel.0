Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21160C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 11:50:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD7064E9A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 11:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD7064E9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lesniak-it.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9F0716F8;
	Tue,  2 Feb 2021 12:49:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9F0716F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612266611;
	bh=l3eG3G9HSlGNmjOF2mgI5wIPcmf+254XtJw4G34kNz4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8o2qUJyZ6phalD0K+7rEgPs9lmBQNwkWmgz197SB835f5w7VGW+dRBDOxi0xJb8n
	 A1vs47Aexzf6m4yJfbFUfNfUFtaCmW25GxfYv5xHpv9db3d2+aMXzfh7U7FCehiEWm
	 Wd3DKVLfYUUbxjkHoQN2dqBrYjv0utAXIKWsRV84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67EBBF80152;
	Tue,  2 Feb 2021 12:49:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60620F80171; Tue,  2 Feb 2021 12:49:19 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22060F8013C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 12:49:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22060F8013C
Received: from artex.localnet ([89.247.45.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCKJw-1lGDpq1O7O-009OV8; Tue, 02 Feb 2021 12:49:04 +0100
From: Fabian Lesniak <fabian@lesniak-it.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: usb-audio: add mixer quirks for Pioneer DJM-900NXS2
Date: Tue, 02 Feb 2021 12:49:03 +0100
Message-ID: <1854405.V79DZNnXYO@artex>
In-Reply-To: <s5h5z3ag0pj.wl-tiwai@suse.de>
References: <20210201212248.54364-1-fabian@lesniak-it.de>
 <s5h5z3ag0pj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:XWUYFws695qpp7YZpFi4wOBOuXjgzYMeHsxuMSVfIMGui6HKtbn
 Ge+0vpPkcTKy+xTJcrtQ48gIm1wcJSPByfo9Z07R4Tv1aUPkLpvazHBuIBulsAHwKpibqPg
 xx1xSpQ2AnyI3Y99uekbqGiqLzfQS3VWL2cP75NvH1eo0ILLrActVLB2cXSTCHQkdU1LxZc
 9DH2w1y1YxfE/oXfu0f0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SsAySCPs1eM=:WhRFazipvOKvCL3HpJ2S+V
 R3hQnXMxD+5ZLiYFcPHJZDmlLVA4hGZQZjl5ZdV6mJaPvmLtdfLy3CaENiHTOL3Yf90df8wvp
 LP50t1ZI4M5x68+CkHAgODgIsx8UtH1UUUCuf5f+Zh6doz/Ml+s93ZQNS5Pl0iYDIl6xUaSp7
 PiYele3oFiXNbBQ0PYjNRmthkUKjuhU3vn1PP/6cjTj4AW1HpXlfkDa0/nqJOY9oEkfYaLwDb
 MOgeqE9Mg4LK1NxIDFP0B/pcx+jibPAV9Ce6xLP7crlkmgInGWQqqEPOj6Pn2uynbECOpNbi+
 xyq3xeOJU+zi4eChTMXgEWE3EYEuurc6tvsnqiFPA9ajloosOM66ei2ApeA7AtGdckdLQXNPS
 Z5QFsb4cjnSghRs6KfMoDXpKQhydFvadILYwtL6EocsGBCF69144iXh6/Pbap0wT/tnaAeScf
 WDLTcvW7wA==
Cc: alsa-devel@alsa-project.org, Olivia Mackintosh <livvy@base.nu>,
 =?utf-8?B?RnJhbnRpxaFlayBLdcSNZXJh?= <franta-linux@frantovo.cz>
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

This patch is based upon Olivia's patch "ALSA: usb-audio: Add DJM750 to 
Pioneer mixer quirk" and applies cleanly after that one on v5.11-rc6. If 
Olivia improves the original patch, I will send this one again as well.

If there is some means to express such dependencies between patches, I'm sorry 
for not doing so.

Cheers
Fabian

Am Dienstag, 2. Februar 2021, 12:37:12 CET schrieb Takashi Iwai:
> On Mon, 01 Feb 2021 22:22:47 +0100,
> 
> Fabian Lesniak wrote:
> > This commit adds mixer quirks for the Pioneer DJM-900NXS2 mixer. This
> > device has 6 capture channels, 5 of them allow setting the signal
> > source. This adds controls for these, similar to the DJM-250Mk2.
> > However, playpack channels are not controllable via software like on the
> > 250Mk2, as they can only be set manually on the mixing console.
> > Read-only controls showing the currently selected playback channels are
> > omitted.
> > 
> > This patch is built on top of the DJM750 mixer quirk support and
> > requires it to be applied first.
> > 
> > Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
> 
> Which tree / branch is this patch based on?  It doesn't seem applying
> cleanly either on for-linus or for-next branch.
> 
> 
> thanks,
> 
> Takashi


