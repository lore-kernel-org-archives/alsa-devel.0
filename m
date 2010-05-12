From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: include/linux/usb/audio.h: add
	__attribute__((packed))
Date: Wed, 12 May 2010 08:41:28 +0200
Message-ID: <4BEA4D98.5010900@ladisch.de>
References: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
	<s5hd3x2p3ds.wl%tiwai@suse.de>
	<20100511225054.GL30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A796A24448
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 08:41:35 +0200 (CEST)
In-Reply-To: <20100511225054.GL30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> ...
> Thanks! One of the noted TODOs is that UAC2 offers the ability to a
> device to dynamically change the supported range of options for a given
> control. So an enum-driven control can get new values, lose some,
> whatever. What would be the best way to map that to ALSA controls?

The control callbacks accept and return the new values; userspace
gets notified of the changed control information with
snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, &elem_id);

I'm quite sure that alsamixer can cope with this, but I don't know
about any other mixers. :)

I think "alsactl restore" already does the right thing for controls
that have changed.

> Another thing that we would need to support at some time is clock
> selectors to switch from an internal clock to some external one. And
> this can also be notfied dynamically - so for example: once an external
> S/PDIF transmitter is connected, the driver gets informed about a new
> valid clock source. I haven't found anything how this could be passed on
> to higher levels from a driver, but I might have missed something :)

With a mixer control "Clock Source", of course. :)
Or are you talking about new samples rates made available?


Regards,
Clemens
