From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/06] Fix compilation warning for
 sound/soc/codecs/wm8400.c
Date: Thu, 16 Jul 2009 14:23:08 +0100
Message-ID: <20090716132308.GC9656@rakim.wolfsonmicro.main>
References: <20090716130958.28045.71072.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D829110385E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 15:23:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090716130958.28045.71072.sendpatchset@subratamodak.linux.ibm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Jaroslav Kysela <erex@perex.cz>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 06:40:01PM +0530, Subrata Modak wrote:

> How about the following brutal shutdown ?

No, this is the patch you originally submitted.  You are missing the
point here - your patches are all just papering over the warning and
won't help at all if there is an actual problem.

> 'factors' will get initialized here, as, 'freq_out' will probably never have
> a '0' value. So, 'fll_factors()' will actually overwrite values in 'factors'
> even after the initial brutal assignment:
> 	"struct fll_factors factors = {}"

This is pretty much the point of the warning when it's valid - it's
trying to catch situations where there is a code path where the variable
is used without being initialised.  If you just blindly initialise the
variable as you are doing then the warning goes away but any problematic
code remains so the situation is worse.

In this case I suspect that whatever compiler you are using (none of
those I've tried with seem to be doing this) isn't able to figure out
that if we skip initialising the variable then we use exactly the same
condition to return from the function before we try to use the variable.
For something like this the warning can normally be worked around by
changing the control flow so that the compiler is able to figure out
that things are safe.
