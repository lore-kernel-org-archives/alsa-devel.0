From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Jack event API - decision needed
Date: Mon, 27 Jun 2011 18:01:55 +0100
Message-ID: <4E08B783.7020109@colin.guthr.ie>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id BD3002448D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 19:01:59 +0200 (CEST)
In-Reply-To: <20110627120743.GA20707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Mark Brown at 27/06/11 13:07 did gyre and gimble:
> On Mon, Jun 20, 2011 at 03:37:25PM +0200, David Henningsson wrote:
> 
>> 1) We're continuing the path with /dev/input devices
> 
>> 2a) We'll rewrite these devices to be read-only ALSA mixer controls
> 
>> 2b) We'll rewrite these devices to be something within ALSA, but not 
>> exactly mixer controls.
> 
>> For options 2a) and 2b) I guess the existing /dev/input thing should be 
>> deprecated and/or removed. So part of decision should maybe be based on 
>> information about how widespread the usage of these devices are 
>> currently...?
> 
> So, this discussion seems to have ground to a halt.  Summarising briefly
> it seems that Lennart and Kay both seem adamant that they don't want a
> unified jack object visible to userspace, they want to glue the objects
> together via some implicit means.  Lennart mentioned that there is some
> support for at least some of this functionality in PulseAudio already
> but didn't provide any details yet - does anyone else know what happens
> here or have time to go look at the code?

So AFAIK, there is no support in PulseAudio per-se for this.

My understanding is that the component which deals with handling the
volume keyboard controls (e.g. gnome-settings-daemon?) is the bit that
actually does this glueing....

I believe it works like this:

 1. It gets an keyboard event for VOLUME_UP.
 2. It checks which device this keypress came from.
 3. If it's a generic keyboard or the laptop keyboard, then it likely
just picks the "default" sound device.
 4. If it's a USB HID that happens to have an "Originating Device" then
g-s-d looks through the various PA sinks and see is one of them has the
same "Originating Device". If we get a match, then this is the device
we'll use.
 5. g-s-d issues a volume increment or decrement to PA with the
appropriate device.

The above is a very high level, hand wavey description. I don't think PA
has (or needs) specific support to tie these things together.

I'm not 100% sure what elements of a sink is used to do this matching
but I'd take a wild stab in the dark guess at the "device.bus_path"
entry in the proplis which can look something like:
  device.bus_path = "pci-0000:00:1d.7-usb-0:7.1:1.0"


But I really don't know what the xinput2 or gtk3 side of things looks
like for this, so I'm just going on descriptions Lennart has given in
the past.

> I'm also concerned that an implicit system may be hard to use from
> userspace, if only in terms of figuring out what the rules are for
> matching things up.

I doubt this will be much of a problem once a few clean examples are out
there. The logic to match things up should be pretty trivial.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
