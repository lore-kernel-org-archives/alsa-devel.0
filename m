From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 0/9 v3] ctl: add APIs for control
	element set
Date: Fri, 17 Jun 2016 00:44:00 +0900
Message-ID: <5762C940.20401@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5h60t99r3o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 739CA2669F9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 17:44:08 +0200 (CEST)
In-Reply-To: <s5h60t99r3o.wl-tiwai@suse.de>
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

On Jun 16 2016 22:54, Takashi Iwai wrote:
> On Wed, 15 Jun 2016 16:57:36 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset is a revised version of below one:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109041.html
>>
>> Changes:
>>  - Drop a patch for deprecating old APIs.
>>   - In detail, see our discussion:
>>     http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109117.html
>>  - Revise comments for TLV feature.
>>   - I realized it better to use vendor-neutral representation, after reading
>>     this discussion:
>>     http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html
> 
> Thanks, now applied but patch 9.
> For the patch 9, please resubmit just after reformatting.

Thanks. I'll post the reformatted version tomorrow (it's late night, zzz).

Near future, this feature will be used for IPC mechanism between ALSA
ctl/hctl/mixer applications and control server in userspace for audio
and music units on IEEE 1394 bus. The control server will run according
to udev signal to listen to the added units. The server continue to
communicate to the units even if any bus-reset occurs on the bus; i.e.
new units are added to the bus. This cannot be achieved by FFADO
library, which has a defection to lost communication when any bus-resets
occur[1].

But I've not decided which userspace implementation to use as an I/O
library; alsa-lib or alsa-gi, because it's convenience to program with
Python 3 and GObject Introspection. There're few helps for this work,
according to my experience in recent years.  I'd like to choose
programming language with which I can write prototypes as soon as possible.

>> Again, ALSA developers in PulseAudio side, test program in the last patch
>> causes an abort to pulseaudio process as a result of kicking assertion of
>> hcontrol in alsa-lib. In detail, please refer to my previous patchset.
> 
> The assert() line there is nonsense (although it's a bit strange to
> catch it -- possibly it's because of some races.  But it's no urgent
> point to abort the program).  Care to submit a patch to remove the
> assert line?

OK. But for safe I'll read codes of PulseAudio, so need a bit time.

(For this kind of work I use my private time, thus it takes longer time
than the other full time developers.)


[1] https://sourceforge.net/p/ffado/mailman/message/35069619/
[2] http://marc.info/?l=linux-kernel&m=146568442828312&w=2

Regards

Takashi Sakamoto
