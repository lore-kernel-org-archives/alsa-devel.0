From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH RFC v2] radio-sf16fmr2: convert to generic
	TEA575x interface
Date: Sun, 15 May 2011 23:26:33 +0200
Message-ID: <201105152326.33925.hverkuil@xs4all.nl>
References: <201105140017.26968.linux@rainbow-software.org>
	<201105141206.51832.hverkuil@xs4all.nl>
	<201105152218.24041.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr13.xs4all.nl (smtp-vbr13.xs4all.nl [194.109.24.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 2975210387E
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 23:27:01 +0200 (CEST)
In-Reply-To: <201105152218.24041.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sunday, May 15, 2011 22:18:21 Ondrej Zary wrote:
> Thanks, it's much simpler with the new control framework.
> Do the negative volume control values make sense? The TC9154A chip can
> attenuate the volume from 0 to -68dB in 2dB steps.

It does make sense, but I think I would offset the values so they start at 0.
Mostly because there might be some old apps that set the volume to 0 when they
want to mute, which in this case is full volume.

I am not aware of any driver where a volume of 0 isn't the same as the lowest
volume possible, so in this particular case I would apply an offset.

I will have to do a closer review tomorrow or the day after. I think there are
a few subtleties that I need to look at. Ping me if you haven't heard from me
by Wednesday. I would really like to get these drivers up to spec now that I
have someone who can test them, and once that's done I hope that I never have
to look at them again :-) (Unlikely, but one can dream...)

Regards,

	Hans
