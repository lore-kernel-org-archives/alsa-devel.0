From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 10:41:13 +0200
Message-ID: <4E82DDA9.2050607@ladisch.de>
References: <4E82BB4C.1030801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0B433244FC
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 10:40:55 +0200 (CEST)
In-Reply-To: <4E82BB4C.1030801@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> The codec I am working on, beside headset detection, also have other
> type of events to be propagated to user space. Per our discussion at
> IPC, there is way to signal user-space through kcontrol. Is it through 
> calling snd_ctl_notify()?

Yes.

> What is the ALSA library API to intercept the event?

snd_ctl_open() and snd_ctl_subscribe(), then snd_ctl_read() in
a loop.  To integrate this into a poll()-based event loop, use
the snd_ctl_poll_descriptors*() functions.

Do you want to write a specific tool that does nothing but waiting
for these events, or will this be integrated into another program?

> Is there an sample user-space code which gets kcontrol event?

Not really.  There is alsamixer, but it uses a different API (the
snd_mixer* functions implement an abstracation on top of the snd_ctl*
stuff).  In the main loop (alsa-utils/alsamixer/mainloop.c), the
snd_mixer_poll_descriptors* functions work similar to the snd_ctl*
functions, but the snd_mixer_handle_events() function then reads the
event(s) from the ctl device and calls callback functions, in this case
elem_callback() and mixer_callback() in mixer_widget.c.


Regards,
Clemens
