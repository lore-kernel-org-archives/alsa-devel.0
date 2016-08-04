From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Stale data interleaved in capture driver
Date: Thu, 4 Aug 2016 10:53:43 +0200
Message-ID: <9db62b13-f027-0986-5458-8ff9495a0cd0@ladisch.de>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
 <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
 <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C28AE2667E2
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 10:53:43 +0200 (CEST)
In-Reply-To: <CALAeOVOZZgh5SThku3SF_7CPrrm_SbLEbR83mkSMefCy5GdrKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> I've made changes to remove the high-frequency. I originally tried
> that method because my DMA IRQ fires whenever it writes 1/2 frame (it
> doesn't have coalescing support yet).

The snd_pcm_hardware is supposed to describe the hardware.

> I have a DMA which is looping across 64Kbytes.

This is buffer_bytes.

> The DMA is configured to interrupt at 32Bytes

This is period_bytes.

> From what I can tell (please correct me if I'm wrong), the periods_min
> and periods_max are up to me to define

They describe how often the *hardware* can interrupt.

> since i don't interrupt on a period boundary.

Periods are *defined* as the data between two interrupts.

Mapping ALSA periods to something else makes sense only if the hardware
cannot interrupt after a fixed number of bytes.


Regards,
Clemens
