From: Luka Karinja <lk@bazdara.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Mon, 24 Aug 2015 17:05:41 +0200
Message-ID: <55DB32C5.8050906@bazdara.com>
References: <20150824132904.GA665@acervm.homenet.telecomitalia.it>
 <20150824142625.GM13546@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.bazdara.com (server.bazdara.com [84.255.206.229])
 by alsa0.perex.cz (Postfix) with ESMTP id AEDBD2608ED
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 17:05:42 +0200 (CEST)
In-Reply-To: <20150824142625.GM13546@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Michele Curti <michele.curti@gmail.com>
Cc: alsa-devel@alsa-project.org, ao2@ao2.it, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org


>> Damn, completely missed..
>>
>> Hi Vinod,
>> if it's possible, could you please generate a fw_sst_0f28_ssp1.bin
>> also, so I can test my driver (mine was for the Asus X205TA laptop,
>> where the codec is on SSP1 port)?
> Are you sure you ahve SSP1 port enabled. I have not seen anyone using that
> one. Jarkko do you know about this?
>
> I will ask firmware folks for generation (i don't do that) and get back
>
Hi Vinod

The Asus T100TAF seems to be using the SSP1 port too with a RT5642,.
I have tested SSP2 and SSP0 firmwares, only getting heat and clicks,
errors reported by Michele are the same on my device.
In the DSDT there are only references to SSP1.
