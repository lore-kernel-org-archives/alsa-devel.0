From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: LSB inclusion of ALSA
Date: Fri, 19 Jun 2009 15:43:33 +0200
Message-ID: <4A3B9605.1070303@ladisch.de>
References: <4A3296D0.4080701@novell.com> <4A378931.8010102@ladisch.de>
	<s5h3a9z46ne.wl%tiwai@suse.de> <4A38AED6.4060009@ladisch.de>
	<20090619124544.GF31377@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 946F51038E9
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 15:43:36 +0200 (CEST)
In-Reply-To: <20090619124544.GF31377@mit.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Theodore Tso <tytso@mit.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Robert Schweikert <rschweikert@novell.com>
List-Id: alsa-devel@alsa-project.org

Theodore Tso wrote:
> On Wed, Jun 17, 2009 at 10:52:38AM +0200, Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> > > Another candidate is alsa-lib file plugin (and null plugin).  They can
> > > be used to simulate in a certain level of I/O.
> > 
> > I don't think that LSB guarantees the availability of these plugins
> > either.  (And they don't get the timing correct, but maybe we don't care
> > about that.)
> 
> That's not necessarily fatal, *if* the LSB sound tests can include the
> plugin in question.  Is the plugin interface a stable, published
> interface?  That is, is it guaranteed to remain stable from release to
> release of ALSA?

Yes.

However, the plugin interface itself is not part of LSB.  If there were
some alternative ALSA implementation that wanted to be LSB conformant,
the test would not work.  (There are currently two alternatives, both
named "SALSA", but neither one implements the full interface.)


Best regards,
Clemens
