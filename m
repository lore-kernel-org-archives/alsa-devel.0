From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] ASoC: core: Option to reorder widget
	power sequence
Date: Fri, 3 Dec 2010 14:48:03 +0000
Message-ID: <20101203144802.GV859@rakim.wolfsonmicro.main>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101202130516.GC859@rakim.wolfsonmicro.main>
	<201012030933.28559.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D39A24507
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 15:48:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012030933.28559.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 09:33:28AM +0200, Peter Ujfalusi wrote:
> On Thursday 02 December 2010 15:05:16 ext Mark Brown wrote:

> > We've now got the split power down/power up sequences - ideally what
> > we'd be able to do here is get the route update to happen in between the
> > power down and power up sequences.

> What do you mean?

When we do DAPM we run one sequence of register updates to implement
power downs and then a second sequence to implement the power ups.  What
you're really asking for here is to have the path update happen between
these two.  I'm not sure if that is any clearer?  This seems like a
totally sensible thing for us to be doing in general.

> IMHO using differnet sequence of register write/dapm update power on path enable 
> and disable shall be enough.

You're working at the widget level but really this sounds like a global
issue in the sequencing we do - it's fixing one specific use case but
the level it's doing it at makes the change much less generally useful.
