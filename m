Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83555C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:58:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D792168B
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dARcfv7z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N98F0HtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D792168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE05F1614;
	Fri, 14 Feb 2020 11:57:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE05F1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581677929;
	bh=WCbAue/gWOKWCO2qnGlvkYj69w7/oTK9erxpBSkF3vg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dARcfv7zgfqH9aPJHqeHIvq2DL9Y2Tg/7i8JjVmGcIGXOWl4borYpAHfFj6lfmP19
	 oIlKNep34c8GacebjNRlX/Rp800KVcqqkYYe30OHpMW+DZ03BGM6aoIPHpWGwQ34sM
	 sPBVFRa9GvUg4flaHoP707SEM98Pz4gSqmGNRp70=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3035BF8013E;
	Fri, 14 Feb 2020 11:57:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E74EAF8014F; Fri, 14 Feb 2020 11:57:56 +0100 (CET)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17A5CF80138
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 11:57:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17A5CF80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="N98F0HtR"
Received: by mail-qt1-x84a.google.com with SMTP id o18so5660620qtt.19
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=iLnKbM94yjTerDVpgFdFsZlhw/vyvNzdBJ+ozoju9p8=;
 b=N98F0HtRLdT5Fu/SWOBMZGVSfKiUrnEtM1ZdSGT1ltChy8810bQRX6jPQsXyQTbRSA
 /9yuREeOV3+tswutIG3Fhx/XXGdqgfL1b+yLwKGDr6sr+LhoKe6YKo2BN/VJp5LUloeg
 DGYHLhHBScnkrD9OXQUKiaqT8mfWxIk2ATPUUIMSsRetHXDWG+F1wNI/gxPh0UMUpFhO
 eyLFnXtFDkP68YNXMBLTBMZl1odu/QIbgJs/5Wre23fpSevQUQZovaArBROPghy8O4yH
 lJK60w069TcomBjpZClyIDqdkboBTLivVywWtK5rVVchuZXzb1+ux4sTUVRTdlqwsJGm
 VhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=iLnKbM94yjTerDVpgFdFsZlhw/vyvNzdBJ+ozoju9p8=;
 b=bGF4MLG+3slbwCu0sF3cdIdPPB6FC2bY9O2mqsUqDeRymD9/8flVCwlNPAIM+p+gOa
 SnqK10cJ8raZ9GQM6Eyjb7/iR6sXPbvCSZ9+tgq3ww4r5AAzD/zP5SI4HJdaiPNqIGcd
 +IYyAd7MWkfSNyJxPbLFlLPSZKmf4tqqzpt3HFbamnEhKGHIN9VdTptm814u5f2HsZ7F
 Fqlzre6V2nnGwvlIeEUPTdTr5s5bxGIen2TlQfOeDMRj1mBJuxkZCdgyR1YYPWE9mk9F
 VyhqQSjHW9SOiFDe+hw7a1s6xviuoIck0S5F1s3jAKXeFsqGEuTJtAEPn4jq2kBxM/dP
 9kPQ==
X-Gm-Message-State: APjAAAXHmrzn20GMw7NQgaGnEkag1hKKSxBj1O9yWez+KCQRqeqwP7ZD
 jcjRUxQTzGAXoMVtGvfLR8cUrN2Q/enO
X-Google-Smtp-Source: APXvYqz6HV5mP41J1LoYw7L9TOUFBaz3eeWP1f3y+LmmJSkgXMAA1eb2+m7ZS2yFNF9LMAW0IXIPnE26QKvX
X-Received: by 2002:a05:620a:4cc:: with SMTP id
 12mr1813420qks.153.1581677871506; 
 Fri, 14 Feb 2020 02:57:51 -0800 (PST)
Date: Fri, 14 Feb 2020 18:57:41 +0800
Message-Id: <20200214105744.82258-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com,
 cychiang@google.com
Subject: [alsa-devel] [PATCH 0/3] ASoC: max98090: revert invalid fixes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

A critical side-effect was observed along with the commit 62d5ae4cafb7
("ASoC: max98090: save and restore SHDN when changing sensitive registers").

When keep playing something,
(e.g. sox -n -t s16 -r 48000 -c 2 - synth sine 440 vol 0.1 | \
      aplay -D hw:0,0 -f S16_LE -r 48000 -c 2)

the recorded sound has chance to break (clipping).
(e.g. while [ 1 ]; do
        arecord -q -f S16_LE -d 2 -r 48000 -c 2 test.raw \
	sox -t s16 -r 48000 -c 2 test.raw  -n stat \
	...
      done)

The series reverts all related commits.
I feel really sorry for the whole mess.

Tzung-Bi Shih (3):
  ASoC: max98090: revert invalid fix for handling SHDN
  ASoC: dapm: remove snd_soc_dapm_put_enum_double_locked
  ASoC: core: remove SND_SOC_BYTES_E

 include/sound/soc-dapm.h    |   2 -
 include/sound/soc.h         |   6 -
 sound/soc/codecs/max98090.c | 434 ++++++++++--------------------------
 sound/soc/codecs/max98090.h |   3 +-
 sound/soc/soc-dapm.c        |  54 ++---
 5 files changed, 137 insertions(+), 362 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
