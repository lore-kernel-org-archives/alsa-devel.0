Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCCC3F68F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:06:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7939524656
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rHP4kNum";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFquqcY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7939524656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C999D16B6;
	Wed, 22 Jan 2020 18:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C999D16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579712782;
	bh=zrjuE50YEL9juF9kzH+fMWq04a35H8w21cwE9M1icY4=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rHP4kNumYG8bSfjni6eF0tHSB5RZ6bjrpybLNMIHUFSrrJx2yhPGWXgyInBK6BcG5
	 e11KRS0ZwR8kO2VqwqeQRDCGxzcmTB9+1J0VoyKIi2RrtfPVOHll5omDTR60NcRNBF
	 CNKRAjS96tVu5y9V6kleU0xmpjE7fdzjs7dwhQw8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E74DF80229;
	Wed, 22 Jan 2020 18:04:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E691FF801D9; Sun, 19 Jan 2020 21:47:04 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BCF5F8013E
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2020 21:47:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BCF5F8013E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DFquqcY8"
Received: by mail-vk1-xa32.google.com with SMTP id g7so8015255vkl.12
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2020 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=HKvSiqAJ3SCEpmUIQ6/2HzMosaLFXFREjvtGa9eXZ4c=;
 b=DFquqcY8jqmuZQ/J+PrzS/X9kQ8Yiz7ms9OfPD8d8T9bCQK6DCTjBIJjfiF0sUfw47
 vP9EpyQ/cS6bEbOS26gCM+tJVsRYfsJyRFhXqsRlG2yV0x3eyrXMpbnbmZmzdDEGs6B5
 qxMb4TEkJIIPTitm6llMo/oa1HjVuBoYhHAfufS3d2HelJUc8teajSe0eGBQAWVa7nex
 2KzJNJ1q3XbxqZOKzw4p9BvqF8YcrChUQOsHZ/IcpmUFsj7mmbEAYmhoqI2DAkUtKT+V
 bpIrDHESnlUAFj3bYncsHLtiEaQV3faa0CfbCfBhkL38NzyDHFCl8aVaIVbhmFB0GgwJ
 V4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=HKvSiqAJ3SCEpmUIQ6/2HzMosaLFXFREjvtGa9eXZ4c=;
 b=gUJ0hkPrRJnrRp1QZ6NxUlrlJ1N5+90NswWfoLyrtAzzHf15+ZPoXFghRpBIMeJfBZ
 Jv4rlPd77XgrFXdO+Ue9WPIOhr0QPIYBv6ZMFPVTDa2LSyJvzs2fnmzsG0UNF8sJ7KmL
 eFmsQKT22bCLrR5T3VsAeztnVPLyUnC+bDq+KPWkFRy78jxk0YFdi3DRXrKJCEsPGgZs
 +7Vu3ZzijvHHqdh5E0oFBVWPL0VfAQXsRTPvCxOEz+GHdsAwjFhgFt8Ke6xhs4oIE+0R
 MWklxGLyr/erHLlLxrAGTGbJqimLXG/FzW+h+tXxGrc/VkISUW0Zlpb5fI2v9PTV5EoT
 Tt+g==
X-Gm-Message-State: APjAAAUC9GrlawQZcGZWPsPa+XEopxV8a+Km4/0Qi9xiD/q2eOHuGqve
 cQN3kfThS56HqlFh9V/sDGwvfJoGksCzlEtegZU=
X-Google-Smtp-Source: APXvYqxHDHDR0Rt0o0eZb9OmUptS0EeMJEGo1EGK1LT7KZo+Ztgo9YCTEjEi5GyeMI9Ny4QZ5xn430Cu1j7ROmkJvyo=
X-Received: by 2002:ac5:cd3a:: with SMTP id a26mr26984652vkm.42.1579466820078; 
 Sun, 19 Jan 2020 12:47:00 -0800 (PST)
MIME-Version: 1.0
From: Mihai Luizescu <m.luizescu@gmail.com>
Date: Sun, 19 Jan 2020 21:46:49 +0100
Message-ID: <CAKRdUfOT9E55tuxiU6au7DGyHL_BkxknVs2BS_DuvYsSAOdnFA@mail.gmail.com>
To: emilio.moretti@gmail.com
X-Mailman-Approved-At: Wed, 22 Jan 2020 18:04:36 +0100
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 01/01] Add VID to support native DSD
	reproduction on FiiO devices.
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

Tested-by: Mihai Luizescu <m.luizescu@gmail.com>
---

I tested the patch today on Archlinux and I can confirm that it is working.

I am able to play DSD files up to DSD256, the maximum supported by the
sound card.

I only compiled the snd_usb_audio module with the patch and replaced
the stock one.

DSD playback was confirmed by the green LED on the soundcard and by

checking /proc/asound (altset 3 is used during DSD playback).
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
