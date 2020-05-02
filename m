Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3432C47247
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:24:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CBF20721
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ajeyp4i0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqe3zQwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CBF20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62E6616FD;
	Mon,  4 May 2020 12:23:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62E6616FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588587849;
	bh=JPr0gml1nzHx+kiGl68gqk/fSvnNA0zfBdaaHX3/GXo=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ajeyp4i0VCwIBEUEndGeVm5Zu85IrITPLSvx415eoDg7yQFgkCEkY3FxxQwjM6LDu
	 Eoh8Utq9gPpQn8HA5fkubIfAQFr2lsRvFfo02D8tO7Ac+ox2KriFeqVk8df9O+ojPB
	 EfKIHZ+P+xHwVCcf+nH+YSoPvoOYEPmysMqhLkfY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59191F8028F;
	Mon,  4 May 2020 12:21:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BABBDF800E5; Sat,  2 May 2020 17:10:30 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 440D3F800E5
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 17:10:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 440D3F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oqe3zQwJ"
Received: by mail-lf1-x131.google.com with SMTP id l11so6064646lfc.5
 for <alsa-devel@alsa-project.org>; Sat, 02 May 2020 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=WDxG6BMyNjjsPs0QZDn7toW+dX5nfJC6ewluoZAGNiY=;
 b=oqe3zQwJgXQ27jO0pH6lfQ/tHeLpEv8l3ja5+pi6C/MhWxj6fvEZWSwNvOEDfy3upn
 5qrrxh1XA5NHZYL3597cx9wSCm8QcYzN/9yorbDZiHBAsIqvYp4V9l0UVEcH+MDdBdJ0
 4F6WswM3xN/mF7plUHJLULpGKpmLAcOzqdW63MFVEUhlYq1DQp3z0OgqPQYv4I8KVcD5
 FlKoJREkNYjBWPWIHWSStkc4XafdeyMZt8zgFJYNPPqKQKmiFwcBkQY1x8fMBaobYg9V
 OAEk66J3kFlKNIDwEYh13D78d5xTI5NvDvQCRxBdhvSGjAt5wC4frptxX14WCW3HdAF4
 rbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WDxG6BMyNjjsPs0QZDn7toW+dX5nfJC6ewluoZAGNiY=;
 b=uernXFRDn1VZaN9FtGOJzBJwOMAO+wgIWh9XhO4uoELJFbl5fsYqKe3Ov9HYVJXBVS
 ROokix0xDrhJUfpFw6el5fP6B9HaAKA61corD2DSLmw99WzeDVUPm/3/ClipAMpU7u/O
 J+nCl1rEHNbjlulp8+qBwoO1tpu3l8vo3kWPsTIXHFCq45xHHEw1ZVkdUZvHXzD/U5Y8
 1g8zTDdYjYzdHC9OwE8XZYnPMz+lyx8IXuju9tA5mbMdPJNTMuHuunXbCbcYyYP6UqzI
 KOHzq5dsdsdOnI8ohWNviLKPcF+RrvLcmOU1bI0QOJBiTu38QnNv+Nz7/ggIA0um8rlq
 HsNQ==
X-Gm-Message-State: AGi0PuZnhGg6FelQkJOiAcWwCavXaEzhL1NloTo+StaVVqfLE8FNamJF
 cwoW8TD/YfgitJhVnfsSg97AAKglK94kg/JcL2dpuP3AWXk=
X-Google-Smtp-Source: APiQypIi464qhmc5NUvlbxx0Y82ogzQYutIef6lBpug7OYNS1WTbUV7EkUR9oUuXkPtwf3subkUQA3x++6WG7kYXW+o=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr5713470lfd.212.1588432225649; 
 Sat, 02 May 2020 08:10:25 -0700 (PDT)
MIME-Version: 1.0
From: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
Date: Sat, 2 May 2020 18:09:49 +0300
Message-ID: <CAO1Zr+o3L+iXeV8JL5VN=0XbLV-=U=DxKUkokmkq3n0Xaqq=zQ@mail.gmail.com>
Subject: windows 1909 drivers update breaks ALC294 sound
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Mon, 04 May 2020 12:21:36 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

Hello!

I recently install recent version of windows on separate partition and got
garbaged sound on booth OS! My old version of windows was 1803 and everying
was ok, I updated to 1909 and it got broken sound. Probably due to some
firmware / configs / updates on sound chip. I let Windows to update drivers
and notice my sound card driver got replaced by realtek drivers and sound
got fixed on windows! But linux still not working propertly!

I put more details with alsa-info output to the ubuntu bug reporter, for
now: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1876459

-- AK
