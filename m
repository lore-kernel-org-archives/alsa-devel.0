From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 17:36:58 +0100
Message-ID: <20161109163658.GA21606@localhost.localdomain>
References: <20161109140036.GB20859@localhost.localdomain>
 <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
 <20161109151426.GA21280@localhost.localdomain>
 <20161109152209.dzejborw53no26ew@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 91F822666AA
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 17:37:31 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992514AbcKIQhap2yQj (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Wed, 9 Nov 2016 17:37:30 +0100
Content-Disposition: inline
In-Reply-To: <20161109152209.dzejborw53no26ew@sirena.org.uk>
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

On Wed, Nov 09, 2016 at 03:22:09PM +0000, Mark Brown wrote:
> On Wed, Nov 09, 2016 at 04:14:26PM +0100, Ladislav Michl wrote:
> > On Wed, Nov 09, 2016 at 02:36:42PM +0000, Mark Brown wrote:
> 
> > > No, errors are errors and not displaying them just makes it harder for
> > > people to debug things.  If you don't want to see errors just change
> > > your system configuratiion to hide them.
> 
> > For sure I want to see all errors, but this is not hardware error nor
> > kernel misconfiguration, so showing it to the user is a bit pointless.
> 
> How do we know that it's not a kernel misconfiguration?  It's common for
> people to not build some of the component drivers they need.

Is what you described really a misconfiguration? Enabling debug when
something does not work seems obvious thing to do, but okay, perhaps
anything bellow error level would make me happy enough.

> > > If you don't like deferred probing please contribute to the efforts
> > > to order probing.

As a side note, which efforts are you reffering to here?
 
> > I just tried to make it consistend to other subsystems where patches to
> > silence deferred probing warnings are accepted...
> 
> Which subsystems are these?  We should look at fixing them...

tty and usb for example. I do not consider wise to looking at them until
this very subsystem gets fixed first to not distract ourselves ;-)
(Also I have admit, that accepted patches hide error message on deferred
probe only, but above occurs _also_ on deferred probe and yes, it would be
nice to have that fixed)

Best regards,
	ladis
