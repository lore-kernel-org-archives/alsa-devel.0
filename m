From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/15 v3] ALSA: firewire-lib: separate to
 packet streaming layer and data block processing layer
Date: Tue, 29 Sep 2015 21:45:00 +0900
Message-ID: <560A87CC.20203@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5htwqqxsoy.wl-tiwai@suse.de> <s5hfv1xze8s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id EDB9B260505
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 14:45:13 +0200 (CEST)
In-Reply-To: <s5hfv1xze8s.wl-tiwai@suse.de>
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

On Sep 29 2015 19:55, Takashi Iwai wrote:
> On Sat, 19 Sep 2015 18:46:53 +0200,
> Takashi Iwai wrote:
>>
>> On Sat, 19 Sep 2015 04:21:47 +0200,
>> Takashi Sakamoto wrote:
>>>
>>> This patchset updates a part of my previous post (patch 01 and 02):
>>>
>>> [alsa-devel] [PATCH 00/25 v2] ALSA: support AMDTP variants
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096739.html
>>>
>>> The aim of this patchset is to allow current amdtp implementation
>>> to handle several data block processing backends. For this aim, this
>>> patchset separates the implementation to packet streaming layer and AM824
>>> data block processing layer.
>>>
>>> The communication between these two layers is done by callback function.
>>> This patchset adds an overhead to call the functions as the same
>>> frequently as 8,000 times per second.
>>
>> Since I'm traveling now, I can't review in details and will take a
>> closer look in the next week.  Hopefully other people will give review
>> comments before that.
> 
> There were a few obvious typos (using bit OR instead of logical OR),
> but otherwise they look good through a quick review, so I merged them
> with some manual fixes now.  The patches are found in
> topic/firewire-update branch and merged into for-next branch, too.

Oops. Patch 15 includes such typos... Thanks for your reviewing and
fixing ;-)

I have more patches and I'll post them as a small parts in this
developing period. I'd be glad if the patches are also reviewd.


Thanks

Takashi Sakamoto
