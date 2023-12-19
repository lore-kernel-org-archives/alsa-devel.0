Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF48BC41535
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Dec 2023 17:39:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE336E8A;
	Tue, 19 Dec 2023 18:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE336E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703007570;
	bh=eFRmerzRNKjJBzWoDTVYuFuo2sn+SGeuk2TedMpv6h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tjg0iahnDcEGoFrjlGixKkw2MCKQbl/TO+keUVqJe9hQQeHLwHzfLnVHUQhEAagVW
	 Wdz/pDF0Fzx6GQyzuVbOCvRev9hcfITdTOJjml35v4YfToVJNWijJqqza5zKqLczFO
	 6xy0XxHshOvzwpBbY7fsWc3i7r6VnIwA5QyMvbwM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C8FBF8056F; Tue, 19 Dec 2023 18:38:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14DCDF8058C;
	Tue, 19 Dec 2023 18:38:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11030F8055A; Tue, 19 Dec 2023 18:38:55 +0100 (CET)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 883F8F8057A
	for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2023 18:37:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 883F8F8057A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=b4.vu header.i=@b4.vu header.a=rsa-sha256 header.s=m1
 header.b=dndQ2jbx
Received: by m.b4.vu (Postfix, from userid 1000)
	id C4771604B9F7; Wed, 20 Dec 2023 04:07:52 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu C4771604B9F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1703007472; bh=MhoIaixpik1iUNQTcsUyfLxvHJVzpPig+kV+sgoyrFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dndQ2jbxuzrpogsvzNNG1rKGRTJVLQ+bk1KG4wUT0CwmXAhvvOHsrJ1o2fbr/jp/H
	 xFqv2k/7SMQQ7St6iunL7OyEvOzTP5K918cV1e47/RHs8cVb/6BrFl65qs/DhXsDTz
	 mm9qZhZyxAWpaWizhkM/A7lrPqwawQifWfi1Cu1s6I706rB4nAn57vtLT/el+5GvBC
	 OmlcrJhq8wcNU2gwER6r6Js6Rn/ISWNKVeXz6vuUdW1H8F/ejD2KH+W7+zBeOKfEMY
	 6cF76oOA6X91eouHojc186I5vHnKAGh9VD6O+g30TZ5XHBhJnqEPwucSe5OF69CI3L
	 NwCtgr0sS4gLw==
Date: Wed, 20 Dec 2023 04:07:52 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: [PATCH 05/11] ALSA: scarlett2: Add clamp() in
 scarlett2_mixer_ctl_put()
Message-ID: <3b19fb3da641b587749b85fe1daa1b4e696c0c1b.1703001053.git.g@b4.vu>
References: <cover.1703001053.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703001053.git.g@b4.vu>
Message-ID-Hash: MM44SESBU3CANCS45TAOQAGLYRJZXHUT
X-Message-ID-Hash: MM44SESBU3CANCS45TAOQAGLYRJZXHUT
X-MailFrom: g@b4.vu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MM44SESBU3CANCS45TAOQAGLYRJZXHUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Ensure the value passed to scarlett2_mixer_ctl_put() is between 0 and
SCARLETT2_MIXER_MAX_VALUE so we don't attempt to access outside
scarlett2_mixer_values[].

Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
---
 sound/usb/mixer_scarlett2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 373911937487..f1636a1614da 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -3663,7 +3663,8 @@ static int scarlett2_mixer_ctl_put(struct snd_kcontrol *kctl,
 	mutex_lock(&private->data_mutex);
 
 	oval = private->mix[index];
-	val = ucontrol->value.integer.value[0];
+	val = clamp(ucontrol->value.integer.value[0],
+		    0L, (long)SCARLETT2_MIXER_MAX_VALUE);
 	num_mixer_in = port_count[SCARLETT2_PORT_TYPE_MIX][SCARLETT2_PORT_OUT];
 	mix_num = index / num_mixer_in;
 
-- 
2.43.0

