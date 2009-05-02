From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: New codec for STAC9766 used on Efika
Date: Sat, 2 May 2009 16:32:12 +0100
Message-ID: <20090502153211.GA5067@sirena.org.uk>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
	<20090501101402.GB6975@sirena.org.uk>
	<9e4733910905020700i29709272m6b34495a31393176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 154222459F
	for <alsa-devel@alsa-project.org>;
	Sat,  2 May 2009 17:32:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905020700i29709272m6b34495a31393176@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matt Sealey <matt@genesi-usa.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, May 02, 2009 at 10:00:28AM -0400, Jon Smirl wrote:

> Codec DAIs are missing a needed piece of information. You can flip
> bits in the codec and change the active slots in the AC97 stream. For
> dynamic configurations the CPU DAI needs to know the slot information.

Ish.  The DAI is mostly fine, it's more that we need per-channel digital
routing inside the CODEC - this sort of thing isn't limited to the
ability to pick timeslots out of the DAI, it's also possible to do most
of the routing that's visible in the analogue domain in the digital
domain.  The DAI shouldn't really need to worry about what the CODEC is
going to do with the data, just as it doesn't worry about what happens
with analogue routing.
