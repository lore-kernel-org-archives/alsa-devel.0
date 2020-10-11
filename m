Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:51:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9C8206B5
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dqQkdha1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euSFJ8BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9C8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CDE11687;
	Mon, 12 Oct 2020 08:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CDE11687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602485516;
	bh=+gF/pvE9cz4cyL31O4e36+tkrt0y1FegWhOk8BrvL2w=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dqQkdha1axbdkVQ5K7QcuUcJd2qBSGfdrN9PWNQNcMl3DGDbJr/Byup/77LBDOGi2
	 06DLR5PMyJLP8xSRfQNoJqA0ngwcv6S/BUE2ic9WXZa3eXahn1V0isWX0b2CUyMTWz
	 zbWI3kknzMJ7JcDqG/RyxHn5GNtHYy6G3+H29sSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F480F80260;
	Mon, 12 Oct 2020 08:49:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CECF9F8016F; Sun, 11 Oct 2020 10:16:34 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F02EF80134
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 10:16:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F02EF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="euSFJ8BO"
Received: by mail-qv1-xf44.google.com with SMTP id o25so418669qvf.7
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=d5m9KZ0ljwfkHfNq2Ag7evkfnTRLCFt04MefyXKWpHw=;
 b=euSFJ8BO37KqYVSjwRS+hXDnqpPc3vdbrHH3dIWpmPTiSzddL0M90Cg3ywTnmwVkDu
 jE7qUvwNzRNHzykXD97MjQqh4hY1TsBrgTaA6uwzbBaOj/I6J8m/3wJpq+sseGZoLfFf
 YAalG1LMkTh2G5rMY+0BcWwbbrvkkTtZ1FlXc76bgMw23Dk/EZ1BFVIdig2iyCqjnOZa
 bkzb4w88+LTL3Nsz9Adut9Mq8Bl1v77uS8sZPYK4DIhegXta7fZfC2mctNoAa/en3buD
 rexVfAzfoeCD4ULhrEcGJtzZ/4kvp9nrdXl5/ikxta9GuR+ODv3ve4zQZcokniV5ZPWu
 raNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=d5m9KZ0ljwfkHfNq2Ag7evkfnTRLCFt04MefyXKWpHw=;
 b=Hlzes67gRe+/UnVKaBeGhXDr1MJtlrbyP4aHh5MeQlkZpYv3CWbPVavCJniluhDgkZ
 7dcOaUEJMNYKZ2uGBoZIWhc4JQOTFCVyQ8AL1tFxnDnd4mwxhglDnI7nsLhW/+Jd7e5D
 R9lCnDqn0Ee0YTwF2BLskF3MTiaXhd/lXUdIL0n9bizrPTPtEUTEiEeNHiX8r7v9dNrq
 uPLChgAz2z2fm+e1Wd06Vc8uGut3IltjSJKLaWcV2fGzCJcLXdiiKG/xoPvz7FQImmF0
 glzK7RKIya9MgxrRDygZHwAYRH+MjEbiBQKoAUiwgghhspNvrTGk4oXXLvYmAaEZViUw
 n1Bg==
X-Gm-Message-State: AOAM531BUC3ELDZuCwwhwKgmxUt7PyUzx5VH2n5WoFZazP39Ll/Rh+cC
 PzZnBn6XpC2YBdVEApkat0UnAxXW64CsLF5rhTA=
X-Google-Smtp-Source: ABdhPJyG3iIDI31q2akjtOpOW8yuXriSul4Ata3Oyhv4Yq7ag7tlU7UcEuYsifUxtjVPN+Uxb9PTj4Lx05GDaP9R+/Q=
X-Received: by 2002:a0c:b447:: with SMTP id e7mr18748507qvf.1.1602404189796;
 Sun, 11 Oct 2020 01:16:29 -0700 (PDT)
MIME-Version: 1.0
From: MICHAEL Mosier <tcprosaffiliates@gmail.com>
Date: Sun, 11 Oct 2020 03:16:18 -0500
Message-ID: <CABiErTVuRWOBxgRVAfHwWA7AqqjzRJasb50y1OsKXCkMbm4icw@mail.gmail.com>
Subject: Re: [PATCH 07/10] ALSA: firewire-lib: code refactoring for data block
 calculation
To: o-takashi@sakamocchi.jp
X-Mailman-Approved-At: Mon, 12 Oct 2020 08:49:37 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
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

=F0=9F=91=8B hello I see our work has brought us together once again
