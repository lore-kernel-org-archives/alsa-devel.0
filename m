Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39FBCD98C5
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Jun 2026 17:26:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48706601F1;
	Sun, 14 Jun 2026 19:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48706601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781457994;
	bh=uecn5tRBpAYT6poCHvZfOkDfVlcEZiIXKJIniw/uVic=;
	h=Date:Subject:References:From:To:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LxQqu/DG4Hn6Bh7L+5G3Ir4xmv7i63494fFzIRr8rOiFG2VWgIQD3d7AjpE0/Erbj
	 9e5aIr2jntYgmn0SuvHifzSY/oXLlaIw+QEIEXtIP7JPJKZ/4pDyHiVclEzowoUjUX
	 1RWfUF+G/KdZEXiZc6k6l18MGhHzgiwwP397m770=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A9FCF805FE; Sun, 14 Jun 2026 19:25:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ED4AF80553;
	Sun, 14 Jun 2026 19:25:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3A5CF80524; Sun, 14 Jun 2026 19:25:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781457953;
	b=M371WNTow3fXlRgvfn5ryX54hGbbM2N6grNmpjVDe+Qi37n8hPw8BJlFjE1lsD/A7wWg
	 Ld7leD41qSZ22Lh0kn/ZW8GSFq7JL6sV2jzZ7SZvz8eg3IDOKJxUUi/YcwgUXAKvp7SAA
	 90v/Qn3vrJZF5wlY06a99FZaKiEnZByuKl2h18khzr0ngoNEdhL9RQPyc0+peTV46XJn4
	 Fo+1QG6a2+Mf2C5P0zu2di0bE9oQSjbztFYkj7OuySEIdCLK5xKDNt5ha3mqKsEj/MaDg
	 HvytMi6KS3crHbWrZJu7pc7If4o056D3zSKvQY4n6eIJx4uivLCJAsBLlvHCQYXbm7Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781457953;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:From:To;
	bh=uecn5tRBpAYT6poCHvZfOkDfVlcEZiIXKJIniw/uVic=;
	b=fRgtpCXGF7/a24pkhnQm+zwRx1cALtqjpPe9h/eXAgyCnZ7cyHDpFloHe4YIa8LuxxUW
	 AJsYu6IZhuiICJVPyhBth8kVOxZqSV2FhOkJrD7OpckNVBU9B3lzdTSNRLhvzTovc/5n5
	 8k4dD3Xcs3J7xpup7Mg7UW+VkIbUAilORIXeu4rKlzIzUH88SYEf+o3za0RtZ68ubopOQ
	 Z1HHUImqf+3xt/2BIQ3TC9xpeTRlDTT8Gx77jR2Leu2iRjjNJnViOt+LBSeMOkSCY2X7+
	 68OxqeFpoo+PZH8f1Khzw/+o4dFlS8vT1MJu8hloLnA2dnJ/vQm4u9v6zYCSIvc0h5Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 374B3F8010B
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 19:25:51 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B565A3A206
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 19:25:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B565A3A206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1781457950; bh=9gcOklvcuHKiZYu74XWjf1skpNS6wDKyhBntnrODMfA=;
	h=Date:Subject:References:From:To:In-Reply-To:From;
	b=fzO9ATrR54NhEEO0qlGRnqP83/CNoBRjsesK6IaorAZMwHOEBPfzcVcnR52nmE8A2
	 eVxNwrYewzQ6zQGhMeAWXG1lgTei+tRIYNU9wnGpCAG0SGgtcM2hzALimkKxZacV+U
	 FVtl7rHj0JAD09BD7h90LHj2vdQhznc0QC8ZhEns=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 19:25:49 +0200 (CEST)
