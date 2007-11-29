From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Edirol UA-4FX
Date: Thu, 29 Nov 2007 08:23:03 +0100
Message-ID: <1196320983.29749.1223842097@webmail.messagingengine.com>
References: <4dfa50520711281050v4a710af5q11644b0cf7dd10c1@mail.gmail.com>
	<4dfa50520711281123o4ea74babra50f0a09330bb359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A9B3F2415D
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 08:23:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4dfa50520711281123o4ea74babra50f0a09330bb359@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Hubbard <david.c.hubbard@gmail.com>, Alsa Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Hubbard wrote:
> I recently got an Edirol UA-4FX. It works just fine as a generic USB
> Audio device. I've written up all the details at
> http://alsa.opensrc.org/index.php/Edirol_UA-4FX (shamelessly stolen
> from the Edirol_UA-25 page).
> 
> The the UA-4FX needs a patch to usbaudio.c create_ua700_ua25_quirk()
> and usbquirks.h, and then it has full support. (MIDI I/O, sample rates
> up to 96 kHz) I've made an attempt, mostly to get it working on my
> machine. Can you review it?

>  static int create_ua700_ua25_quirk(struct snd_usb_audio *chip,

The name of this function and the quirk should be changed.

> +	/* both PCM and MIDI interfaces have 2 altsettings,
> +	 * except UA-4FX at 48 kHz, PCM interface has 3 altsettings */

What is the third altsetting for?  The quirk currently assumes that
there is only one altsetting to be used.


Regards,
Clemens
