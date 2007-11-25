From: Lennart Poettering <mznyfn@0pointer.de>
Subject: The sense or non-sense of the device listing API (was:
	Status of	ALSA "simple" mixer interface])
Date: Sun, 25 Nov 2007 20:56:15 +0100
Message-ID: <20071125195615.GA10832@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hy7crhmzs.wl%tiwai@suse.de>
	<1195658628.10273.1222565901@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A3E88245DC
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 20:56:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1195658628.10273.1222565901@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21.11.07 16:23, Clemens Ladisch (cladisch@fastmail.net) wrote:

> Takashi Iwai wrote:
> > Lennart Poettering wrote:
> > > aplay -L suggest to use "surround71:" (and *only* that) as plugin for my
> > > usb webcam that only has a single mono channel.  What's going wrong?
> > > Any idea where I should be looking?
> > 
> > Since it's a USB device, maybe Clemens has a better clue...
> 
> USB-Audio.conf defines all the surround devices because there are some
> devices that actually use them.  I could understand if "aplay -L" shows
> all the default device names _including_ surround71.
> 
> I'm not sure how the device name list gets constructed; AFAICT the card-
> specific .conf files are not supposed to define hints.

Hmm, that would would be a serious limitation.

As it appears the device name lists *never* includes any suitable
device strings for mono-only devices, correct?

That too is a serious limitation, and makes the name listing API a bit worthless.

I am really not sure what to make of this device listing API, if it
lists mostly non-working devices, and doesn't list working devices.

Quite frankly, the whole device name API is not really useful as is
anyway, since it doesn't provide any hint to the code using it what
the properties are of the devices it lists. How should client code
ever know that "surround51" is the one to pick from the list when 5.1
sound is requested -- without having a static table of possible
devices and their properties somewhere in its own code? But if the
client codes has to define that table in its own code than the point
of the device naming API is mostly lost.

To work around the fact that the device naming API doesn't work as
documented, and also is not really that useful as an API anyway,
PulseAudio now probes all potentially available devices by opening
them, and having a large table listing the well known ALSA device
strings and their properties. Probing for possible devices like this
is ugly, and produces a lot of libasound debug output (which one
apparently can not disable without recompiling ALSA itself, or did I
miss something?).

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
