Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6192FC33CB1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:53:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF092084D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XkaK+V2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF092084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BE1B17A1;
	Wed, 15 Jan 2020 15:52:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BE1B17A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579100019;
	bh=uqrwwcoUU46ap0zjdE8PMsICy2vQeCutUe740cIw/78=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XkaK+V2YBLNtL99F7fNXUhVlE3kLhJMg4ghAejRi7XTnFZlWCf4N3TzOx52EbcqqU
	 x0eWyy9lKrfXKRSRdw9DpjSzXAE4yuExZvsZRNhyZrUg+Z/wG/rZ8k14O8ydDkv3l9
	 tZK9btOc2YaZ08ZLAl2nLnku1oVBYbGYG97XXr4w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84F24F8014B;
	Wed, 15 Jan 2020 15:52:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32CF9F801EB; Wed, 15 Jan 2020 15:52:47 +0100 (CET)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0CDFF800E9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 15:52:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0CDFF800E9
IronPort-SDR: 8tmAY/Rwf9VwTq3FV25rHYhD5uVUP/CpREY+lVL8+Sz1UVCHhwLqE3Jj5V03GADVb+7+ZP1hOO
 XvaNFrV/2CWGR55nZvUGsjUjKxkWFbOS8l+3KNw8gt5+lkwXE6VhnUEtlATu+ANx8awMzWAqC6
 hJHJYZjWZZHjGd9T8U45WEWwIhGfscqnUz/LolSN0tM80QAb1RWhVRIFnKNIy7ZWmAvYHmkVBz
 Obx5ePVWCJR1HICCTtf3BgvKux/wUOTSN6G8jI+Kbcn8svhobb7969ZWw3iGVjhgYgGU5s5ujN
 ZBM=
X-IronPort-AV: E=Sophos;i="5.70,322,1574118000"; 
   d="scan'208";a="4440738"
Date: Wed, 15 Jan 2020 15:52:34 +0100
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: "Rajwa, Marcin" <marcin.rajwa@linux.intel.com>
In-Reply-To: <7ae52bb6-1af4-897f-7de1-34196d0ed1f0@linux.intel.com>
Message-ID: <alpine.DEB.2.20.2001151550140.9118@lnxricardw1.se.axis.com>
References: <7ae52bb6-1af4-897f-7de1-34196d0ed1f0@linux.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX03.axis.com (10.0.5.17)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] arecord: buffer-size dependency on period-size and
 other params
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


On Wed, 15 Jan 2020, Rajwa, Marcin wrote:

> level). So to be specific I issue such command: arecod -Dplughw:0,8 -r
> 16000 -c 2 -f S24_LE --buffer_size 1280000 tmp.wav -vvv. The arecord
> response for this is buffer size of 31992 frames, 255936 bytes. Now let
> me also tell the buffer size of 1280000 bytes is the maximum buffer size
> our driver allows, likewise max period is 268800 bytes. Now if inside

Not an answer to your problem, but just a note: according to arecord -h, 
the --buffer_size parameter is in frames (in your case, with S24_LE and 2 
channels, the frame size is 4*2 = 8 bytes), not bytes.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
