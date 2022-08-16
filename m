Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C721AC19F2C
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Aug 2022 05:18:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A0031657;
	Tue, 16 Aug 2022 07:17:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A0031657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660627118;
	bh=OgBNPZMUeZJ7iLmldXk+LO1iBtHAXZU6BH3v6hUlub4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dvKaLKwii4Gn8hgpjiVbC6NqmORAI+U0ZK5R/wzW4fGk3VRYAtTQyZyQrOpyrGtHj
	 pt2iuN7Tz6wGP5mB2uBydGors0rd8vVWDiFQyql6JA2UJX+8hxLF9+nKUf9vYH+4zH
	 RxZjlWJ3RCTwo7qlyc1h4uGJUTL5khYIEwYQj5HI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D640DF80559;
	Tue, 16 Aug 2022 07:16:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E90A8F8025A; Tue, 16 Aug 2022 02:44:46 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9B8EF80082
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2022 02:44:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9B8EF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="pWC3jMMy"
Received: by mail-vs1-xe30.google.com with SMTP id k2so8752464vsk.8
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2022 17:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=x+nXfAsFHmklQix7FhiT/itr5LkqOMz5uA8s4LEHCOI=;
 b=pWC3jMMyjvcjCZFbsVI8WhDimlRC1MyAOZc02oXQyFKMwQ1kFO4B/0iVlc6o3gjfVf
 aav+I30j5MFiKHPvs8QTdKL4nybMNZ1sy1TPimL9BVbgvRXtpg6Ooh2sfT2YFPdATmAj
 aTL3w0JTDA52oMN2KkKBzQdioSgsK3HIx/rYfDxzdW9AsDtJZIp3Sz4vc2snk8USgcgL
 4BNT5Bo4FuTuzX7nlJQkhBplqUZhD/lbw95/4dJWknkOzXL4rrMeuVKBdDnCLzMCuCOo
 iT/hJQypu4PibdFiaT41yhjAol1EmB8fLlvpq2aMs6+03D8XIKUsRPsYNiClBdFNeL4Q
 uhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=x+nXfAsFHmklQix7FhiT/itr5LkqOMz5uA8s4LEHCOI=;
 b=s3bYNTIvD5hVFusVVNXuApbSf3Dhaqdc5+rfSDJZx6y7nlpbPr4htwwZGpSg57MWzR
 JhQG7Y7nJ4EW5zwa1raPncM/YREzCfFsOCAgdjZ86zmSTtPXJkR+wtKYYnMQVBAAhzff
 uhpBUbEt0UwkpEQkQG6O0brbF2WqzTnltmugMeZHhzle4dgGHlYYxjsHCmaO79F/+p4s
 v8lr2aKddpP90SQCZK3QsIJ+nazUgFiYl34gSJv49+JMVYPugykndx5UM+nqL6I97Kwr
 yH2UOEHq8nlNs9m96Unw/z74p0ZscMQqDcpY+XocVZQUjAIH/bvlNhoW/DI6CFMcrJ3b
 5w3A==
X-Gm-Message-State: ACgBeo3TKK4d/cNeuB0BH/Oij6IXA3JENrXRJt3rBm3eNqdAMoIgARBl
 5w8wcrNc3mSd69nAH5NAx/0=
X-Google-Smtp-Source: AA6agR7ffAA/nAHdAEFNQJB+PXKuvcgcZGEtmWHBs7BZZ7obWQyE6pbAP4XvvH4/KxdkTPjBvvODjw==
X-Received: by 2002:a05:6102:3d8e:b0:388:acbe:fe38 with SMTP id
 h14-20020a0561023d8e00b00388acbefe38mr7209456vsv.51.1660610680055; 
 Mon, 15 Aug 2022 17:44:40 -0700 (PDT)
Received: from localhost.localdomain ([186.139.87.175])
 by smtp.gmail.com with ESMTPSA id
 a1-20020ab04941000000b00384d3ce037dsm6005131uad.4.2022.08.15.17.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 17:44:39 -0700 (PDT)
From: mbarriolinares <mbarriolinares@gmail.com>
To: connerknoxpublic@gmail.com
Subject: [PATCH] Add quirk to enable Avid Mbox 3 support
Date: Mon, 15 Aug 2022 21:44:27 -0300
Message-Id: <20220816004427.7117-1-mbarriolinares@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220417025459.8105-1-connerknoxpublic@gmail.com>
References: <20220417025459.8105-1-connerknoxpublic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Aug 2022 07:16:14 +0200
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
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

> Hi all,
> 
> I believe these are the right emails to send this patch to,
> but if I've missed something please let me know.
> 
> This patch enables the Avid Mbox 3 audio interface to
> be used through ALSA.  It locks the device at a 48khz sample rate.
> Then it mutes and raises the appropriate channels/inputs to allow
> for expected functionality.
> 
> Thanks for your time.

Thanks Conner for taking the time to write and submit this!

I have an MBox 3 (USB) and I've tested the patch:

1. Have not tested S/PDIF i/o because I don't have hardware to plug it.
2. Output is in mono. It seems the monitor outputs work only in MONO. 
   (with and without the front mono button switched on or off).
3. Haven't tested if Headphones output work in stereo because I don't
   have hardware for testing.
3. Inputs work great. 

I'll get a stereo 1/4'' jack to 3.5mm for testing the headphones out.
You can contact me directly if needed.
