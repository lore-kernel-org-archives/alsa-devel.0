Return-Path: <SRS0=S+eB=7S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A628C433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:45:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4396206FA
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OK2g8rck";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g2Pa/sks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4396206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77EA51607;
	Fri,  5 Jun 2020 23:44:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77EA51607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591393504;
	bh=u7vrFLbpJQAV1cQ0kbQVK9ZLFY1aWi9nsqpax6+qOtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OK2g8rckHqYbjgvr2pEkhrIUfSwC0Ys8ZsCQ1y7qJVAo1s1vygy+5+dYyODbfMEeO
	 85xpGZ72fjTKSPI3qzTDgXx6OGx+8ZV1vnjUWmkBx5ObObGpmT1sw9TkrmvVQ87YtI
	 uIjlCVUs1uiiuLfFod0/1aCsApKO6Monr+cQllmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5D62F801EC;
	Fri,  5 Jun 2020 23:44:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BCC5F801ED; Fri,  5 Jun 2020 23:44:11 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35B71F80108
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 23:44:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35B71F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="g2Pa/sks"
Received: by mail-ot1-x341.google.com with SMTP id s13so8788420otd.7
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2020 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7vrFLbpJQAV1cQ0kbQVK9ZLFY1aWi9nsqpax6+qOtQ=;
 b=g2Pa/sksz/aYmEqxoJrzi8zsTy59HbDtq07j/fkreeSaJe3dQOsO526DKGeQaw0yPm
 9AnGaueO42FfatnAKl4P9xpq+EvS/6yZKuVn9jTUA1yzzqBSoag7Qnti6NiJXTrEu38E
 U9gEoKN7o0Oq9W2lOJNNppm6wgniFrffmaebApav2KRi5cSExINsz1PN+ZEqp05XzSpK
 FwkPU3yyVUV7fucokyE3BLb1vo+pxXGN7b3n4sJfGa4sIM3nyqeZ5DIhr0HIEC8LG4Ce
 uJqsElJiNcSkRj6JO05c7uQ1hHZkQCmXuyvvyPaFLCcN94CtOXKDvp6IhikkDR8afowM
 nzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7vrFLbpJQAV1cQ0kbQVK9ZLFY1aWi9nsqpax6+qOtQ=;
 b=kitmcJ08E0qxVgdjHtYTc5inCXrjYTjmVXm8VEMlOeOWyKg5YJbodC0lRbYjU8/DG6
 g3F1bVdkbf9dXTIGLGLaeMPqrryQ/9fuIMLBeeLAH1OFZiqJjdTn+ObW3J0V293bL7nh
 K3ZPt6HnTmQQZaffbJTX2ZuNUyQQNzmM6LGNbtVJkR+lpZ9rnoXmGw7WM/uomIbDx42R
 /gAOQFsOdHWlR7TKNza9Km+upWei+jlbbw8tR/xuNNv0IA5qbCs0eFZYDOQcdu9N8OPs
 yZ0T3vZ6Qkdi/aHp2boZbNyzt35x+95segiOvmUZgUeREPaqV522W5gehT+lIzG0KpCw
 jSIg==
X-Gm-Message-State: AOAM531KgDGNubH0fQG75otDxYx3WxhNE3pdIPMimTKs2Zaqw/YuVo4p
 f4ml+gbStSXRf/DS+UXOOBRycUiIFtkrp5i4nRF6AQ==
X-Google-Smtp-Source: ABdhPJwGmnxfoPiUbeKtyigW8TXtBuxy9Ingfhpbpr0TlDgmdeKUKLB60VrpSFlnEVS0oTCt4mU9IQZtiti2l2eVbxE=
X-Received: by 2002:a9d:4c0b:: with SMTP id l11mr9559158otf.139.1591393441466; 
 Fri, 05 Jun 2020 14:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200605211925.87873-1-john.stultz@linaro.org>
In-Reply-To: <20200605211925.87873-1-john.stultz@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 5 Jun 2020 14:43:25 -0700
Message-ID: <CAGETcx_-ZknGcGJQMesLFWAwUyidK00-6bqF6ZZPbyyYtSPcew@mail.gmail.com>
Subject: Re: [RFC][PATCH] slimbus: core: Set fwnode for a device when setting
 of_node
To: John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 lkml <linux-kernel@vger.kernel.org>
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

Hi John,

On Fri, Jun 5, 2020 at 2:19 PM John Stultz <john.stultz@linaro.org> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink to work for slimbus devices.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I thought Srinivas already picked this up and sent it to Greg.
https://lore.kernel.org/lkml/20200511151334.362-1-srinivas.kandagatla@linaro.org/

Am I missing something?

-Saravana
