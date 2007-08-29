From: Romain Bossart <romain.bossart@free.fr>
Subject: Re: Audiophile Delta 24/96 Midi Out continuously sends
	zeroes (alsa 1.0.14)
Date: Wed, 29 Aug 2007 11:00:43 +0200
Message-ID: <1188378043.46d535bbab7f9@imp.free.fr>
References: <46D4A1D6.7010604@free.fr>
	<1188369280.902.1207813047@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by alsa0.perex.cz (Postfix) with ESMTP id B9545103931
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Aug 2007 11:00:37 +0200 (CEST)
In-Reply-To: <1188369280.902.1207813047@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org, Romain Bossart <romain.bossart@free.fr>
List-Id: alsa-devel@alsa-project.org

Selon Clemens Ladisch <cladisch@fastmail.net>:

> Romain Bossart wrote:
> > My audiophile 24/96 Midi Out sends zeroes continuously,
> > so I can't use any instrument. I checked that with amidi
> > by looking at the stream output of a connected instrument
> > (midi out -> instrument -> midi in -> amidi). Zeroes are
> > sent whether or not I try to send (normal) midi messages.
>
> Would it be possible to connect the midi out directly to the
> midi in?

I also tried it, same results.

> Is the number of transmitted bytes in /proc/asound/cardX/midi0
> about correct?

I'll tell you this evening


Thank you !

Romain


>
> Regards,
> Clemens
>
