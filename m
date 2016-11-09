From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 16:14:26 +0100
Message-ID: <20161109151426.GA21280@localhost.localdomain>
References: <20161109140036.GB20859@localhost.localdomain>
 <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FCF3266B2C
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 16:14:55 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992514AbcKIPOzcdG-E (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Wed, 9 Nov 2016 16:14:55 +0100
Content-Disposition: inline
In-Reply-To: <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2016 at 02:36:42PM +0000, Mark Brown wrote:
> On Wed, Nov 09, 2016 at 03:00:36PM +0100, Ladislav Michl wrote:
> > There is no point having these complaints to be dev_err as
> > they are just adding noise to bootlog.
> 
> No, errors are errors and not displaying them just makes it harder for
> people to debug things.  If you don't want to see errors just change
> your system configuratiion to hide them.

For sure I want to see all errors, but this is not hardware error nor
kernel misconfiguration, so showing it to the user is a bit pointless.
I'm using quiet boot on production systems and technicians are told
to report all errors they see... This one pops up and has nothing
to do with errorneous behaviour.

> If you don't like deferred probing please contribute to the efforts
> to order probing.

I just tried to make it consistend to other subsystems where patches to
silence deferred probing warnings are accepted...

> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

I wasn't aware of it, sorry. Will fix it next time.

Best regards,
	ladis
