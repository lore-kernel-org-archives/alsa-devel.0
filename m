From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How can you tell if the speaker jack on your	sound
	card has anything plugged into it???
Date: Fri, 25 Apr 2008 23:02:35 +0100
Message-ID: <20080425220235.GA27606@sirena.org.uk>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk>
	<481244BD.3060501@summitmediagroupllc.com>
	<4812458E.5030508@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 77DC5247E7
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Apr 2008 00:11:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4812458E.5030508@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Sean Thayne <sthayne@summitmediagroupllc.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 03:56:46PM -0500, Timur Tabi wrote:

> First, the hardware has to detect insertion.  Then, it has to send a 
> signal to the driver (either via a status register or an interrupt).

> Assuming you have all that (I've never seen a sound card that provides 
> this info), perhaps you can specify the output jack only when something 

This is supported in a reasonable proportion of CODEC chips these days,
particularly those that have direct headphone and/or microphone support.
It's more frequently used in mobile devices than desktops (since they
tend to experience more plug/unplug events) but with the spread of
laptops it's now fairly common in PC class hardware.

> is plugged in?  That is, you register the output jack when something is 
> plugged in, and then deregister it when something is removed.

It's probably be easier from a UI perspective if the jack is always
present in the UI but applications can tell if it's disabled - the
physical jack is always there, after all.
