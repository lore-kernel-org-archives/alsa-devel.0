Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82749CD13D3
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:46:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D4C160203;
	Thu, 30 Apr 2026 21:46:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D4C160203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777578391;
	bh=Z65HuvkSduOCrkCG8UyMp5Za7OzOF51Vd2dzXugqkrI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AT5T5R1GV7CaGQtqOyBnao7OhQYC53DA8Drm4rfAHVh7auG97vuLW1arMUceIy1t9
	 N3szq+gzGki2oNajmzWY+9RRDeePP3jbQUL+3Gj9Im7CzHWHh5HvrF5y7qnuWaLWsc
	 Ao7wEVMi26UmFmCOhvRthzxFSu0BPlGKmm58vz8Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D69BBF805EC; Thu, 30 Apr 2026 21:45:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A60B3F805F2;
	Thu, 30 Apr 2026 21:45:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80BB1F802BE; Thu, 30 Apr 2026 21:45:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0733AF80154
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 21:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0733AF80154
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ab3a173416f000-webhooks-bot@alsa-project.org>
In-Reply-To: <18ab3a173409b400-webhooks-bot@alsa-project.org>
References: <18ab3a173409b400-webhooks-bot@alsa-project.org>
Subject: snd_mixer_selem_ask_playback_vol_dB calculates wrong volume with
 SND_CTL_TLVT_DB_MINMAX_MUTE
Date: Thu, 30 Apr 2026 21:45:52 +0200 (CEST)
Message-ID-Hash: YZONBPHYEBVWVN7AQDO6QRBPZMBUUEV5
X-Message-ID-Hash: YZONBPHYEBVWVN7AQDO6QRBPZMBUUEV5
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YZONBPHYEBVWVN7AQDO6QRBPZMBUUEV5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #504 was edited from pv:

snd_mixer_selem_ask_playback_dB_vol() and snd_mixer_selem_ask_playback_vol_dB() are inconsistent between each other when SND_CTL_TLVT_DB_MINMAX_MUTE  is enabled. Similarly for `snd_mixer_selem_get_playback_dB` after setting volume dB_vol returned.

Version: alsa-lib-1.2.15.3-3.fc44.x86_64

In Pipewire, we have
```
if ((r = snd_mixer_selem_ask_playback_dB_vol(me, value_dB, rounding, &val)) < 0)
    return r;
if ((r = snd_mixer_selem_ask_playback_vol_dB(me, val, &dB)) < 0)
    return r;
```
In the problem case `value_dB = -3259` and `rounding = +1` but I'm seeing
```
(gdb) p	val
$55 = 1
(gdb) p	dB
$56 = -9999999
```
The `val = 1` is correct (the device is muted only at HW volume 0), but dB from snd_mixer_selem_ask_playback_vol_dB is wrong, the device is not muted at volume 1. (The inconsistency results to Pipewire volume control being broken at low volume.)

The device in question is "1532:055e Razer USA, Ltd Razer Nommo V2 X" -- it is muted at lowest ALSA hw volume 0, and anything > 0 is not muted (so it needs the mixer_playback_min_mute quirk).

In snd_tlv_convert_to_dB:
```
snd_tlv_convert_to_dB (tlv=0x7b460cd21610, rangemin=0, rangemax=7248, volume=1, db_gain=0x7b260b455e40) at control/tlv.c:212
254                     if (*db_gain < mindb)
(gdb) p	type
$80 = 5
(gdb) p	mindb
$72 = -2837
(gdb) p	maxdb
$73 = -6
```
The `*db_gain = (maxdb - mindb) * (volume - rangemin) / (rangemax - rangemin) + mindb`  results to `*db_gain == mindb` and the function returns with SND_CTL_TLV_DB_GAIN_MUTE which is wrong.

Reverting https://github.com/alsa-project/alsa-lib/commit/41039b49ad3e20506134864028c77aeaba4c0d51 appears to fix it for me (get `dB ==  -2837`).  Alternatively one could change snd_tlv_convert_from_dB to match so the rounding is right.

I don't understand the new logic, doesn't SND_CTL_TLVT_DB_MINMAX_MUTE mean that the lowest hardware volume value is muted? (Also, the ALSA 1/100 dB values round to zero earlier than the USB 1/256 dB ones.)

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/work_items/5235 (I also have access to similar device locally)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/504
Repository URL: https://github.com/alsa-project/alsa-lib
