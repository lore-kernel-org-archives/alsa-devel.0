Return-Path: <SRS0=otjm=5G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E17C4332D
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD3120781
	for <alsa-devel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gptMwncz";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twjkrc8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD3120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DBFD11C;
	Sat, 21 Mar 2020 16:53:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DBFD11C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584806051;
	bh=b6a6xu9By59lT9CMyPrm7OsGqcuWwsYUHem6vSmyXV8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gptMwnczQELhDjnsAi+4MJ8nnDnZmD84zEyuQmxTNvH+s9D0vNKIci6Py5TWzY7XK
	 zquduKWCal+RtA9RWw+CZXU0M5SORyjGeR7DbUCU0pCeJZ2fD1ILk6QQbccOxouq2d
	 uGtIpPZxo0rnryP63+NpBMEgnT+xjvwhSJqUOxgU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEF64F80217;
	Sat, 21 Mar 2020 16:53:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C707F8022B; Sat, 21 Mar 2020 16:53:19 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 140B1F800C0
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2020 16:53:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 140B1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Twjkrc8o"
Received: by mail-wm1-x32a.google.com with SMTP id d1so9681968wmb.2
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2020 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=urN59fDOy9ly5Z6F/XEbHP15XfrcXu7u3A3Dq8sjaFU=;
 b=Twjkrc8oXcrevHSwOrh8BClXzI/ZUwQMf0TSsZH4vWlALBGmEw9fsltLpLozEvHOUk
 5R1sesl7IwOiP1PJAHBkpvo2LyTwqnS1iP+8CFS5K92c+fgknRc9VuYl6fnuLjj8N7K9
 oPKkOFnGVMI7Ij3Q/mN8JX43FcuDAisSAUVI52bbE8oFuLelYcDXPzDapz/L3v1Q9EKH
 eYMnAbhGA5+VZE/O4bOdZH8hqg2HGkvVa5f1cmbeF1dIRH72eAjdEDl+pdJslv8fCvjU
 NLgfOZE78+4iSp0S3Iutk6sg7vppTFv8IQAkhYROVWlH4n//UM2YRL0LZdh4BwVFze0k
 hZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=urN59fDOy9ly5Z6F/XEbHP15XfrcXu7u3A3Dq8sjaFU=;
 b=AmR6LB5pvFbHecXbzfTdCPQbDmLa5LzoQhFhOSjnclcnp4ZnfOWodIYua47VT8BjKt
 58QjXN+aCG5kxFFG89QtsboVAnJlmD6tdCmBiqTe1vT6utzMJVASdGnAfmfRhxzyxMMW
 4zwZpLmZYCXpSDq62UR4bYgtMI3hZdPuiP/epgdaEG3Tski/KHuVeGNwRDvlG1b4W886
 JInPRMPnJBWwXbWnzVC4af8QRXVAbDQ8DhDw7P0mQ/ttidBrDiqSiy07igKHIju8APu3
 xNCyxKfKjSIa2ZLgiyfyWmfxvInW04uwH9kefVbv2SuaqoubC899+kQDvXayFGKcnhht
 DZRw==
X-Gm-Message-State: ANhLgQ0iT3ouUDEEi6BHXfeaHYjm4k7btGtxMNt+2t3wR6w03Dzjxj6o
 YIQQf6vnyhNC/rU/Ke3AEpbFrPlk
X-Google-Smtp-Source: ADFU+vvOEdEyvVvUKnugxLz6YGwJfJZR1kIEzWnOjqBr35Wanld+ouEYfF8CxVUTGpc9RsHGH+kSAg==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr334211wmg.181.1584805991852; 
 Sat, 21 Mar 2020 08:53:11 -0700 (PDT)
Received: from localhost (108.78.124.78.rev.sfr.net. [78.124.78.108])
 by smtp.gmail.com with ESMTPSA id y200sm13575548wmc.20.2020.03.21.08.53.11
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2020 08:53:11 -0700 (PDT)
Date: Sat, 21 Mar 2020 15:53:03 +0000
From: sylvain.bertrand@gmail.com
To: alsa-devel@alsa-project.org
Subject: monotonic raw setup seems buggy
Message-ID: <20200321155303.GB357@freedom>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/ (2018-04-13)
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

I am writting an alsa application and while working on pcm status timings, I
noticed that setting monotonic_raw timings in sw_params while the hardware
device plugin is already running with monotonic timings did not produce an error.

Follow the pcm dump which shows monotonic_raw being set on all plugin instances
but the already running hw plugin instance.

Is this a bug, or am I doing something the wrong way?

Plug PCM: Linear Integer <-> Linear Float conversion PCM (S32_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_NONINTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC_RAW
  period_step  : 1
  avail_min    : 1024
  period_event : 1
  start_threshold  : 1
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC_RAW
  period_step  : 1
  avail_min    : 1024
  period_event : 1
  start_threshold  : 1
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Hardware PCM card 0 'HDA ATI SB' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 0
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 1484839806

cheers,

-- 
Sylvain
