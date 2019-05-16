From: Matt Flax <flatmax@flatmax.org>
Subject: Re: ASoc : cs42xx8 : merge cs42xx8-i2c.c into cs42xx8.c
Date: Thu, 16 May 2019 21:04:17 +1000
Message-ID: <051ac4e2-db35-ccd4-02bd-26898698be2c@flatmax.org>
References: <e182bf72-c369-7344-e4d1-0524b09ca489@flatmax.org>
 <15b3a74a46f3c17f9240e5d90805e4056f80c55f.camel@nxp.com>
 <20190516095234.GB5598@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78AF5F80C18
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 13:04:27 +0200 (CEST)
Received: from [103.217.166.89] (helo=[192.168.1.154])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>) id 1hREBP-0002hB-Mn
 for alsa-devel@alsa-project.org; Thu, 16 May 2019 21:04:21 +1000
In-Reply-To: <20190516095234.GB5598@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 16/5/19 7:52 pm, Mark Brown wrote:
> On Thu, May 16, 2019 at 06:34:47AM +0000, Daniel Baluta wrote:
>> On Thu, 2019-05-16 at 16:15 +1000, Matt Flax wrote:
>>> Is there a reason to keep these two related driver functions separate
>>> ?
>> cs42xxx codec has also an SPI interface. If anyone wants to implement
>> support for that it would be easier with the current split.
> Right, that's the reason for the split - the split would need to be
> redone if anyone wants to add SPI support.
>
OK, make sense.
