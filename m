Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1AC2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:41:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1A1223B0
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tU15PhFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1A1223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E7316E8;
	Mon, 26 Oct 2020 09:40:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E7316E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603701694;
	bh=3qF8xrz0rj+SD5jkKyuIPQ8cYRYJ/uoaks5b22g4fCA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tU15PhFW8I3UUB+o7yor/DU4XkS0QEcW7M+DFi3hBCsjJSHyazx9g+nHkcbGcG6kR
	 vl0pSupVCKqhUnolSKKHR1sU/meiN5e07qMj3SEjfUBtjCUDBxrKdsZYdJ5zKAyz8K
	 9GlEwqT37yZOv6pYd2ZbKhhprg6Tz6d9k5LZpxDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42F9BF801D8;
	Mon, 26 Oct 2020 09:40:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B0E8F80212; Mon, 26 Oct 2020 09:40:42 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8BB5F800CC
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 09:40:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8BB5F800CC
Received: by mail-ed1-f68.google.com with SMTP id t20so8359866edr.11
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fPY3YUMaHx0SYLGgmZyNAyMNlSCq8nr0Au+mUxZwASo=;
 b=MBaIh5UNhN8pPLt2Id1P1tIj9o3h+rNHqj2BISSd2t0z1AKO9RG4QySkrn9HB9Zq4Q
 6ZEo6VySvNW/0NiLd5aUGxpBiVqPJXBSAq+m/YEZ1lwOpAOOY9fzoWX4C6Cw3Zm2CTBu
 wtbfsNLs2Fe4OY07aJ9ix6T8v4DnC393M92cg6PcPeGb6QwPxYvSc86qkDlNL+cRpe5z
 KkRXeHzKKAjAs2hL6ePU2Ja51syMnwDqAYNS02yFbZjEb2um/EyatpjALVTAQGCYFtWk
 vZAx48ACgPQBTwvMw2vB997w1Uoxj0By0+zIjQtKO+wQTvr0hoE79zPw/3XVsTCCyHMS
 xhGw==
X-Gm-Message-State: AOAM530dX/n19FsOZ0/pRfFiYu/+6FMJDmU/+t8xuwsxK160NYqx2NQw
 QrmEwWpGnv9PqOoHDe99opw=
X-Google-Smtp-Source: ABdhPJzMNFAPm/G/FPe2T5GfoWx+hZWCWuIsNulsXqm9QWpIwDSzI0aXCpKKCmaS2zzfu6KxDgxn0A==
X-Received: by 2002:a50:8f61:: with SMTP id 88mr14969192edy.175.1603701634845; 
 Mon, 26 Oct 2020 01:40:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
 by smtp.googlemail.com with ESMTPSA id u10sm5306057ejh.54.2020.10.26.01.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 01:40:33 -0700 (PDT)
Date: Mon, 26 Oct 2020 09:40:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: More whitespace clean-ups in schema files
Message-ID: <20201026084031.GA7466@kozik-lap>
References: <20201023192258.3126047-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023192258.3126047-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 23, 2020 at 02:22:58PM -0500, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, and missing EOF newline in
> schema files. Most of the clean-ups are for list indentation which
> should always be 2 spaces more than the preceding keyword.
> 
> Found with yamllint (now integrated into the checks).
> 
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
