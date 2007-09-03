From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Audiophile Delta 24/96 Midi Out continuously sends
 zeroes (alsa 1.0.14)
Date: Mon, 03 Sep 2007 08:52:23 +0200
Message-ID: <1188802343.9390.1208579935@webmail.messagingengine.com>
References: <46D4A1D6.7010604@free.fr>
	<1188369280.902.1207813047@webmail.messagingengine.com>
	<1188378043.46d535bbab7f9@imp.free.fr> <fb4rj2$9ll$1@sea.gmane.org>
	<fbe8q7$hg3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C3EE21038D7
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 08:52:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fbe8q7$hg3$1@sea.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Romain Bossart <romain.bossart@free.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Romain Bossart wrote:
> Romain Bossart wrote:
> > Romain Bossart wrote:
> >> Selon Clemens Ladisch <cladisch@fastmail.net>:
> >>> Is the number of transmitted bytes in /proc/asound/cardX/midi0
> >>> about correct?
> > 
> > Yes, the number is correct. After a reboot, I prepared amidi
> > to output the incoming midi stream and switched on my instrument
> > for 2 seconds approx : around 10kB of zeroes were counted by
> > amidi and /proc/asound/card0/midi0.
> 
> Actually, the same exact number of zeroes were sent.
> I must acknowledge I used jack for connecting amidi...
> I looks like jack sends the zeroes as soon as it is
> started.

That is, the zeroes are _not_ sent when you're not using jack?  When
nothing is connected, or when you use aplaymidi or amidi to send
something, everything is OK?


Regards,
Clemens
