From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: MOTU development
Date: Fri, 29 Jun 2007 09:13:42 +0930 (CST)
Message-ID: <200706282343.l5SNhg98016085@turbo.physics.adelaide.edu.au>
References: <mailman.606.1183056120.2053.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id B07A424383
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 01:43:46 +0200 (CEST)
In-Reply-To: <mailman.606.1183056120.2053.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Jun 28, 2007 08:42:00 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: per@erinet.se, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Per

> I'd like to know more about the health on the connections to MOTU, if
> they give any information about their products and how the development
> has proceeded over the years.

It kind of depends which MOTU devices you're asking about.  There is, for
example, an alsa driver for the MOTU Midi Timepiece AV (MTPAV) which
presumedly makes the midi side of this available via the ALSA sequencer
system.

I can't speak for any of MOTU's PCI/PCIe cards.  However, in connection with
their more recent outboard interfaces MOTU have been, to put it mildly,
extremely unhelpful.  Some on the net go so far as to say they are hostile
to Linux.  The facts are that despite multiple people requesting information
from MOTU on how to drive their firewire interfaces MOTU have responded
every time with a very terse non-negotiable "no, never".  I don't know if
anyone's ever asked about their USB-equipped devices but I can't imagine the
answer would be any different.

Despite this, some progress is being made in supporting MOTU firewire
devices under linux.  For various reasons this support is not through ALSA
but instead as part of the FFADO project.  FFADO provides a userspace
library for driving firewire audio devices in general and a JACK backend
allowing such devices to be used by any jack-enabled software.  An ALSA
backend is planned but no work has been done towards this yet.  Check out
www.ffado.org for information on this project.

Device support in FFADO varies.  Some interfaces for which we have vendor
support are doing very well, while supporting an interface such as the MOTUs
without any documentation is challenging.  However, the MOTU control
protocol is pretty well understood at this point in time and it is possible
to actually use the MOTU firewire devices for real work under Linux (as I
have been for about 9 months now).  The trap is that one needs to use an
earlier revision of ffado at present.  Back in February some key FFADO
infrastructure changed.  From before that until the last week or so I've
been busy with production projects and so haven't had a chance to update the
MOTU FFADO driver and restore its functionality.  I'm back on the case now
though and hope to make progress in the next month or so.

If you want further details about all this please contact me off-list and
I'll fill you in.

Best regards
  jonathan
