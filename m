From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CONFIG_SND_DYNAMIC_MINORS
Date: Fri, 02 Dec 2011 09:57:35 +0100
Message-ID: <4ED892FF.2090505@ladisch.de>
References: <CAMd+_QD-ToD2yf9KnMkchmdMzwQa=2c2MpaKhcz-cMQqVaBocA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 75159103861
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 09:55:50 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BA0A221459
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 03:55:46 -0500 (EST)
In-Reply-To: <CAMd+_QD-ToD2yf9KnMkchmdMzwQa=2c2MpaKhcz-cMQqVaBocA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cyrus Vafadari <cyrusv@mit.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Vafadari wrote:
> How can I check if CONFIG_SND_DYNAMIC_MINORS is enabled,

Look into the .config file in your kernel source tree.

> I've been having a lot of trouble assigning 10 USB soundcards, and it's
> been doing fishy things when I change who's plugged in to which usb hub.

It's not easy to distinguish devices that do not have a serial number.

> ALSA recognizes all the cards,

This implies CONFIG_SND_DYNAMIC_MINORS is enabled.

> but some of the hw:x,y plays through the default hw:0,0.

You mean, to the wrong device?

How did you test this?

Check that the minor numbers in /proc/asound/devices match the actual
minor numbers in /dev/snd/.


Regards,
Clemens
