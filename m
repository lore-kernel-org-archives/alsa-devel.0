From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Quirk to disable master volume control in PCM2702
Date: Tue, 17 Nov 2009 10:04:30 +0100
Message-ID: <4B02671E.8070306@ladisch.de>
References: <861213340911161513n53c8b303i67ac2f07db87cddc@mail.gmail.com>
	<861213340911161517tfb33467i9a4b270c0a548c69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 61FDF244AD
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 10:04:33 +0100 (CET)
In-Reply-To: <861213340911161517tfb33467i9a4b270c0a548c69@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Kohen <jkohen@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Javier Kohen wrote:
> I've written the attached patch to disable the master volume control
> in this chipset. The datasheet [1] documents two independent channel
> volume controls, one master mute control and one master volume
> control. However, at least on my device (a Fubar USB DAC), the master
> volume control always returns USB stalls when queried for any of its
> parameters (min/max/res/cur).

I'd guess that Windows ignores the master volume when it finds
channel volume controls, so this function was never actually tested.

> However, it seems that either the USB specs are wrong,

They are abominations written by committees.

> or my USB hub or the card are buggy.

Your hub is certainly buggy ...

> the PCM2702 and my motherboard don't interact well. After a while the
> sound is degraded, first into a hiss, then into pure noise.

... the card too.


Your patch looks good; please provide a log message and a Signed-off-by
tag.


Best regards,
Clemens
