From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/7] ALSA: Fix/improve PCM ack callback
Date: Mon, 22 May 2017 15:31:13 +0900
Message-ID: <6cb4bbc8-2d5f-45d0-0635-37f1737972c3@sakamocchi.jp>
References: <20170521190258.1178-1-tiwai@suse.de>
 <7685a366-5b2f-0a96-a686-c49b79975c56@sakamocchi.jp>
 <s5htw4dihpv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id B6327266851
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 08:31:16 +0200 (CEST)
In-Reply-To: <s5htw4dihpv.wl-tiwai@suse.de>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, Lee Jones <lee@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On May 22 2017 14:27, Takashi Iwai wrote:
> These functions will be modified again by other upcoming patchsets, so
> I'd like not to touch so much for minor optimization at this stage.

If you address to your latest patchset[1], it might not be applied 
promptly because I have some comments (not posted yet, in this night). 
It's not good to avoid better bahaviour in a reason of patchset 
dependency, at least you seems to be too hasty.


[1] [alsa-devel] [PATCH 00/16] ALSA: Convert to new copy_silence PCM ops

Regards

Takashi Sakamoto
