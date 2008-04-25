From: Robert Jarzmik <rjarzmik@free.fr>
Subject: Re: How can you tell if the speaker jack on your	sound
	card has anything plugged into it???
Date: 25 Apr 2008 23:08:49 +0200
Message-ID: <87fxt9k5ge.fsf@free.fr>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A1B710380F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:08:51 +0200 (CEST)
In-Reply-To: <20080425194917.GA26621@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Sean Thayne <sthayne@summitmediagroupllc.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> There's currently no standard way of getting this information from user
> space even where the hardware provides it.
Isn't the event api switch "SW_HEADPHONE_INSERT" standard ?
I thought it was designed for such use.

If I'm not mistaken, the Neo teams handles it that way, as I do for the mio :
 -> input_report_switch(mioa701_evdev, SW_HEADPHONE_INSERT, val);

--
Robert
