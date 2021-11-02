Return-Path: <SRS0=AYCm=PV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E945C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Nov 2021 09:11:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A423D60E8C
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Nov 2021 09:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A423D60E8C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27C7C16C2;
	Tue,  2 Nov 2021 10:10:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27C7C16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635844272;
	bh=rhya4TJUkO6ltyWMnVipBHAO5d3rPHKYbEC7rCA4ujw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fV/Vmy1WWI3t1wVHCcI50m+g2SpnhGmI65RpSSwzkPP0QZPzSD4acfByNVcMqt7Kw
	 SitDgQY4vtyZ2/qtEeY/g01xEWknd71S1HBB+m6YtLq8vzsW2Y+5Osx1CusmnMhuNW
	 QRBmV1kqfzt4QbEK/lnJ6uhvlVXiNPvCclz/yi9o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24ECAF8027C;
	Tue,  2 Nov 2021 10:10:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18DC7F804E7; Tue,  2 Nov 2021 10:10:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F1499F8027C
 for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2021 10:10:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1499F8027C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1635844213954025984-webhooks-bot@alsa-project.org>
References: <1635844213954025984-webhooks-bot@alsa-project.org>
Subject: Config file for a52 plugin (60-a52-encoder.conf) produces no/garbled
 sound via optical digital out (S/PDIF)
Message-Id: <20211102091018.18DC7F804E7@alsa1.perex.cz>
Date: Tue,  2 Nov 2021 10:10:18 +0100 (CET)
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

alsa-project/alsa-plugins issue #38 was edited from jensgw:

Dear Maintainer,

this bug was originally reported on the debian tracker. They advised me to post it here.
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=998125

* What led up to the situation?
Fresh Debian 11 install. I want to output 5.1 sound via toslink.
Used KDE settings to switch from analog output to digital out 5.1.
This produced no or garbled sound and Youtube videos would play back way to fast without sound.
Then I switched to digital out stereo, this worked as expected but only stereo.

I could trace back the error to the shipped config file for alsa's a52 plugin: 60-a52-encoder.conf.

When I replaced that file with a much simpler one (see below) 5.1 digital out worked as expected.

I tried with onboard sound (PCH9) and dedicated card (Audigy Z) with the same result, the inlcuded a52 config file does not work.

== Start working a52.conf
```
pcm.a52 {
  @args [CARD]
  @args.CARD {
    type string
  }
  type rate
  slave {
    pcm {
      type a52
      bitrate 448
      channels 6
      card $CARD
    }
  rate 48000
  }
}
```
== End working a52.conf

Therefore I assume the shipped config file with debian has an error somewhere. Please fix this.

Best reagards
Jens



-- System Information:
Debian Release: 11.1
Architecture: amd64 (x86_64)

Kernel: Linux 5.14.0-0.bpo.2-amd64 (SMP w/4 CPU threads)
Kernel taint flags: TAINT_UNSIGNED_MODULE
Locale: LANG=de_DE.UTF-8, LC_CTYPE=de_DE.UTF-8 (charmap=UTF-8), LANGUAGE=en_US:en
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)

Versions of packages libasound2-plugins depends on:
ii  libasound2                         1.2.4-1.1
ii  libavcodec-extra58 [libavcodec58]  7:4.3.2-0+deb11u2
ii  libavresample4                     7:4.3.2-0+deb11u2
ii  libavutil56                        7:4.3.2-0+deb11u2
ii  libc6                              2.31-13+deb11u2
ii  libjack0 [libjack-0.125]           1:0.125.0-3+b1
ii  libpulse0                          14.2-2
ii  libsamplerate0                     0.2.1+ds0-1

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/38
Repository URL: https://github.com/alsa-project/alsa-plugins
