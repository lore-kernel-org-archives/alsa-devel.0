From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: How can you tell if the speaker jack on	your	sound
	card has anything plugged into it???
Date: Fri, 25 Apr 2008 14:32:42 -0700
Message-ID: <1209159162.32245.63.camel@razman>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk>  <87fxt9k5ge.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B23C247D8
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:32:45 +0200 (CEST)
In-Reply-To: <87fxt9k5ge.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <rjarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sean Thayne <sthayne@summitmediagroupllc.com>
List-Id: alsa-devel@alsa-project.org

The snd_hda_intel driver does this internally to mute the speakers when
headphones are plugged in.  Ditto for front mic.  But you are right, we
need a standard way of tracking this.  I am exploring the HAL interface
now to see what I can learn from it.  And most sound chips have an
insert detection mechanism.  Usually they are wired to specific jacks,
but sometimes they just register a change in plug state, and read the
jack's impedance levels to know which jack is used.  It is documented in
the Sigmatel/IDT, Realtek, and Analog Devices codec PRMs.

Tobin


On Fri, 2008-04-25 at 23:08 +0200, Robert Jarzmik wrote:

> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> 
> > There's currently no standard way of getting this information from user
> > space even where the hardware provides it.
> Isn't the event api switch "SW_HEADPHONE_INSERT" standard ?
> I thought it was designed for such use.
> 
> If I'm not mistaken, the Neo teams handles it that way, as I do for the mio :
>  -> input_report_switch(mioa701_evdev, SW_HEADPHONE_INSERT, val);
> 
> --
> Robert
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


All of the true things I am about to tell you are shameless lies.
		-- The Book of Bokonon / Kurt Vonnegut Jr.
