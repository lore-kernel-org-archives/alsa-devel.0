Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA04C3B189
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:05:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5F3218AC
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZGwcg8eq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="smkU19UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5F3218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F9C21661;
	Thu, 13 Feb 2020 09:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F9C21661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581581137;
	bh=BDQnM+/PnE7RS87sfxgfmCVwNUwbNrxmnD66Zsq/p0w=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGwcg8eqVw6tEZRDTSc7bgQhiX/UIN8A+QhmoCQickz2qpVAzDknOB+Ld5HwvRXMW
	 Ljtc6CXmVK8xnFcs6CEAJlCL5fKFB7s1Ju+z/cQZdSc0QlChcl5eVwFmi3oYsAViVG
	 66wIUxvjo7r4RH5SUw0UVYRYUvmjy2REAZY2DMSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26C2DF8013E;
	Thu, 13 Feb 2020 09:04:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0996F80145; Thu, 13 Feb 2020 09:04:45 +0100 (CET)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41324F80138
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 09:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41324F80138
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="smkU19UK"
Received: by mail-io1-xd44.google.com with SMTP id i11so5398274ioi.12
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 00:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sc3keblL800YvOavDBCb855qDz/NufloEJ5TcEwfY7k=;
 b=smkU19UKPG07Wu5DsBkdgAAwKhnW0ebOa1khT8jd7fCuMNJjwP+Saxa3Jobis/+muN
 ZkmXGbw9ZnB/3LDbSUs4/xtbo60UJOYOHZ5xsS5isrkMbaFnYMuFwcAN729yoACIz+3v
 FYDd2d/Oe8JmmpRlGAklaTD/JJ95QCnvjlqw1evmT8HliD72qW1NxqIZ7PkjhgncaiwZ
 YLLIbV7zROOaEhz8NUpya9wKbr8QUC63vSN11nHyAcl1mhrgTeH2uAUyVeqhV+pTFw5o
 ZTvBIMozhpOdC2mI/nBqSkb2DVbsKCjtsTdEeQbanSTBgZmqS+EQur03LuOGo3gdDha0
 pgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sc3keblL800YvOavDBCb855qDz/NufloEJ5TcEwfY7k=;
 b=rH2Li+jfWVycqCfxqUYTvpwcvBKYPAzJzkFOy8PmvbZjp2EPLWU4TDcoEFpbk9NGZo
 0e7spTsnU99MACzV2z4aZgKjuF8lSogGe7bGMiWb2PKAH8dfkqRtYA43OQG1zssX48AA
 Qwuu6J4IErwOmYShnUAR+Dbptg6FW/RUjcK9xu55oQ8azgAiIedgiy4T9GBd5ZaUbuMD
 eypVuhpDe/NhT0bPTS+ssk+j0YwsQ8I+4/hxdpOmVqHDXw1zxv1/CI3OUkrpteYm+hYz
 aNNge0TStlITjDlp7CxyyFbHZkAZGcHd8LhhZ+Yf2ViuNJx8DtbtnWF9h48Lz6ga3phC
 QCTg==
X-Gm-Message-State: APjAAAW2DFDfKEZ3ovPOELMRpo+eJKn3HRZo6Tt97igLW+HxOqY2A4sZ
 d1P2313B5TznnrRjUFEBb+rWnFvIqWVYIPyIvKjkp/5U2Zc=
X-Google-Smtp-Source: APXvYqz80zbBUl4azLIlTYZJqui4gbd2SKx6LXrZUjj87iiR7EZYRgG1ei+0n/JP2A0qiVFK0NgJVqH3yG53c8hyEJs=
X-Received: by 2002:a6b:c703:: with SMTP id x3mr21246766iof.118.1581581081318; 
 Thu, 13 Feb 2020 00:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20200212192707.PATCH.I477092c2f104fd589133436c3ae4590e6fc6323b@changeid>
In-Reply-To: <20200212192707.PATCH.I477092c2f104fd589133436c3ae4590e6fc6323b@changeid>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 13 Feb 2020 16:04:30 +0800
Message-ID: <CA+Px+wW6G274xtGhjmBc-QMqBahe0rtNVGt1Tc4bC6SH9VGiqg@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>, David Airlie <airlied@linux.ie>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, dri-devel@lists.freedesktop.org,
 CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org,
 p.zabel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>,
 Dylan Reid <dgreid@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] drm/mediatek: fix race condition of
	plugged_cb and codec_dev
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

On Wed, Feb 12, 2020 at 7:29 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> hdmi_conn_detect and mtk_hdmi_audio_hook_plugged_cb woule be called
> by different threads.  plugged_cb and codec_dev are in danger of race
> condition.

Please ignore the patch.  The successive attempt:
https://patchwork.kernel.org/patch/11379979/
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
