From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 28 Jun 2011 09:20:44 -0700
Message-ID: <20110628162043.GC21232@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E08B783.7020109@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F38AB24715
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:20:47 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 27, 2011 at 06:01:55PM +0100, Colin Guthrie wrote:

> I'm not 100% sure what elements of a sink is used to do this matching
> but I'd take a wild stab in the dark guess at the "device.bus_path"
> entry in the proplis which can look something like:
>   device.bus_path = "pci-0000:00:1d.7-usb-0:7.1:1.0"

Ah, if it's doing that that's not going to work in general - the jack
may not be part of the same device as the thing we're reporting on.

> > I'm also concerned that an implicit system may be hard to use from
> > userspace, if only in terms of figuring out what the rules are for
> > matching things up.

> I doubt this will be much of a problem once a few clean examples are out
> there. The logic to match things up should be pretty trivial.

One of my biggest concerns here is people even finding the relevant bit
of the stack, let alone working out what to do with it - bear in mind
that my main focus is on the embedded side so people may not be familiar
with Linux or using the standard desktop stack at all.
