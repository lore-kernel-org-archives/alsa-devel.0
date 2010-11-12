From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 0/3] ASoC: Extend DAPM to handle
 cross-device paths
Date: Fri, 12 Nov 2010 16:15:42 +0200
Message-ID: <20101112161542.0899b276.jhnikula@gmail.com>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<20101112135144.GC17283@rakim.wolfsonmicro.main>
	<20101112135411.GC28804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2079510395D
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 15:15:57 +0100 (CET)
Received: by eyg24 with SMTP id 24so1761901eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 06:15:56 -0800 (PST)
In-Reply-To: <20101112135411.GC28804@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2010 13:54:12 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Nov 12, 2010 at 01:51:44PM +0000, Mark Brown wrote:
> 
> > > for those codecs that have widgets in order to avoid unnecessary widgetless
> > > codec bias shutdowns.
> 
> > Hrm, I think we should probably consider just requring all devices to
> > have at least stub DAPM support.  It's probably simpler than having to
> > special case them, we should be able to add a utility function which
> > adds default stubs to minimise the code impact.
> 
> ...and on further reflection this is actually broken for simultaneous
> playback and record in mainline so we probably want to do a fix there
> anyway.

Are you thinking to have a fix before this set or let it to float if the
issue has been there already some time? I'm thinking do we have any
other widgetless codecs than some dummy bluetooth etc. codec stubs.


-- 
Jarkko
