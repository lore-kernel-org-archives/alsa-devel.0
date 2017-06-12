From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: pcm: add 'applptr' event of
	tracepoint
Date: Mon, 12 Jun 2017 09:08:17 +0900
Message-ID: <b3744a10-a6c1-6e24-d146-a7e820e97941@sakamocchi.jp>
References: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
 <s5ho9tu1mpc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 99F452664EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 02:08:19 +0200 (CEST)
In-Reply-To: <s5ho9tu1mpc.wl-tiwai@suse.de>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Jun 12 2017 02:03, Takashi Iwai wrote:
> This cover letter texts have much better explanation than the
> description in your patch itself. Why not putting such an excellent
> example in the change log?

This report depends on my original research somehow. Source for this 
embedded board is from VIA Tech. Inc. and not mainlined yet. 
Furthermore, I prepared for backport patches by my self. Totally, it 
might not be reproductive as is entirely. This is a reason that I wrote 
the report in the cover letter.

However, I believe that the others can get the similar result on the 
other boards based on ARM architecture, because ALSA stuffs are written 
as they work what I report. In this meaning, it's worth to put the 
report into the change log.

I'm OK to post revised version.


Thanks

Takashi Sakamoto
