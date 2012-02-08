From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Multiple channels mapping
Date: Wed, 08 Feb 2012 12:32:17 +0100
Message-ID: <4F325D41.50304@ladisch.de>
References: <4F31C988.3090201@codeaurora.org> <s5hwr7xln03.wl%tiwai@suse.de>
	<4F323DE5.4050108@ladisch.de> <s5hvcnhllum.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id D8354103DFA
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:30:11 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0B20520B46
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 06:30:09 -0500 (EST)
In-Reply-To: <s5hvcnhllum.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> Currently the channel-mapping information is a missing piece in ALSA
>>> framework, and it's a very long-standing item on my TODO list.
>>>
>>> The implementation itself should be easy, but the only question is the
>>> API design.  If you have a good proposal, please speak up.
>>
>> TLVs on media controller entities.
>
> Well, my concern is that it might be too far from the other PCM
> stuff.  How the implementation would look like?

There is one media controller device node per device (= ALSA card),
containing multiple entities (similar to how a ctl device contains
multiple controls).  /dev/media42 _is_ separate, but the entity that
represents a PCM device is handled by the PCM code, so it would be
possible to have a shortcut to get a PCM device's TLVs directly.

> More question is whether this information should be available before
> or after hw_params setup.

This is pretty much static information, which is available even when the
PCM device isn't opened.

> BTW, the channel-mapping info can be useful for the automatic plug
> layer, too.

And if there is a need for channel mapping information of ALSA plugins,
there needs to be a userspace library for the media controller API.


Regards,
Clemens
