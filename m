From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 0/9] mpc5200 audio rework for AC97
Date: Sun, 24 May 2009 19:35:15 +0100
Message-ID: <20090524183515.GC4525@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090524110854.GB4933@sirena.org.uk>
	<9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CD62224526
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 20:35:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905240821p7313f82bu171e0d4a2f3dbbff@mail.gmail.com>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 24, 2009 at 11:21:15AM -0400, Jon Smirl wrote:

> My AC97 driver is detecting the codec id and printing it before trying
> to access the codec driver. I can convert that to a load_module() call
> when the drivers are ready.

No, your AC97 driver shouldn't be doing any of this at all - it should
be leaving any enumeration of the hardware up to the machine driver and
the core.  In so far as it is standardised the process for probing AC97
is something that can be implemented in terms of the operations exported
by the DAI so it should be done in the core for all AC97 DAIs.  Where
standardised probing can't work it needs to be machine specific anyway.
