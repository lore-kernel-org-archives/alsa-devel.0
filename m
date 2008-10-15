From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] hda: add support for jack detection on
	IDT/Sigmatel
Date: Wed, 15 Oct 2008 16:32:53 +0100
Message-ID: <20081015153251.GD14068@sirena.org.uk>
References: <48F60190.5060601@embeddedalley.com> <s5hvdvtzytl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E3E6E2476C
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 17:33:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvdvtzytl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 15, 2008 at 05:02:14PM +0200, Takashi Iwai wrote:
> Matthew Ranostay wrote:

> > +	jack->input_dev->phys = "ALSA Jack Detection";

> Any reason to change?

Not like that.  The only reason it's set at all at the minute is because
evdev prints it out for diagnostic purposes and it'd show up as "(NULL)"
which sets off alarm bells for people.  The particular string isn't
really important and the terseness varies between drivers that use fixed
strings.

Note that this isn't the device name - that should generally be verbose
(and is currently the card longname plus jack name which is idiomatic
for this).

> Well, I think even the original phys value "ALSA" is a bit strange in
> comparison with values of other input drivers, such as
> "isa0060/serio0/input0", "PNP0C0C/button/input0", too...
> Mark, what do you think?

It should ideally be something based off the location of the card in the
system (like those you quote above) - the idea is that it's something
that doesn't change between reboots and identifies the device.  Not all
input devices put something meaningful there.  If we change it to
anything it should probably be to something based off the bus_id of the
input device.

It mostly only comes into play if you've got more than one of a device
in the system and even then AIUI user space just uses sysfs these days,
which is why I didn't bother originally.
