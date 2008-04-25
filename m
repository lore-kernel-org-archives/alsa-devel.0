From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How can you tell if the speaker jack on your	sound
	card has anything plugged into it???
Date: Fri, 25 Apr 2008 22:40:26 +0100
Message-ID: <20080425214026.GB25041@opensource.wolfsonmicro.com>
References: <48123137.70107@summitmediagroupllc.com>
	<20080425194917.GA26621@sirena.org.uk> <87fxt9k5ge.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 945F3243FB
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 23:40:27 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Sean Thayne <sthayne@summitmediagroupllc.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 11:08:49PM +0200, Robert Jarzmik wrote:

> Isn't the event api switch "SW_HEADPHONE_INSERT" standard ?
> I thought it was designed for such use.

Yes.  It'll also need extending to cover things that can detect jack
insertions other than headphones (espcailly usefully for devices that
can identify what is plugged into the jack).

> If I'm not mistaken, the Neo teams handles it that way, as I do for the mio :
>  -> input_report_switch(mioa701_evdev, SW_HEADPHONE_INSERT, val);

Indeed, and hopefully it'll get more widely adopted, at least for
embedded stuff.  Unfortunately adoption is currently rather limited -
the only in-tree users are the Zaurus machines.

I'm currently working on some helpers for ALSA for this.
