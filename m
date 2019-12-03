Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B76C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:13:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EAB206EC
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PGF0Puyl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=idlegandalf.com header.i=@idlegandalf.com header.b="ITx5H7fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EAB206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idlegandalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EC70165D;
	Tue,  3 Dec 2019 21:12:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EC70165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575403993;
	bh=/ctK8Cu7XQLBslQyNz5PLBc9wGT8upG3XjmoEwnt0AQ=;
	h=To:From:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PGF0Puylu/dNPzbiF4Vs0gb2xqRciar2ZtLm9QKzZHCsOjbiUIHWJoM/LdtvdS1RP
	 Cg5xI16abepDgrY+/p1IYtdbbVsvyVfxUjljVxB2Lt/liE0JdAudKjgjNhK+A6m3mY
	 6xcTmuTOCVWEbXMQlzhUqXs6Le5WJNm14r6Vi9og=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE6AF800B4;
	Tue,  3 Dec 2019 21:12:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74BF4F80227; Tue,  3 Dec 2019 21:12:21 +0100 (CET)
Received: from anquietas.harting.hosting (anquietas.harting.hosting
 [IPv6:2a01:4f8:a0:61f7::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69FE0F800B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 21:12:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69FE0F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=fail reason="key not found in DNS" (0-bit key) header.d=idlegandalf.com
 header.i=@idlegandalf.com header.b="ITx5H7fQ"
To: alsa-devel@alsa-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idlegandalf.com;
 s=mail; t=1575403936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TA+ipIojQByPfMPDmyAh6RRvgZqWlqYeeVSju2hjBO0=;
 b=ITx5H7fQFP6BmC2aSwYWJr2MM+eHLkfuAuojUZNfruqS5/hM/o6Ko94U06ef2hRVG1l/DK
 IuROy4Jq+jkuzJEt7MSHQ4NEfYNCOwPRDRJzCcwBczGX96nmLZftlbs00ah6v9gtIQCOm/
 bOQ2oEyT894qWgn0vh/enOCuIJ7yH+o=
From: Giovanni Harting <539@idlegandalf.com>
Message-ID: <822e0fa2-3075-7447-8c37-34dbe4e211b9@idlegandalf.com>
Date: Tue, 3 Dec 2019 21:12:14 +0100
MIME-Version: 1.0
Content-Language: en-GB
Subject: [alsa-devel] a52 plugin + ffmpeg with libswresample
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello,

I'm working on restoring functionality to the a52 plugin.
ALSA build with ffmpeg without (deprecated) libavresample does not build 
this plugin, since libavresample is missing. Archlinux for example does 
not build with libavresample anymore [1], therefore a52 is missing in 
alsa-plugins builds since that change happened.

I ported rate-lav to libswresample, which seems to work well after a 
month of daily use.

The oddity is that a config file (asoundrc, [2]), that worked fine with 
alsa-lib 1.1.6, does not work with 1.1.7+. I could not find a change 
that causes this.

I traced it down to _snd_pcm_rate_open() in pcm/pcm_rate.c, where 
keywords from within pcm {} are passed into, where it fails with 
"Unknown field card" (for example).

I worked around it by filtering out all keywords [3], but that feels a 
little unclean. Is there a proper way to fix this? I'm not familiar with 
ALSA's config parsing.

I'll submit patches for both once I figured out how to fix this.

[1] https://bugs.archlinux.org/task/60586
[2]
pcm.a52 {
     @args [CARD]
     @args.CARD {
         type string
     }
     type rate
     slave {
         pcm {
             type a52
             bitrate 640
             channels 6
             card $CARD
         }
         rate 48000
         format S16_LE
     }
}

[3]
if (strcmp(id, "bitrate") == 0 || strcmp(id, "rate") == 0 || strcmp(id, 
"card") == 0 || strcmp(id, "channels") == 0 || strcmp(id, "format") == 0) {
     continue;
}
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
