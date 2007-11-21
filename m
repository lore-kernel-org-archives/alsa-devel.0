From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [lennart@poettering.net: Status of ALSA "simple"
 mixer interface]
Date: Wed, 21 Nov 2007 16:23:48 +0100
Message-ID: <1195658628.10273.1222565901@webmail.messagingengine.com>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hy7crhmzs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 35A2624C40
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:23:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy7crhmzs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Lennart Poettering wrote:
> > aplay -L suggest to use "surround71:" (and *only* that) as plugin for my
> > usb webcam that only has a single mono channel.  What's going wrong?
> > Any idea where I should be looking?
> 
> Since it's a USB device, maybe Clemens has a better clue...

USB-Audio.conf defines all the surround devices because there are some
devices that actually use them.  I could understand if "aplay -L" shows
all the default device names _including_ surround71.

I'm not sure how the device name list gets constructed; AFAICT the card-
specific .conf files are not supposed to define hints.


Regards,
Clemens
