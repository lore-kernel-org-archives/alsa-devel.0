From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
	for	TLV operation
Date: Wed, 31 Aug 2016 15:24:31 +0200
Message-ID: <3935ce7f-e087-cd8f-1e1e-ef4b17c363c0@ladisch.de>
References: <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain>
 <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <20160831121934.GB21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4C0E3267FF2
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 15:24:32 +0200 (CEST)
In-Reply-To: <20160831121934.GB21682@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@linaro.org, Takashi Iwai <tiwai@suse.de>, omair.m.abdullah@intel.com, Vinod Koul <vinod.koul@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Charles Keepax wrote:
> On Wed, Aug 31, 2016 at 01:54:37PM +0200, Clemens Ladisch wrote:
>> Anyway, the separate length value could be useful only for drivers (like
>> soc-wm-adsp) that use a binary stream where TLV data should have been
>> used.  But the software that writes these coefficients to the WM ADSP
>> driver is very hardware specific anyway, and it presumably already works
>> without knowing the returned length value.  So there is no case where
>> this patchset _actually_ improves the interface.
>
> The software that writes these coefficients to wm_adsp is
> not hardware specific at all its just regular amixer and
> tinymix.

As far as I can see, neither amixer nor tinymix support writing
or "command"ing TLV data.  Do you mean alsactl or alsaucm?

(And I notice that when alsa-lib's UCM loads TLV data from a file,
it does check that the second word contains the correct size.  Is
this value also correct when reading TLV from these controls?)

> These TLV controls are just like any other ALSA control

You're treating it like one, but actually TLV is not a control type but
metadata attached to a control.


Regards,
Clemens
