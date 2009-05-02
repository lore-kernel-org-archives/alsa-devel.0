From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: New codec for STAC9766 used on Efika
Date: Sat, 2 May 2009 11:22:07 +0100
Message-ID: <20090502102206.GA4990@sirena.org.uk>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
	<20090501101402.GB6975@sirena.org.uk>
	<9e4733910905012030n5089d199u7ef890978219c3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9855D248B4
	for <alsa-devel@alsa-project.org>;
	Sat,  2 May 2009 12:22:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905012030n5089d199u7ef890978219c3bd@mail.gmail.com>
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

On Fri, May 01, 2009 at 11:30:44PM -0400, Jon Smirl wrote:
> With this version, why are these errors generated?

> ALSA sound/core/control.c:334: control 2:0:0:All Analog PCM Switch:0
> is already present

The log message seems fairly clear...  Note that controls for mixers get
generated names in the form "Mixer Name Switch Name".
