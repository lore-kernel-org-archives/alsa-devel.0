From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware
	helper	for matching bus and codec drivers
Date: Fri, 18 Jul 2008 01:17:20 -0600
Message-ID: <20080718071720.GA2174@secretlab.ca>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
	<20080714171632.GH25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E01A24424
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 09:17:24 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so61348ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 00:17:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080714171632.GH25448@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 06:16:33PM +0100, Mark Brown wrote:
> On Mon, Jul 14, 2008 at 11:06:34AM -0600, Grant Likely wrote:
> 
> > I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
> > (only the mpc5200 i2s driver uses it at the moment).  It can always be
> > renamed if other folks want to use it for other chips.
> 
> That seems reasonable so long as you're happy with it, though it does
> seem to be going to the other extreme in terms of broadness :) 

Okay, I've changed my mind.  :-)  I'll back off a bit from this extreme and
call it:

sound/soc/fsl/soc-of-simple.c

Does that sound okay?  If non-freescale chips decide to use it then it
can be moved out of the freescale director.

Cheers,
g.
