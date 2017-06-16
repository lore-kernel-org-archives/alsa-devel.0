From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire: process packets in
 'struct snd_pcm_ops.ack' callback
Date: Sat, 17 Jun 2017 00:08:53 +0900
Message-ID: <2bc8f659-ffa3-9156-8ff6-affb2ef5e6bb@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
 <20170607003806.27196-2-o-takashi@sakamocchi.jp>
 <s5hd1ag5oef.wl-tiwai@suse.de> <s5hvao7337g.wl-tiwai@suse.de>
 <670e0d81-5f91-4b2a-1d07-3376f33abfb2@sakamocchi.jp>
 <s5hd1a85c2e.wl-tiwai@suse.de>
 <d76f910b-45e7-cf6c-96c7-25ade0cd0257@sakamocchi.jp>
 <s5hr2ymbp0k.wl-tiwai@suse.de>
 <c3d6fc27-eb6c-6617-4329-870a0e29eb31@sakamocchi.jp>
 <s5h60fxskkp.wl-tiwai@suse.de>
 <67374bab-ea5f-f9ad-83a5-137a61e5400d@sakamocchi.jp>
 <s5htw3hqdeu.wl-tiwai@suse.de>
 <31a09192-8c87-f002-82b7-5948d8ccda07@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id BBC002669CD
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 17:08:59 +0200 (CEST)
In-Reply-To: <31a09192-8c87-f002-82b7-5948d8ccda07@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, clemens@ladisch.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ffado-devel@lists.sf.net, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Jun 17 2017 00:00, Takashi Sakamoto wrote:
> This subsystem has no drivers with the similar feature, thus it's new
> design for data transmission. The design supports below things:
> 
> 1. Hardware features:
> 1.1. Data transmission is done by direct media access (DMA).
> 1.2. Hardware cares of two points for its data transmission; one is
>       hwptr and another is appl_ptr on PCM buffer dedicated for the
>       data transmission.
> 1.3. (perhaps)The granurarity of data transmission can be differed,
>       not fixed to the size of 'period'.

I realized that 'granularity' (misspelled...) is not proper in this 
context. Here, I described intervals to start data transmissions by DMA. 
The transmission can be managed by pre-programmed descriptors on device 
register, or service routines for interrupts on drivers, and so on.


Regards

Takashi Sakamoto
