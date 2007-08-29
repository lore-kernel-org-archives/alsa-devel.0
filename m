From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Audiophile Delta 24/96 Midi Out continuously sends
 zeroes (alsa 1.0.14)
Date: Wed, 29 Aug 2007 08:34:40 +0200
Message-ID: <1188369280.902.1207813047@webmail.messagingengine.com>
References: <46D4A1D6.7010604@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id CC94F1038FB
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Aug 2007 08:34:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46D4A1D6.7010604@free.fr>
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
> My audiophile 24/96 Midi Out sends zeroes continuously,
> so I can't use any instrument. I checked that with amidi
> by looking at the stream output of a connected instrument
> (midi out -> instrument -> midi in -> amidi). Zeroes are
> sent whether or not I try to send (normal) midi messages.

Would it be possible to connect the midi out directly to the
midi in?

Is the number of transmitted bytes in /proc/asound/cardX/midi0
about correct?


Regards,
Clemens
