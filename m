From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Mon, 01 Dec 2014 08:19:14 +0900
Message-ID: <547BA5F2.4040401@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de> <547A9E1B.7060004@sakamocchi.jp>
 <s5h4mthay31.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id AE960260443
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 00:19:20 +0100 (CET)
In-Reply-To: <s5h4mthay31.wl-tiwai@suse.de>
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
Cc: ffado-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Nov 30 2013 17:31, Takashi Iwai wrote:
>>> So, this ends up with the identical strings for both driver and
>>> shortname?  This doesn't sound like an improvement.
>>
>> Basically, hard-coded strings can be replaced by strings read from
>> config-rom on the devices. My original intension of this commit is
>> following to this.
>>
>> But FWSpeakers/FireWave has long strings for vendor/model strings on
>> config-rom, therefore his commit can obsolete long name only.
>>
>> Actually this patch is a help for later patch:
>> [PATCH 26/30] ALSA: oxfw: Add support for Behringer/Mackie devices
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084818.html
> 
> But still it's not applied to LaCie and other that have device_info,
> no?  So they'll end up with the even shorter names than now.
>
> I'd be better to create a short_name from "Vendor Model" where
> driver_name can be a fallback of model name.

Any reasons?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
