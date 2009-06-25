From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Thu, 25 Jun 2009 11:25:49 +0100
Message-ID: <20090625102548.GB17812@sirena.org.uk>
References: <9e4733910906241207m50340ef5gd63fc4527e50b861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0FC103859
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:25:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910906241207m50340ef5gd63fc4527e50b861@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2009 at 03:07:17PM -0400, Jon Smirl wrote:
> On Wed, Jun 24, 2009 at 12:28 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > it does. Part of what's going on here is that the kernel code is trying to
> > give userspace access to the data for as long as possible.

> The problem is knowing which sample in the background music to start
> mixing the low latency laser blast into. ALSA will need to know this
> index to figure out where to switch onto the replacement buffer. This
> offset is dynamic and it depends on how much work pulse is doing.

Of course, some hardware is not going to allow the DMA controller to be
reprogrammed while active so would need to either wait for a buffer
boundary or update the data in the current buffer as is currently done.

> I'm starting to think the OSS model is right and mixing belongs in the kernel

This isn't a kernel/user problem.  Exactly the same issues come up if
the code pushing data into the driver is in the kernel, it'll still want
as much information as possible about what the current status is.

Moving any non-hardware stuff into the kernel would create more problems
than it solves.  Remember that ALSA supports arbitrary plugin stacks -
users could be doing signal processing on the data post mix, for example
doing soft EQ or 3D enhancement.  Some of this can be done pre-mix but
it'll always be less efficient and in some cases would interfere with
the operation of the algorithms.

Remember also that hardware output is just one option for ALSA.  You can
also have output plugins that do things like send data over the network.
