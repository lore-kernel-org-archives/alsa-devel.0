Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2700CD8CB9
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:54:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD72D60200;
	Wed, 10 Jun 2026 10:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD72D60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781081688;
	bh=rfHKo2BsIFf5LBDvYisQeztCD1wHPW4yosK+6jx/jMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=skUf01tU1xyBMX/0duz2T6YJKTFErJGblIh/OFJtKJRQ7jSUJh1W0gc9Jz71gEUcL
	 5r79pE9RUVJyp1zyGQhDL7DLZxZuZ9JqF5vxywUWOK8lq9idhwY1FePcTg5SQpCVuT
	 6tuMrJmsYKXY5pi/7armYSKelsaI3/X6OqvmUM98=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FC8CF805F8; Wed, 10 Jun 2026 10:54:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C27F805F5;
	Wed, 10 Jun 2026 10:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E676F8058C; Wed, 10 Jun 2026 10:54:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781081648;
	b=eXtG3uerxx+yRfeF/22altbHgyicuYZs4005DBVzH//HDp3sX7cqat14YJbHOWMLtO9l
	 bALplpuDYg7ZtPBOn3lMG18OGg4fuN5CwMEgHgKjiiAwH+90xEGBkJYSIkX6JQew6KxiT
	 ftTWSZoI+dJjPxJbN207DK3F1+6KOwrg981f8tkoQgGHG4FIZ58WiszR4JFVOKr98HaEg
	 RRZdRhPO6A9SzjWy8PF1w4YbAqnJx7VAWcXkBGyRlM+a+eynT5emI7nPDBypEF5XGo+Ea
	 gqZFo8YaN+gnrn5d5NsMs1T3Gw/xVgOZ6aPcJ5jxaBjvMU3gGCjg487+nXECSutr3iA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781081648;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=rfHKo2BsIFf5LBDvYisQeztCD1wHPW4yosK+6jx/jMk=;
	b=egAA35R+rKreIpaj2uQlxK9QP67RU2eqbNJ0bwpGmjAnqkTUXd+HnilMf5IjQVsVnRAn
	 Rj7+Mr+LNyC4MffMTVPcGuzQRVbNxCyVRfbua3BNwkHkR1dqvmgiC4XZp4KS0AKJcYhGe
	 2EWA0Xrsw4IXs2hA0VGEbtRF5+ptqyuT34AdHLMPxYSVeU82JEPCLP/Ja7A0L2XpL0lWH
	 XTo0Reu5zc9ivHgGsL9Hj1ky3FaJ8hkTtF+LD6FBc0QvvTIEXUyjJNHOtVXXWyTWBAQO1
	 DTgtKzc0jXMrq7Qd20/hD8W4uXcmugy7bwFZ45ViaSj2U1xjHsRgxUJvcGdKd2xdsyw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LFv1vv9h;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC5B3F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 10:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC5B3F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LFv1vv9h
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 87C7A40732;
	Wed, 10 Jun 2026 08:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1C81F00893;
	Wed, 10 Jun 2026 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781081642;
	bh=C9A0mbzrOaNvpsifB/cslG4XdJoD+uBzY6C1wWrtac0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LFv1vv9hDxl5mOnEUllg3V+dwldIZla1he4ZiXOvepWeYxtqnfIjvoXExDu9dFhdL
	 39yVutNM0m6XP0iYCbMxDeCaO+xUBDNcpFU3GvhwNXWgOEVCaspWvcgj5ZX0IzLb4D
	 D6VdU6AvjPl1rgd5WNrko7/kS3iTlbsnU3s/DVIwqUY7VWpIgkDxRW4dJtiLMeiu6M
	 2397zWUqu97+6cYcRr+n8yjV2gghHe4kstCFXrNjMb8Lh+tPM7TSH2iTTzRg+j6nmK
	 6j/onNEylcaGbdZm6AwyDKi+ySzRa6miGQS9JI1x9KeM/F+9kb44qTT6c6F194JpBp
	 2Bb7tndsbnDMg==
Date: Wed, 10 Jun 2026 10:53:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
	devicetree@vger.kernel.org, tiwai@suse.com, robh@kernel.org,
 krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Message-ID: <20260610-belligerent-chocolate-tamarin-9b9336@quoll>
References: <20260609071732.20939-1-zhangyi@everest-semi.com>
 <20260609071732.20939-8-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609071732.20939-8-zhangyi@everest-semi.com>
Message-ID-Hash: QTQMVDZMRFWX24GBXY2K5KEPSVSGPSV2
X-Message-ID-Hash: QTQMVDZMRFWX24GBXY2K5KEPSVSGPSV2
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QTQMVDZMRFWX24GBXY2K5KEPSVSGPSV2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 09, 2026 at 03:17:32PM +0800, Zhang Yi wrote:
> Add members related to HPF and mclk_source
> 
> Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
> ---

You already sent v1 and received feedback.

You just completely ignored it.

NAK

Best regards,
Krzysztof

