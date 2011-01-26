From: "Harrod, John" <john.harrod@philips.com>
Subject: Re: Triggering a DAPM widget event
Date: Wed, 26 Jan 2011 19:08:31 +0100
Message-ID: <39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.local>
	<20110126165347.GB10759@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id D7227103A0B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 19:08:46 +0100 (CET)
In-Reply-To: <20110126165347.GB10759@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I ran a few experiments where I frequently opened and closed the PCM. Under
a heavy load, I sometimes get a resource busy error when I use the
snd_pcm_open() call. So it looks like alsa-lib is not designed for frequent
pcm opening and closing. I also noticed a few points in the alsa-lib code
where dynamic memory is being allocated and freed and am wondering how this
would affect heap fragmentation in the long term.

So the pre-powerdown event should occur when no sound is being played? When you
say stop the data flowing, you mean within the sound kernel module? There is
no call that I need to make to alsa-lib (for example making a call to
snd_pcm_pause())? It sounds like something is not working correctly in the kernel
module...

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
Sent: Wednesday, January 26, 2011 11:54 AM
To: Harrod, John
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Triggering a DAPM widget event

On Tue, Jan 25, 2011 at 05:53:13PM +0100, Harrod, John wrote:

Please CC maintianers on mails, things on mailing lists get lost easily.
Please also fix your MUA to word wrap within paragraphs, I've reflowed
your mail below so I can read it.

> I have a program that uses the ALSA PCM interface to play sounds on an
> embedded system. Does anyone know how alsa-lib triggers a
> SND_SOC_DAPM_PRE_PMD widget event in DAPM core? On my system the event
> only gets called when the pcm is closed with snd_pcm_close(). Is there
> another function that can cause a widget shutdown?

A pre-powerdown even is generated before a DAPM widget is powered down.
This will happen whenever it ceases to be part of an active audio path.
This is not something that is visible at application layer.

> Or is opening and closing the PCM every time I want to play a sound a
> good practice for saving power?

You should never need to close application layer streams.  You should
stop data flowing on them when you are not transferring audio since
obviously even ignoring the CODEC power sitting DMAing data when you're
not playing audio is going to waste power.

The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.
