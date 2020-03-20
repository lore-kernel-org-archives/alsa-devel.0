Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200BC4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C02020722
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XZJ/O7RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C02020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E59B44E;
	Fri, 20 Mar 2020 23:30:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E59B44E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584743492;
	bh=n839r17MK3HGojaz9KXwxrXr+ti8UvfSnG9Vmi/NH9g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XZJ/O7RS8P3StJ+bDQCXw+8tz/LngvJPH/T82OGnawf+IaaCb8Nfx4ISV0tpRs52O
	 mAiAG+oBC+ibM2qVPzWSaZSKFuzVXi7422fo577rdRsR96jDLhcvtQ89godPJN1YnM
	 CNPUxrJ+XewxVW/y+5OR9g2BIEvIEBCWsHrbnJwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB915F80139;
	Fri, 20 Mar 2020 23:30:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25364F8015B; Fri, 20 Mar 2020 23:30:39 +0100 (CET)
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [104.237.132.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D994F800C0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 23:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D994F800C0
Received: from [10.2.163.76] (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by avon.wwwdotorg.org (Postfix) with ESMTPSA id 693141C0474;
 Fri, 20 Mar 2020 16:30:30 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
Subject: Re: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use
 WM8903
To: Dmitry Osipenko <digetx@gmail.com>
References: <20200320205504.30466-1-digetx@gmail.com>
From: Stephen Warren <swarren@wwwdotorg.org>
Autocrypt: addr=swarren@wwwdotorg.org; prefer-encrypt=mutual; keydata=
 xsFNBE6KoecBEACosznehcVarBMNKGOiQ4MBbDAKQo73RDLP4hKEtaTVoQKg7tAM/tcQgbR6
 p1NSxVq9tunbEskwHkHc/ES/xT+JBFMmG8mh2SmBocyuNjlN8lsW8r2CuLA8EuDr7Laz5yl0
 Gf/G3Q+yYH+ytUnUuPmlxTueR7MNxIT0lz0fjil2HJclha/T3o8osagYWsXyN9Iaqy+6YTit
 fG4hVCr0s+3SYylRp9m2/LaP0CPTQVCJKnv1Oq83PnnV/BA/9sBYxDaVNGfdz2FAWqSH4H7q
 oyonAMzsF7f/cTYcFGTN3kL3UonG43DHpqCv+gHMKITBCxN+3HjX4wuNC7raoHVRRbx7/JES
 ZrJ1ymKdMNxl8bquldTk6VyAJlTRjuq7jRY9LIEHcns91MYFgpz7RAhCPmXnsMgpuIvU/yTE
 aApIAkHSo2Nyk9NeyIsji5voa9VAAoZKLGFTkhyPLEcjU9JmH/x224zGLtK28bL+P61PCk02
 jG7RTF4665IDbmC8UNvEm9mBgFNlEgOPqbVF9oa5Gd9cnaOTucDLJqjCpM53SM5Jd3eRHk7A
 zDHSBWsRsmKXU4hhxlu+90tb7I0TcjPfqeCrO46rNELdskcJAlLzx0v07+IhhGAM70oAbP49
 VBA7hsVCimuITFSUUwAtzFJmFg/mjxNdftTr3yssaK41VmxsIQARAQABzSZTdGVwaGVuIFdh
 cnJlbiA8c3dhcnJlbkB3d3dkb3Rvcmcub3JnPsLBrAQTAQIAPwIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AWIQTmd6/Z3M3mpZiMqw6bjacJJlQhnAUCXboEKAUJERCVvgAhCRCbjacJ
 JlQhnBYhBOZ3r9nczealmIyrDpuNpwkmVCGc074P/jq2nW6yORiLCgiTX3I0ro0sUq6aOvkq
 WH/g1Oq4fTr6TmabZVFvuuUZDF/AwB6p0Mm6tWar29nF1/OEx7QrrrHrBEcaAEHmZFjoenDK
 3SJDHDLBkcuMiZS7CFdb22vBYrgzoHwptySrRcHWW5rxhAKgyTX/p7F96zicNPS1sljc7JNW
 oik6b90PmCeKCeuoH4ruBO+3naDInKrL389xvujF38aTkgai9DJtWjWizZzAP+DWJrHtb6zz
 fsPA41hnZ5mKmUbiuJehPbv0+Q6QSFjLhNiP6lvkV34uANH3TQn2o6nApoa3XT5fIxrJOFrz
 q6xuM2tcyd/dRr1TdtIQCRABaKYIF/mgtMa19+GbLI8A/t1RmxEhlctSEUOFO7E3PNiwIjvI
 OpqZjq3NR8/+Lw2Zv9H3B7Wywk87ESwaYhYL29AzVvAMKFYHpDbn0abN+GVyit+fVbrUvKed
 nr63H7bG81O1DBA44gBDaIZhwOQDqeTou05rFa2PLGbdd6YL8AM6nWVI9UqD2+aKg1GcXtFO
 cq3Ll5fzUoSys13a14cCDLI82XvPxJh8TOtC8wJywYwAa75ieuVXxWh74d9qRYq3iJZpIWCE
 s5NkkGN4Q1dul84OQrwiN+2PYH+k2M6MGMt+9MHEoR+vrtMNUIeCa/ctYX6mb+nSPZAr5Fx0
 LZMdzsFNBE6KoecBEAC5xnYhQJCsaOCCTrzpnifMCUC0zLvhKgdChd4QAJm8ap+qufkbz3oF
 iJx1u19AbX8PNT3mdtwsguJhcamdT49YepVEvo6znc4S/pxjbX882CovKoOqSPSnE9VIbLHG
 VnxwDQGp2cbdqYOF7qvr4wGliR/X1Hx72EK3kSppvGEQp/uyW0QzHUC6XX9TdKawWAPohaqm
 TXqaQSMp6uOhNCTmydTAN2V4bJpQBU3BpNNtBZ+mnHlu/Yl74x0tgIYBqxEVdYz3Ryn1FTTC
 NCKcGiO8px2e7VBsKAiC9tRMZYjuH5HaS0SgI2asbAqX1OduiC1BTvM9P3oqps0Vs8zR7nxt
 Lodws79Vjoc0Ab/5BSEMIooww0Eo/VYwqnMs6Bvk5dtv7kCVRMUyV2JrTD0cCw0E+urjW5Dw
 kr4hRDTi8Xr45WecHxXMHZOllE4q8PxaK+rwoX0boXIQ+i3bL6Nemj3d6+ELYe5Dpswzmn0Z
 RrDegq7ly9303bEve09cIVZ4PS2rkx54bGN9R9TgXhU7XnRHyCSKFE8vSXXyG9Lu2aHq+od1
 bUoTOQfoLOAeJOrbo+crZAq33W69t6rD0Q1WHuvzd2zpOQdlsrUOGkDKuk0dBxpzlf8uusaD
 lE5fjd4RQXreKVjSKczrMd9uhLe2cdsVNFljHZlXnFRciNsUge6AKwARAQABwsGTBBgBAgAm
 AhsMFiEE5nev2dzN5qWYjKsOm42nCSZUIZwFAl03xTwFCRD+ZlUAIQkQm42nCSZUIZwWIQTm
 d6/Z3M3mpZiMqw6bjacJJlQhnA+lD/9/DbFI8lUQyb0ZOBLHW6iX+Ps++hElYOmjL4T4f6wa
 FMNiFk2lPom/xq8OL5B2swWC7w5o/j+GwrS6MbkL/s932zQ15+AVD0HfhTBKKQEnQUPVLM2T
 9AcXpY0s8AYsWa89YNTJpdbFc5ep/Nx6R3rYu0ixJtrJT+p19qhIavMRaHMYuxGLO4xs4CUO
 Z2kq6+KKNIAi63FjYBLYPPGd6KyXSj1zWZwAE6qLLPl/MGrbKSqETj01Z7NuGYbJNVi0ooIq
 b+iBGsPQRx6FhiVXbo9eheBJ/Qui4QVCur2WFzxzlhqTDknA0d5by+tQvg4NUmm0u64YIeGQ
 5U4wLL60kch1Cr1MSM9eBi1fsq3FRCd7QQnCO3MaJ9odE5BaHKpDFzd9cxrBA/StoDkiU6Ci
 o9HrHblS9gNQemZT+WTSA/t7dB97NesqGbDtdW5G0wfliNFmvS9qDpUe3hSa6f9PgCz/8QzS
 aXcBhnI7xRoXZxRKo3mnNihC/5hnNxMsUP5oNdhRPVyTs8wlLKXBHXUpj6OgoFO01e05Niak
 UR3Mub2hXCUcJ3UuO1+nxY88x+K86LZnMCa+0A6RTeTJAz6aaF2Fr/h7xncLk3LG3/ODQFjb
 S1cWYsAeg++INJffJzend+91hvGp1WcI8TGc6BjYnO5mKBuVumOKXi4wa2OJo9y3lMLBkwQY
 AQIAJgIbDBYhBOZ3r9nczealmIyrDpuNpwkmVCGcBQJdugQxBQkREJXIACEJEJuNpwkmVCGc
 FiEE5nev2dzN5qWYjKsOm42nCSZUIZywWA//d3PsJki5IAkAsALeF+qMHtyGFCf/vc1V91jN
 MC2wuAo7MKLxQDyMdkjSp0s+UrDzTY9bYocfB2G3mXnJDEzQSd6snf0pEMQVf77SGbddcFCO
 GsfJuE6DmsSjVncK3JO9/eXeqyTup/PNN2RYkuR394+RxeUvf/f1km80DtO0beI3g/EtMSE1
 ljLwDuh98j9qVSJ0xK7cmf/ngi703BltS8rpoXDioS1fTlVFdJpGOH94PVlyJsDbHy4rDeFU
 Ptk1Q0hRGKNpCPCVQntLAc3mH9++3oVxxCsvgUfjHbgwzptTGj6SbXH3piyBPMHRXhtIiHRH
 kkrxbMKGuzkU5dPmMv7Mzw9yaMYY8mmPZMPJoLA0bW6DuZ1nAz9U7njM/xb1WIZHKA8HVfTz
 4fO8lP7jxCod6uBvu3vgBRbYTu3QoQjxhIjbAE5P9ZxLggx919dKypYiXeIPB8OHg5/4LwEi
 f+rjKF/HHMo+ZCJx9BCZeW5yNkeTm638JfD1XjrZzDNsawdMFFdGL5TJrubu52fxsml41ay6
 Qacni4jVUmZDP1HVYzcQN42O7ynZKMecpwM3G6V9L3Ifs8VpfdPpOnJb6TOXUOrITz4kyHDy
 0hRsU1DwGeqzyyZAJT6MHZR0qO93XKFy9+WgzUXS2j0rQ9D4zTQI4c0Zp3ri8v5ZDXJh1W0=
Message-ID: <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
Date: Fri, 20 Mar 2020 16:30:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320205504.30466-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 linux-tegra@vger.kernel.org
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

On 3/20/20 2:55 PM, Dmitry Osipenko wrote:
> Hello,
> 
> This small series adds audio route for built-in microphone on NVIDIA Tegra
> boards that use WM8903 CODEC. In particular this is needed in order to unmute
> internal microphone on Acer A500 tablet device. I'm planning to send out the
> device tree for the A500 for 5.8, so will be nice to get the microphone
> sorted out. Please review and apply, thanks in advance.

It's been a long time since I looked at this code, but the series looks
plausible,
Acked-by: Stephen Warren <swarren@nvidia.com>

(I wonder why machine->gpio_int_mic_en was already parse but never used!)
