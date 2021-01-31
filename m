Return-Path: <SRS0=qoKp=HC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E2C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 31 Jan 2021 22:16:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6889564E27
	for <alsa-devel@archiver.kernel.org>; Sun, 31 Jan 2021 22:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6889564E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 168BE173C;
	Sun, 31 Jan 2021 23:15:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 168BE173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612131385;
	bh=DMLqrG2RzbbEsJM+doXKVo052djnmlgnSQhc2r3Jj00=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h1/NPucx7dpofR5LG2JiEq+iP+dfqMj3tvpyhZSxxHwbYL4E+KKH3iE+UM9XIV6/n
	 kdxlTrmotGLUcKs3MbNvdy0Fo5dw9+F1paJr9DIPdpnD1ZfVostUpjQHFwUinB6vOA
	 hDMCRmMbl/jsdoUGwAWxTtClds9tMfqlfYNjIiNg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B62FF8016E;
	Sun, 31 Jan 2021 23:15:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58150F80171; Sun, 31 Jan 2021 23:15:32 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6C35F80134
 for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2021 23:15:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6C35F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ro1ZoSJ1"
Received: by mail-oi1-x22d.google.com with SMTP id j25so16832451oii.0
 for <alsa-devel@alsa-project.org>; Sun, 31 Jan 2021 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=gMWmY0vlL/BPejD690Ghfe1+FXiApI79DYZABhgF7XU=;
 b=Ro1ZoSJ1VJcgCWKgPReE7BYLdIpgbc5mQQBXc5e5CtwNpQTntYSR+bqNhhQ9iGOEkB
 k5s4HzVS06M8pfT7q0kMUDfpUWmd5BKtv8ZwRgEWXeED9XhUjLi4HHAr/uDJKlv/PcJ+
 Zjhm74xC0X3dTSmvilEeFFqxf2MVxKnp+RHX/t5/Zosa66kP9ZLISwiWgALLOPFe9vkL
 dEhuCQpWTYw6ftAhmJNz9KPEeaZS9gpmr6Q1o1/zBTmFjuEg0VBW9Vx2+vAHKkPQhwQD
 fNQMNwIDAP/c3gjqNdSEyLC8muvxgvGH5FkUT9wjwepCBBMXVEk1e+e9ms385p2g5Ljv
 MfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gMWmY0vlL/BPejD690Ghfe1+FXiApI79DYZABhgF7XU=;
 b=kcgdOC5GkSliy4fHbwL7QjG9nX/O0mNiqQ5rgpEeGnqWuSiyzDJkq5QOWnnBADP1rR
 GsyBwtMQGdnL7bOSdxTCxmAIsa4YjXvk8PYR+SpLjqsSZ5eF7LmzUX4wNbRZ0t/d63rd
 q+DyTEhwjqdkKDinsKUrnIr5FXo6GF06fL1kEIwN7pIyeuvgOKDFIxmYJyNTmGITopwN
 dcXCGYPZem7clD4Buypr+WRygzJ1vxFdK5fWt+x4llBkmNotAsGnLbTyI6/xHbsGvwOy
 ylkTmOrJZ0fKBsMe88C3Ri1Cjsw8v8V3RlqvSHgg2qMbR4S7Lru51cy4tZmU+2D/2FUo
 IMZQ==
X-Gm-Message-State: AOAM5319f6jRNsXT8GISxZgE19MhsKfrdMUg2uIJTRR6CcXGTP+mqP+J
 mhJGB5ybYVfHrVGoTGrU4cIkZ8igMbhe/or1jrO+3hMk+ddhGNeJ
X-Google-Smtp-Source: ABdhPJyK9kOZdmOQu+Y1ek8OwRbYZW295fcR2RpL9hjwYvu/gPAYXx+bcsNlYsZUxeb0QLA384Lak0P2a0DDrYYg9So=
X-Received: by 2002:aca:1906:: with SMTP id l6mr8954402oii.101.1612131322008; 
 Sun, 31 Jan 2021 14:15:22 -0800 (PST)
MIME-Version: 1.0
From: Mert Can Demir <validatedev@gmail.com>
Date: Mon, 1 Feb 2021 01:15:10 +0300
Message-ID: <CAH4rLk2uUbyFEWuvfZ2AFim35NDOcAGL2tUD0KDfN7OeZu0Vnw@mail.gmail.com>
Subject: jack doesn't detected plugged after suspend
To: alsa-devel@alsa-project.org
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

Hi,

I opened an issue on pulseaudio repository at
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1125 about
the problem about the detection of jack output, and I have been forwarded
there, that mailing list, at
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1125#note_784979.
The related outputs and logs are baked into the issue, and seems that the
outputs tells that alsa driver did not reported jack as plugged after
suspend.

Thanks for understanding,

Sincerely,

validatedev
