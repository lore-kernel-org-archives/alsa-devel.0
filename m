From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Tue, 6 Sep 2016 12:30:35 +0900
Message-ID: <2cf64652-2ba2-64a4-b6a4-ce9957a5f0ab@sakamocchi.jp>
References: <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain> <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <s5ha8ftgmyh.wl-tiwai@suse.de>
 <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
 <s5ha8fteyle.wl-tiwai@suse.de>
 <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
 <20160903113816.GH21682@localhost.localdomain>
 <2ba13afd-433f-8db3-b535-879155be0c47@sakamocchi.jp>
 <s5hk2ercs2c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 15FA82667A3
 for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2016 05:30:37 +0200 (CEST)
In-Reply-To: <s5hk2ercs2c.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Sep 5 2016 05:45, Takashi Iwai wrote:
> Yeah, there are obviously some issues in the current implementation of
> wm_adsp and ASoC ext ctl.  Although I'll unlikely take Sakamoto-san's
> patchset as is from a few reasons, these issues still should be
> addressed.

OK. I welcome to abandon this patchset ;)

> First off, passing the binary blob directly via TLV callback is
> incorrect from the ABI perspective.  When Vinod proposed the idea via
> TLV access originally, we thought they the data is encoded in TLV
> format.  Alas, the resulted code didn't do that and it slipped into
> the upstream without consideration.

+1

> Besides that, the second problem is the count value returned via
> snd_ctl_elem_info, as mentioned in the above.  It's beyond the
> original control API design, and a kind of illegal usage.

+1

> (Well, it's a philosophical argument: what one would expect for an
>  element that has neither read nor write access...?)

It's an element with no sense for applications. A waste of codes in 
kernel land.

> So, at this point, the main question is whether we keep this access
> pattern as is, as a sort of official one, and put some exceptional
> rule.  Charles, how is the situation?  Has it been already deployed to
> real systems?
>
> If we may still change the wm_adsp behavior, we may "fix" the first
> issue by passing the blob properly encoded in TLV format, at least.
> OTOH, if we need to keep the current ABI abuse as is, one idea is to
> add a special flag in SNDRV_CTL_ELEM_ACCESS_* indicating this kind of
> control, and we define more strictly how the code should be
> implemented.  Currently we can judge this element as a one that has no
> read/write access but with tlv r/w.  But it's way too unclear.

The 'abuse' is a part of my understanding of ALSA SoC part. I need a bit 
time to switch my mind for this issue.


Regards

Takashi Sakamoto
