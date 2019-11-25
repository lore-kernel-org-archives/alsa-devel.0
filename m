Return-Path: <SRS0=E7cH=ZR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B720AC432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:46:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4044E2084D
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hybe9eXr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9na8IOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4044E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32300179A;
	Mon, 25 Nov 2019 17:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32300179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574700377;
	bh=yaKqx5BPVPbfGdw4XATPi7cxH5/nNjxgRptEUyQojcM=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hybe9eXrtIbuNim+Hpakl67utF1cIrphLCrlot4UrOvFYGECDbEiMRT/RUDAa2iKi
	 aiHxJRcVfQMFaA80M1rcP95qPDFMBlrpzuADcseZAh+yx5OT+uUNY1sDTzBOrx65nN
	 8Miitqg3k+129Dlw2V3lYXfODNJl68Vv1E6YjM2o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B08D0F8014D;
	Mon, 25 Nov 2019 17:45:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 089F2F8016F; Mon, 25 Nov 2019 17:45:22 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AFA6F800DF;
 Mon, 25 Nov 2019 17:45:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AFA6F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="o9na8IOx"
Received: by mail-wm1-x341.google.com with SMTP id l1so16213041wme.2;
 Mon, 25 Nov 2019 08:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=I1YAa+Gzw7DNNq0Y9srBTIHENYuEAEuCN3tBA9Gox2k=;
 b=o9na8IOxPN6vrWmonaZkZQzb2lZXDdZAncu6V5E44PrjnZvXYWl+w273oVnh7efvAs
 5y7omV/eYrNl94KUAekYtt5w9gyVWq0/fr4CUDa09d6eKfRpVi+HvF4vQA/O3HBhu69c
 xb8dWIVRID6zJNEhYKzRTmnY0m2L3l0/9WKqFG7mxbhlMjU7OKmv/SZXGP/VHDeG+/+D
 MEIJ5aYNyNyNOYeEC2Bd7V7rRGj5lM1ibSINsxXHoY5+f4lvuZOyZQZo9bxZdI8vCghX
 SIQPdIMEzrg/6kDYK/iKlIKWzjgdNKbvzPP6wl78AnHAHoYnBNR7/Pip6JDtrACy59rf
 8qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=I1YAa+Gzw7DNNq0Y9srBTIHENYuEAEuCN3tBA9Gox2k=;
 b=OuGWgzpUz6H70ofhz6hK4zxxfokf68ICNZrVeMTRsANK4FKYLKz09RKWVRFwkrBzsW
 VBQEacQy9/ofMTBrSCkAzVlyKy5S3GpdqUw8NhirK+1CfOwksy1EBgpGOJU36o5Sp3m8
 hh/rw8D8WwxMWbE4aGuSJ6unVxk9LF6SqAC4cyDCvqsU6Dp7OnLrEqN7M81LxCItWoRp
 LKVLfXa5mzQM15twH2cfAKGByuFJWZzwvQaCkWo2mXuOwvoyfWTYI39RavnE3aRPWjsZ
 oZmYUi3XeU76twnAT6Tq5/P4Ne8xf4NGAHOCWKsp/DMmdifH3G5hM3KmNf6IRZzFyJkV
 g2xg==
X-Gm-Message-State: APjAAAVpKOwy9Mu2ODFJRlAcqDTouAbk3WBWXveV2zMikpuu6Fcq4YnC
 vRMoldN73kbrwaPWhcp6lU2mtks13WVURiOpYZw=
X-Google-Smtp-Source: APXvYqwapORUnCWQ7PGUMHj817ds6AFukiv2/6Yyf45Pspn3ZuIMyZqZbujKxNbyZ2PiZFztiEMpVptZeByzpeirmGY=
X-Received: by 2002:a1c:2745:: with SMTP id n66mr29302367wmn.171.1574700317308; 
 Mon, 25 Nov 2019 08:45:17 -0800 (PST)
MIME-Version: 1.0
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 25 Nov 2019 18:45:06 +0200
Message-ID: <CAEnQRZBsmz17JGdxT_bB_tDHsmWskdXCW47R5wf5dhEw=Jpu-g@mail.gmail.com>
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, sof@nxp.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
Subject: [alsa-devel] Converting a non BE to BE inside soc_check_tplg_fes
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

Hi all,

I am trying how a non-BE link is converted to a BE link
inside soc_check_tplg_fes.

soc_check_tplg_fes
=> for all components that have ignore_machine setup to card name
     => dai_link->platforms->name = component->name;
     => dai_link->no_pcm = 1;

But the thing is that the link is a true non-DPCM link, than fields
like dpcm_playback/dpcm_capture are not set and playback/record
substreams are no created.

The question is: is this supposed to be working with non-DPCM links?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
