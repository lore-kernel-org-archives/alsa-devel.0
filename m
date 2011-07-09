From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Sat, 9 Jul 2011 04:38:57 +0100
Message-ID: <20110709033857.GF26900@sirena.org.uk>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E08B783.7020109@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 62535103856
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 17:28:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E08B783.7020109@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 27, 2011 at 06:01:55PM +0100, Colin Guthrie wrote:
> 'Twas brillig, and Mark Brown at 27/06/11 13:07 did gyre and gimble:

> > So, this discussion seems to have ground to a halt.  Summarising briefly
> > it seems that Lennart and Kay both seem adamant that they don't want a
> > unified jack object visible to userspace, they want to glue the objects
> > together via some implicit means.  Lennart mentioned that there is some
> > support for at least some of this functionality in PulseAudio already
> > but didn't provide any details yet - does anyone else know what happens
> > here or have time to go look at the code?

> So AFAIK, there is no support in PulseAudio per-se for this.

Hrm, nobody else seems to have any idea... 

> I'm not 100% sure what elements of a sink is used to do this matching
> but I'd take a wild stab in the dark guess at the "device.bus_path"
> entry in the proplis which can look something like:
>   device.bus_path = "pci-0000:00:1d.7-usb-0:7.1:1.0"

...this being the key bit.
