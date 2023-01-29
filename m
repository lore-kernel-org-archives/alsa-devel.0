Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E00C63797
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Feb 2023 14:54:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AE7E839;
	Wed,  1 Feb 2023 15:53:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AE7E839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675263250;
	bh=CPkS3RCMJsIApZjzxSV7AqoFj7doClkqekwrbrro1x4=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F9+dHDXPZ+tBH782rthx8NbBWRa4Epr+CCDC+OSSxB2rWLRgzDMnbg9j0fBZar2kD
	 jJmJ8K4sL2dvntBqxlCbo55uuelrirbrKY/O1VKNwUjmIho1ohVXAPHsJ8OicEZsCk
	 OivYWMEvVRU0ftktP4hCqJTbS9eroX3z+eJi+CpE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AB116F80494;
	Wed,  1 Feb 2023 15:52:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E503F804B2; Sun, 29 Jan 2023 22:53:13 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89C10F80171
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2023 22:53:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89C10F80171
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=U/VxjGZs
Received: by mail-ej1-x62f.google.com with SMTP id hx15so7415244ejc.11
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2023 13:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Jx2VCByZ+N3uCS/GwdsGW2lTgWOCKj3QTeKZBIjVOyo=;
 b=U/VxjGZsg+7mEX49nEtB4C57ikWLYLNuGS5+IgmLl8cDQpNTlaYv40DuGEdrHrpG4n
 DKbH5ZOJl8NHWdkpFGBYwZ1AJWRdfPlc3fzQQK0ZS4Ft+Vq7RlTnKCcGJVDS7IbMXcIq
 X6gzLt28kV77jv65M0LVtn/jzAF4DtIjxlIjV9/VJ+PymXUJFvcunjUfwBV4SXzoWWuV
 XcaG8E905Bd6LyYi9qhYtEkKdX6VKFMkxNEDxRM7qwbxRfiIrlCkzCkV5I53YCM+IyGK
 ni+trzXbEp5GJlDobGfMIZ2ltm5Dn8atgFZDttvNI2q4rWgE8A0zFG9OP38rWw262HXt
 zNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jx2VCByZ+N3uCS/GwdsGW2lTgWOCKj3QTeKZBIjVOyo=;
 b=sThT326KdcsaSq94qLJSBn+oSerf8n1LiuViyGTl3K++rhYgndVdpRK3VBgBuVBgFB
 gAkkuLaCgtkWoKUfBaj+isTbGyYMTo8+pFMxuDsyTK+ypm8JBHn0SG1Y8mNHvMn75z/C
 IN4+XRz5dggpoa4gWFWrxrq6DVauPSAiMugFhg1INro6cn/eHEOQ0cxKQ6OaWQS82PfE
 rnsBeoX5/UkCTD8cB1bjKFO4Ew5QWjFbq2lUsWsaYvI1IkSXLShHC+O/7YeyiXj5tywb
 NHdT0a3oj/Op3uWD5fNEUtSg6Ct8uipBFcV+uKlAt/fuZW2ok9SwVaY/6B8TcBx5JwXE
 +CZA==
X-Gm-Message-State: AFqh2krKlcQnefLFHRf/KFvbSWgh3y1CKgxJNH1TiZlCmowCHyLDg6JT
 ygqSLndYAwl10NZnVRLvRvzVEtLsLjQ6vYsW8wB+sGj9
X-Google-Smtp-Source: AMrXdXvMdhGlwM6qHop3qz5W9WGIcRRL82nkxu4/8dNLwXD7K0HmVE0pItROoRjVxZ9Pl5qT+pasvjuEIilVfVqiBE8=
X-Received: by 2002:a17:906:b14b:b0:870:5fc6:210c with SMTP id
 bt11-20020a170906b14b00b008705fc6210cmr7483690ejb.257.1675029185625; Sun, 29
 Jan 2023 13:53:05 -0800 (PST)
MIME-Version: 1.0
From: Stefan Alexe <stefanalexe802@gmail.com>
Date: Sun, 29 Jan 2023 23:52:54 +0200
Message-ID: <CAFBfLLcrTQ6_X85XWDdkcQgYUYFfRmJr1eYW29TP0=PFAVsmgg@mail.gmail.com>
Subject: Is there any way to install alsa-lib with the suid bit set?
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Wed, 01 Feb 2023 15:52:51 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

I am trying to only use a static /dev. I have opened an issue about this on
GitHub and got it to work only as the root user. This resembles my
experience with xorg. In that case I had to use the suid use flag. Is there
an equivalent in this situation?
