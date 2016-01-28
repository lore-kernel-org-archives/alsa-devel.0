From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: CherryTrail SST firmware limitations query
Date: Thu, 28 Jan 2016 10:05:38 -0800
Message-ID: <56AA5872.3020809@linux.intel.com>
References: <56A162A1.1070602@emutex.com> <56A1657A.5060600@emutex.com>
 <20160128162416.GR11130@localhost> <56AA4EA7.6060801@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EEC92658D8
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 19:06:12 +0100 (CET)
In-Reply-To: <56AA4EA7.6060801@emutex.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan O'Donovan <dan@emutex.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> Are there any other limitations that I may need to be aware of in
>>> the firmware (or in the SSP back-end driver) when attempting to
>>> connect a new codec (TI PCM5122 initially) to SSP0.
>> Bigger pole will be getting the firmware. Usually we support I2S and TDM
>> modes
> Thanks very much for your reply, Vinod!  That probably explains why I'm
> seeing clock signals from SSP0 but no audio data.
> Can you tell me who I could contact to request SST firmware for CHT with
> SSP0 support?

This doesn't make sense to me. To the best of my knowledge the firmware 
does support SSP0 but in a limited configuration compared to SSP0. It 
should work for regular 48kHz audio in I2S mode but not in TDM mode. If 
you see clock signals on SSP0 and no data then it's probably because the 
DSP routing controls are incorrect.
The best fix would be to use SSP2 really to get all the functionality.
