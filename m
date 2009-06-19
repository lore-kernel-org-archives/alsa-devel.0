From: Theodore Tso <tytso@mit.edu>
Subject: Re: LSB inclusion of ALSA
Date: Fri, 19 Jun 2009 08:45:44 -0400
Message-ID: <20090619124544.GF31377@mit.edu>
References: <4A3296D0.4080701@novell.com> <4A378931.8010102@ladisch.de>
	<s5h3a9z46ne.wl%tiwai@suse.de> <4A38AED6.4060009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thunker.thunk.org (thunk.org [69.25.196.29])
	by alsa0.perex.cz (Postfix) with ESMTP id B34001038D5
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 14:45:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A38AED6.4060009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Robert Schweikert <rschweikert@novell.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 17, 2009 at 10:52:38AM +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > Yes, I mentioned about this in the last conf call with LSB guys.
> > 
> > Another candidate is alsa-lib file plugin (and null plugin).  They can
> > be used to simulate in a certain level of I/O.
> 
> I don't think that LSB guarantees the availability of these plugins
> either.  (And they don't get the timing correct, but maybe we don't care
> about that.)

That's not necessarily fatal, *if* the LSB sound tests can include the
plugin in question.  Is the plugin interface a stable, published
interface?  That is, is it guaranteed to remain stable from release to
release of ALSA?  If so, then the test suite can provide the plugin,
just for the purposes of running the test.

> > From the LSB perspective, I suppose, the API compatibility is the
> > biggest issue.  The functionality, either working or not on the real
> > hardware, is a subsystem bug.  And, the subtle tests would be likely
> > needed done manually with the real hardware.

This is true, but some kind of minimal functionality testing is often
useful to make sure that the *meaning* of the parameters haven't
changed.  For example, to take an extreme example, if a library were
to accidentally change a long to "long long" in a function signature,
but because of how other parameters and what happened to be in the
registers on an x86 system, the program might not crash, and if were
testing with a no-op output function for the program, we might not
notice a problem.

So it's nice to be able to do a semantic test "does this function
actually do roughly what it is spec'ed to do", and not just a simple
API test.  On the other hand, we also recognize that perfection can
require far more resources than are available, so often we have to
settle for a basic test.

						- Ted
