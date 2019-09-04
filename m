Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89841C3A59E
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 04:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4ED21883
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 04:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UXKm04HK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B6KQ7jUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4ED21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33149165F;
	Wed,  4 Sep 2019 06:29:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33149165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567571446;
	bh=nCitCXB2xrfIAPozcJ/Phndy6GoJSbmcsiESf7CrmSI=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UXKm04HKokItPK7rmRO+EZLqqJPOeINM+BhGZ4Xtp2ZOzdfpYwQoH/jHwbATuUK7Z
	 pNm7mymE5udxEnUAYRaHKvIFDbUPrGOW6Ecje/0BMENjY+WHPZTus/WkkRNI10syWO
	 gDBZqf2hUwWZkhV2NZFl1Yvi5ZQyaXGBbzoQBPdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69A1DF80394;
	Wed,  4 Sep 2019 06:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7BAEF803A6; Wed,  4 Sep 2019 06:29:48 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 200ABF8011E
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 06:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 200ABF8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="B6KQ7jUW"
Received: by mail-wr1-x42a.google.com with SMTP id 30so8674939wrk.11
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2019 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=h8bPpYndGMY8fHzb1z12tX/IN5Imv/raFfvURFDTTrw=;
 b=B6KQ7jUW6TueF+ouMvz/0fjPe7GMD/c7JfSOsrGmkajWTbyZ01AxmF9qmbBWCOWi4X
 QqlFWGL6HMqHOf3QFYiA6Ae2P/Z+kRF8vm8Dak0ShqK0/gOWEmBxgF+//d2j3WImW49J
 wtGLusXzdGhxYXoAKOZXosD6l0obKd7TO+aFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=h8bPpYndGMY8fHzb1z12tX/IN5Imv/raFfvURFDTTrw=;
 b=QZGePSjG6p7zoUQKkTvprI2LjZ/ipIpGtwPymWbNFz1+zr4wBqoTrRPg48uXy8jSZZ
 mresHlMGptCeahU3ywVtTpoEjaYdX6DJzNC+5rhZmC4KgOCCR6RXb9v8vdlEt6yz8EHJ
 fYnEZKj+duCaB0+XRtm11oHMEcHcmQ1wMGYipc4BXosjtDtLC+PQ5zh82Xf03FnGhutp
 0WWQxWkWQj/SgTHUYspNBcNvjvrZd0cqup33I3tPlzLXXeCljW8R3jhSjS1w8F7dsi5v
 WlOv5boKLRJLmHlra4pCTnuEQYU7k4g05Rt7L0ot88C8rPKO5JHsZ6qMmEOaD75lZThL
 g7VA==
X-Gm-Message-State: APjAAAVkHZ7EPA6iYA6rYUto8eZQ/vmD4kCVb84XROawHs8YJb+Vy3IH
 TNA3QpUXQ0VYTtYXeNvXj2lubZ6Q7/RBLBPARG5/t2EiA8Q=
X-Google-Smtp-Source: APXvYqyFTOCuKFnFSf5wGm3G6p/IyAwD9i4EAl1Rqhk4zKvyUf73LGLBPI9xXU/Teb1rEph4JEx1cH9J4i7fqzuy/Ns=
X-Received: by 2002:a5d:568c:: with SMTP id f12mr32746870wrv.248.1567571381242; 
 Tue, 03 Sep 2019 21:29:41 -0700 (PDT)
MIME-Version: 1.0
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date: Wed, 4 Sep 2019 12:29:30 +0800
Message-ID: <CAGvk5Pohb9cxL=Mu11RPVD66NdiZkG+vO9TEtqBWe1tnBn6qyQ@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: [alsa-devel] Alsa conformance test - a new test for ALSA drivers
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

I have created an new tool "Alsa conformance test"(
https://chromium.googlesource.com/chromiumos/platform/audiotest/+/master/alsa_conformance_test.md),
which is used for verifying ALSA drivers. Here are some main functions it
can measure:
1. Correctness of hw_params
2. Stability of rate
3. Stability of step
4. Runtime of each ALSA API
5. Underrun and Overrun

I recommend to use the script "alsa_conformance_test.py" inside. Just give
it a device and then it will test the below functions automatically.
1. To make sure whether all the parameters provided by an ALSA driver can
be used.
2. To make sure whether the measured rate is the same as the expected rate.

We have used this tool to find out many issues in ChromeOS. I hope it can
help development in Linux too. If you have any problems or want more
features, please create a bug in crbug.com and assign to me (
yuhsuan@chromium.org). Thanks!

Best,
Yu-Hsuan
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
