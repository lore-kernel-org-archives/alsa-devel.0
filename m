From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/3] ASoC: Extend DAPM to handle
 cross-device paths
Date: Fri, 12 Nov 2010 14:32:38 +0000
Message-ID: <20101112143238.GD17283@rakim.wolfsonmicro.main>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<20101112135144.GC17283@rakim.wolfsonmicro.main>
	<20101112135411.GC28804@sirena.org.uk>
	<20101112161542.0899b276.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F2BC103932
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 15:32:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101112161542.0899b276.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 04:15:42PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > ...and on further reflection this is actually broken for simultaneous
> > playback and record in mainline so we probably want to do a fix there
> > anyway.

> Are you thinking to have a fix before this set or let it to float if the
> issue has been there already some time? I'm thinking do we have any
> other widgetless codecs than some dummy bluetooth etc. codec stubs.

One or the other.  The bluetooth/baseband stubs are something else again
- they're DAIs with no associated device - but I'll need to think about
how bad this really is and if insisting on DAPM really is the best way
forward.  I'd suggest just dropping the special casing of this from your
series unless you feel inspired to change stuff for 2.6.37 (in which
case do the change separately, obviously) as you're not making anything
worse.
