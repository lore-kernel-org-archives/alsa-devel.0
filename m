Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6129DC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:09:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FEA20720
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h6ntvYFG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeCRAKIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FEA20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF851679;
	Wed,  1 Jul 2020 23:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF851679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593637777;
	bh=fq+fEdQv1Ek5cFnDpPZH/y6XwxuMeajVPcMR6ltNaVg=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h6ntvYFGZAUY+NalUthqMSu/CexHpGCntKWpUbYDE0gZ6wIl8az+1cKuTA5yhYbRd
	 n1KO6UUCdrOyy7q+sMWZ9np3u2otIPuzbyHGLsp/ubj6ImXc+eARhz+rQ+zQbU6snL
	 9GY2uJRQNXqbPP79PT3Cr1hZThyT+0ghsoeqIliQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDBF2F801D8;
	Wed,  1 Jul 2020 23:08:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68DFFF80217; Wed,  1 Jul 2020 23:08:45 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E095F801D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 23:08:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E095F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="OeCRAKIe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=n3MhCVUc4stdpN2Qe7L9WDOpNOr9JzTLo6XaZBRTMak=; b=OeCRAKIekfVonveM23MX3a487K
 UPN8c7BE8HI2uqDE+mA9j98eCqcctiz8v2eYUtiRId40gw/y7BJsyNolh76MzPA3QmGUUloXYxweG
 cce+/+4/TzWzTYcu/4s2K6s6iM/d5t6ryPgBDidii8xI+IMu7Z80Sj6waidY3Y5XOSsChg24/DeuB
 K0dvhrX65yKSWLeTERVnh7xLktIfWe+CsMIg+S3hwJvV3DOIKkgoTwOhBiRzWr4sSrnFVZ3ZoGC6X
 oD5OKjv/KluHFb4tvDKXFb11RIdHi+LXchW7GZTnjxuM6JFavRfGr4SBWTYU/mbARVRWOaKZhQFkI
 h7JTHOpA==;
Received: from [2601:1c0:6280:3f0::81af]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqjxz-0000hb-LV; Wed, 01 Jul 2020 21:08:27 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] sound: fix SND_HDA_GENERIC kconfig & build
Message-ID: <01233744-9625-38b3-0342-1b37250dbc72@infradead.org>
Date: Wed, 1 Jul 2020 14:08:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warnings and lots of subsequent build errors by
adding yet another ugly select statement:

WARNING: unmet direct dependencies detected for LEDS_CLASS
  Depends on [n]: NEW_LEDS [=n]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]

WARNING: unmet direct dependencies detected for LEDS_TRIGGERS
  Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=y]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]
  Selected by [m]:
  - MAC80211_LEDS [=y] && NET [=y] && WIRELESS [=y] && MAC80211 [=m] && LEDS_CLASS [=y]
  - IWLWIFI_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_INTEL [=y] && IWLWIFI [=m] && (LEDS_CLASS [=y]=y || LEDS_CLASS [=y]=IWLWIFI [=m]) && (IWLMVM [=m] || IWLDVM [=m])

WARNING: unmet direct dependencies detected for LEDS_TRIGGER_AUDIO
  Depends on [n]: NEW_LEDS [=n] && LEDS_TRIGGERS [=y]
  Selected by [y]:
  - SND_HDA_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_HDA [=y] && SND_HDA_GENERIC_LEDS [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/hda/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200701.orig/sound/pci/hda/Kconfig
+++ linux-next-20200701/sound/pci/hda/Kconfig
@@ -221,6 +221,7 @@ comment "Set to Y if you want auto-loadi
 
 config SND_HDA_GENERIC
 	tristate "Enable generic HD-audio codec parser"
+	select NEW_LEDS if SND_HDA_GENERIC_LEDS
 	select LEDS_CLASS if SND_HDA_GENERIC_LEDS
 	select LEDS_TRIGGERS if SND_HDA_GENERIC_LEDS
 	select LEDS_TRIGGER_AUDIO if SND_HDA_GENERIC_LEDS