Message-ID: <31fdd25b-b8c7-41f9-a04f-a14042f881bd@perex.cz>
Date: Sun, 14 Jun 2026 19:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ALSA 1.2.16.1 release
Content-Language: en-US
References: <ecd1660a-6293-493d-994c-1cfddd4de25c@perex.cz>
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Autocrypt: addr=perex@perex.cz; keydata=
 xsFNBFvNeCsBEACUu2ZgwoGXmVFGukNPWjA68/7eMWI7AvNHpekSGv3z42Iy4DGZabs2Jtvk
 ZeWulJmMOh9ktP9rVWYKL9H54gH5LSdxjYYTQpSCPzM37nisJaksC8XCwD4yTDR+VFCtB5z/
 E7U0qujGhU5jDTne3dZpVv1QnYHlVHk4noKxLjvEQIdJWzsF6e2EMp4SLG/OXhdC9ZeNt5IU
 HQpcKgyIOUdq+44B4VCzAMniaNLKNAZkTQ6Hc0sz0jXdq+8ZpaoPEgLlt7IlztT/MUcH3ABD
 LwcFvCsuPLLmiczk6/38iIjqMtrN7/gP8nvZuvCValLyzlArtbHFH8v7qO8o/5KXX62acCZ4
 aHXaUHk7ahr15VbOsaqUIFfNxpthxYFuWDu9u0lhvEef5tDWb/FX+TOa8iSLjNoe69vMCj1F
 srZ9x2gjbqS2NgGfpQPwwoBxG0YRf6ierZK3I6A15N0RY5/KSFCQvJOX0aW8TztisbmJvX54
 GNGzWurrztj690XLp/clewmfIUS3CYFqKLErT4761BpiK5XWUB4oxYVwc+L8btk1GOCOBVsp
 4xAVD2m7M+9YKitNiYM4RtFiXwqfLk1uUTEvsaFkC1vu3C9aVDn3KQrZ9M8MBh/f2c8VcKbN
 njxs6x6tOdF5IhUc2E+janDLPZIfWDjYJ6syHadicPiATruKvwARAQABzSBKYXJvc2xhdiBL
 eXNlbGEgPHBlcmV4QHBlcmV4LmN6PsLBjgQTAQgAOBYhBF7f7LZepM3UTvmsRTCsxHw/elMJ
 BQJbzXgrAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDCsxHw/elMJDGAP/ReIRiRw
 lSzijpsGF/AslLEljncG5tvb/xHwCxK5JawIpViwwyJss06/IAvdY5vn5AdfUfCl2J+OakaR
 VM/hdHjCYNu4bdBYZQBmEiKsPccZG2YFDRudEmiaoaJ1e8ZsiA3rSf4SiWWsbcBOYHr/unTf
 4KQsdUHzPUt8Ffi9HrAFzI2wjjiyV5yUGp3x58ZypAIMcKFtA1aDwhA6YmQ6lb8/bC0LTC6l
 cAAS1tj7YF5nFfXsodCOKK5rKf5/QOF0OCD2Gy+mGLNQnq6S+kD+ujQfOLaUHeyfcNBEBxda
 nZID7gzd65bHUMAeWttZr3m5ESrlt2SaNBddbN7NVpVa/292cuwDCLw2j+fAZbiVOYyqMSY4
 LaNqmfa0wJAv30BMKeRAovozJy62j0AnntqrvtDqqvuXgYirj2BEDxx0OhZVqlI8o5qB6rA5
 Pfp2xKRE8Fw3mASYRDNad08JDhJgsR/N5JDGbh4+6sznOA5J63TJ+vCFGM37M5WXInrZJBM3
 ABicmpClXn42zX3Gdf/GMM3SQBrIriBtB9iEHQcRG/F+kkGOY4QDi4BZxo45KraANGmCkDk0
 +xLZVfWh8YOBep+x2Sf83up5IMmIZAtYnxr77VlMYHDWjnpFnfuja+fcnkuzvvy7AHJZUO1A
 aKexwcBjfTxtlX4BiNoK+MgrjYywzsFNBFvNeCsBEACb8FXFMOw1g+IGVicWVB+9AvOLOhqI
 FMhUuDWmlsnT8B/aLxcRVUTXoNgJpt0y0SpWD3eEJOkqjHuvHfk+VhKWDsg6vlNUmF1Ttvob
 18rce0UH1s+wlE8YX8zFgODbtRx8h/BpykwnuWNTiotu9itlE83yOUbv/kHOPUz4Ul1+LoCf
 V2xXssYSEnNr+uUG6/xPnaTvKj+pC7YCl38Jd5PgxsP3omW2Pi9T3rDO6cztu6VvR9/vlQ8Z
 t0p+eeiGqQV3I+7k+S0J6TxMEHI8xmfYFcaVDlKeA5asxkqu5PDZm3Dzgb0XmFbVeakI0be8
 +mS6s0Y4ATtn/D84PQo4bvYqTsqAAJkApEbHEIHPwRyaXjI7fq5BTXfUO+++UXlBCkiH8Sle
 2a8IGI1aBzuL7G9suORQUlBCxy+0H7ugr2uku1e0S/3LhdfAQRUAQm+K7NfSljtGuL8RjXWQ
 f3B6Vs7vo+17jOU7tzviahgeRTcYBss3e264RkL62zdZyyArbVbK7uIU6utvv0eYqG9cni+o
 z7CAe7vMbb5KfNOAJ16+znlOFTieKGyFQBtByHkhh86BQNQn77aESJRQdXvo5YCGX3BuRUaQ
 zydmrgwauQTSnIhgLZPv5pphuKOmkzvlCDX+tmaCrNdNc+0geSAXNe4CqYQlSnJv6odbrQlD
 Qotm9QARAQABwsF2BBgBCAAgFiEEXt/stl6kzdRO+axFMKzEfD96UwkFAlvNeCsCGwwACgkQ
 MKzEfD96Uwlkjg/+MZVS4M/vBbIkH3byGId/MWPy13QdDzBvV0WBqfnr6n99lf7tKKp85bpB
 y7KRAPtXu+9WBzbbIe42sxmWJtDFIeT0HJxPn64l9a1btPnaILblE1mrfZYAxIOMk3UZA3PH
 uFdyhQDJbDGi3LklDhsJFTAhBZI5xMSnqhaMmWCL99OWwfyJn2omp8R+lBfAJZR31vW6wzsj
 ssOvKIbgBpV/o3oGyAofIXPYzhY+jhWgOYtiPw9bknu748K+kK3fk0OeEG6doO4leB7LuWig
 dmLZkcLlJzSE6UhEwHZ8WREOMIGJnMF51WcF0A3JUeKpYYEvSJNDEm7dRtpb0x/Y5HIfrg5/
 qAKutAYPY7ClQLu5RHv5uqshiwyfGPaiE8Coyphvd5YbOlMm3mC/DbEstHG7zA89fN9gAzsJ
 0TFL5lNz1s/fo+//ktlG9H28EHD8WOwkpibsngpvY+FKUGfJgIxpmdXVOkiORWQpndWyRIqw
 k8vz1gDNeG7HOIh46GnKIrQiUXVzAuUvM5vI9YaW3YRNTcn3pguQRt+Tl9Y6G+j+yvuLL173
 m4zRUU6DOygmpQAVYSOJvKAJ07AhQGaWAAi5msM6BcTU4YGcpW7FHr6+xaFDlRHzf1lkvavX
 WoxP1IA1DFuBMeYMzfyi4qDWjXc+C51ZaQd39EulYMh+JVaWRoY=
In-Reply-To: <ecd1660a-6293-493d-994c-1cfddd4de25c@perex.cz>
X-Forwarded-Message-Id: <ecd1660a-6293-493d-994c-1cfddd4de25c@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: TTKBTDZ6ZO5YXREJIWQ6R2CQK4GMIREU
X-Message-ID-Hash: TTKBTDZ6ZO5YXREJIWQ6R2CQK4GMIREU
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TTKBTDZ6ZO5YXREJIWQ6R2CQK4GMIREU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello all,

	new ALSA userspace packages were released. You may download them from
the ALSA website http://www.alsa-project.org or directly:

	HTTP: https://www.alsa-project.org/files/pub
	FTP:  ftp://ftp.alsa-project.org/pub

Released packages:

	alsa-lib
	alsa-ucm-conf

Full list of changes:

	https://www.alsa-project.org/wiki/Changes_v1.2.16_v1.2.16.1

The fingerprint of the public signing key is:

	F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
