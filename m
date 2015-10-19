From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: oxfw: add support for TASCAM
	FireOne
Date: Mon, 19 Oct 2015 20:48:58 +0900
Message-ID: <5624D8AA.5030605@sakamocchi.jp>
References: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hpp0bi3bz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 580AE2657FE
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 13:49:03 +0200 (CEST)
In-Reply-To: <s5hpp0bi3bz.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 19 2015 19:02, Takashi Iwai wrote:
>> This parchset adds support for TASCAM FireOne to ALSA OXFW driver. PCM and
>> MIDI functionalities become available including physical controls. The
>> first and second patches are preparation for it.
>>
>> This model supports some extra commands. So as the other ALSA drivers for
>> sound and music units on IEEE 1394 bus, they should be implemented in
>> userspace applications. For your information, I note them:
>>
>> (snip)
>>
>> Takashi Sakamoto (3):
>>   ALSA: oxfw: calculating MIDI ports in stream discover
>>   ALSA: oxfw: support more MIDI ports
>>   ALSA: oxfw: add an entry for TASCAM FireOne
> 
> Applied all three patches now.  Thanks.

Thanks to applying them.

For ALSA OXFW driver, I have an additional issue. SCS.1m/SCS.1d also use
this chipset for its communication functionality. Currently, snd-scs1x
is applied to these models with MIDI functionality, while we can merge
it to snd-oxfw with MIDI/PCM functionality.

I've already written the patchset but it's a bit intrusive to snd-scs1x
users. To avoid regressions, I'll contact to a developer who posted
about this model in this mailing list (then, Clemens wrote the driver):
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-May/052264.html

On the other hand, it's two weeks rest till next merge window. I think
it better to postpone them to next period...


Regards

Takashi Sakamoto
