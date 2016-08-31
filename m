From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
	for	TLV operation
Date: Wed, 31 Aug 2016 13:54:37 +0200
Message-ID: <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain>
 <s5hzintgtsr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 59044267136
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 13:54:39 +0200 (CEST)
In-Reply-To: <s5hzintgtsr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, omair.m.abdullah@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> TLV has never been and (will never be) an API to handle a
> generic binary stream.

It would be possible to define something like SNDRV_CTL_TLVT_HWDEP_BLOB
or _COEFFICIENTS, or to reserve a range of TLVT values for driver-
defined types.  (But we cannot change soc-wm-adsp to support only proper
TLV data, because this would introduce a regression.)


Anyway, the separate length value could be useful only for drivers (like
soc-wm-adsp) that use a binary stream where TLV data should have been
used.  But the software that writes these coefficients to the WM ADSP
driver is very hardware specific anyway, and it presumably already works
without knowing the returned length value.  So there is no case where
this patchset _actually_ improves the interface.


Regards,
Clemens
