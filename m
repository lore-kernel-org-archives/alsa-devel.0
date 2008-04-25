From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How can you tell if the speaker jack on your	sound
	card has anything plugged into it???
Date: Fri, 25 Apr 2008 22:55:31 +0100
Message-ID: <20080425215531.GC25041@opensource.wolfsonmicro.com>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk> <87fxt9k5ge.fsf@free.fr>
	<1209159162.32245.63.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84E7C1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:55:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1209159162.32245.63.camel@razman>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Robert Jarzmik <rjarzmik@free.fr>, alsa-devel@alsa-project.org, Sean Thayne <sthayne@summitmediagroupllc.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 02:32:42PM -0700, Tobin Davis wrote:

> The snd_hda_intel driver does this internally to mute the speakers when
> headphones are plugged in.  Ditto for front mic.  But you are right, we
> need a standard way of tracking this.  I am exploring the HAL interface
> now to see what I can learn from it.  And most sound chips have an

The interface I'd previously proposed here was to provide an input
device per-jack which would do this - hal should then be able to monitor
the input device.  As suggested in the original message in the thread
providing sysfs information would probably be helpful for scripts.

> insert detection mechanism.  Usually they are wired to specific jacks,
> but sometimes they just register a change in plug state, and read the
> jack's impedance levels to know which jack is used.  It is documented in
> the Sigmatel/IDT, Realtek, and Analog Devices codec PRMs.

Yes, that's how all the codecs I've looked at do this.
