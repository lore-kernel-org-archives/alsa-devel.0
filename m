From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: I don't understand snd_pcm_ops
Date: Fri, 18 May 2007 19:04:07 -0500
Message-ID: <20070519000407.DCE031CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id AB92024437
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 02:04:07 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	04F141800121
	for <alsa-devel@alsa-project.org>; Sat, 19 May 2007 00:04:08 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> First off, I thought PCM stood for Pulse Code Modulation, but that 
> just describes the
> format of the digital data.  I don't understand what a PCM operation could be.

Exactly, it described the format of the digital data used i audio processing.
PCM does stand for pulse code modulation, but here it is a reference to a device
that processes sample based digital audio i.e not midi etc.

The ALSA middle layer (which includes PCM) takes care of all the common stuff
that all drivers need to do.
In sound drivers, we have multiple types of devices: PCM, midi, mixers etc. The
PCM layer is responsible for doing all the digital audio work. I.e preparing
the card for playback, initiaing transfer to and from the device etc.
In short, if you want to playback or capture sound, you're going to need a PCM :)

snd_pcm_ops is a structure of callbacks that relate to different events regarding
the PCM interface. Use this to run your own code at specific events. I.e. it's
most probable that you'll want to prepare the device in some manner before audio
transfer starts, so you would put the code to do this into your prepare callback.

> 
> I've seen documentation where PCM is considered an alternative to 
> I2S or AC97.  But if you
> look at eti_b1_wm8731.c, you'll see this:
> 
> #include "at91-pcm.h"
> #include "at91-i2s.h"
> 
> So is the AT91 a PCM device or an I2S device???


None of these are alternatives to each other. They're all different things.
The anser to your question would be that this is an i2c device that has a PCM.

Have you read "Writing an ALSA driver"? It generally describes ALSA drivers as
they relate to PCI, and how to write them, but it does a good job at explaining
the general ALSA driver architecture.

Ash

=
