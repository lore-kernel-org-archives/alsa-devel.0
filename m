From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 02/10] ALSA: dice: wait for ensuring phase
	lock
Date: Wed, 16 Dec 2015 01:00:36 +0900
Message-ID: <56703924.3080504@sakamocchi.jp>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449889570-26641-3-git-send-email-o-takashi@sakamocchi.jp>
 <566C081A.1000804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF77261B01
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 17:00:41 +0100 (CET)
In-Reply-To: <566C081A.1000804@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Dec 12 2015 20:42, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Some users have reported that their Dice based models generate packet
>> discontinuity at the beginning of streaming. When standing on an
>> assumption that the value of SYT field in transferred AMDTP packet comes
>> from phase lock circuit, this comes from phase unlocking with current
>> clock source. Just waiting for dice notification is not enough to prevent
>> from packet discontinuity.
>>
>> This commit checks the register of phase lock after clock state change for
>> this purpose.
> 
> Is this patch actually known to help?
> 
> This discontinuity could also come from an unexpected initial DBC value.
> I think it would be a good idea to unconditionally enable
> CIP_SKIP_INIT_DBC_CHECK for all devices.

This issue also occurs on my ImpactTwin. Today, I dropped this patch and
tried re-generate this issue, then I cannot regenerate it.

As long as I tested, the deferred registration has an effect for this
issue. I guess that the beginning of packet streaming is envolved to the
end of hardware initialization, then discontinuity occurs.

I decide to drop this patch from next post, thanks to address it.


Regards

Takashi Sakamoto
