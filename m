From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: oxygen: Fix S/PDIF muting
Date: Sun, 05 Jul 2015 21:23:13 +0200
Message-ID: <55998421.2000503@ladisch.de>
References: <20150628131337.d8077aed73a9851b194bdc30@tuffmail.com>	<5590408A.6030100@ladisch.de>	<20150629210159.b8c7f6baa83eef02555686f1@tuffmail.com>	<559264D8.9030804@ladisch.de>
 <20150705195650.96c58d265a2c0118ab48bd2e@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BCC2A260462
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 21:24:34 +0200 (CEST)
In-Reply-To: <20150705195650.96c58d265a2c0118ab48bd2e@tuffmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Laurence Darby <ldarby@tuffmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Laurence Darby wrote:
> On Tue, 30 Jun 2015 11:43:52 +0200 Clemens Ladisch wrote:
>> Laurence Darby wrote:
>>> If this is still going to prevent fixing the popping noise for the
>>> oxygen chip, what about writing a single 0x00 sample to it in the
>>> driver instead of muting it?
>>
>> This is likely to work (but the zero sample has to go through DMA).
>
> Ok, I eventually got this to work, with this in oxygen_spdif_hw_free():
>
> 	memset (runtime->dma_area, 0, runtime->dma_bytes);
> 	oxygen_trigger(substream,SNDRV_PCM_TRIGGER_START);
> 	msleep (1);
> 	oxygen_trigger(substream,SNDRV_PCM_TRIGGER_STOP);

Please note that hw_free can be called without a valid configuration.

Calling oxygen_trigger() might affect other streams.

> If I create a proper patch for that (it should probably use
> snd_pcm_format_set_silence() instead of memset)

All supported sample formats uses plain zeros.


Regards,
Clemens
