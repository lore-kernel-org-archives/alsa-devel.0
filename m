From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Mon, 24 Aug 2015 10:37:32 -0500
Message-ID: <55DB3A3C.2080506@linux.intel.com>
References: <20150824132904.GA665@acervm.homenet.telecomitalia.it>
 <20150824142625.GM13546@localhost> <55DB32C5.8050906@bazdara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 33BBA260471
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 17:37:58 +0200 (CEST)
In-Reply-To: <55DB32C5.8050906@bazdara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luka Karinja <lk@bazdara.com>, Vinod Koul <vinod.koul@intel.com>, Michele Curti <michele.curti@gmail.com>
Cc: alsa-devel@alsa-project.org, ao2@ao2.it, jarkko.nikula@linux.intel.com
List-Id: alsa-devel@alsa-project.org


> The Asus T100TAF seems to be using the SSP1 port too with a RT5642,.
> I have tested SSP2 and SSP0 firmwares, only getting heat and clicks,
> errors reported by Michele are the same on my device.
> In the DSDT there are only references to SSP1.

On the original Asus T100 there are also references to SSP1 but they are 
not related to audio at all (they are in the XHCI1 scope). To the best 
of my knowledge the SSP number is not configured in the BIOS, that seems 
like a red herring.
Can you please share the DSDT table for this device?

Thanks,
-Pierre
