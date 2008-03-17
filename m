From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA and SALSA install
Date: Mon, 17 Mar 2008 22:43:18 +0000
Message-ID: <200803172243.18609.gineera@aspect135.co.uk>
References: <200803061641.33445.gineera@aspect135.co.uk>
	<47D01FCB.2010509@ladisch.de>
	<200803072031.27878.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id D6D4F24558
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 23:41:39 +0100 (CET)
In-Reply-To: <200803072031.27878.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 07 March 2008 20:31, I wrote:
> On Thursday 06 March 2008 16:46, Clemens Ladisch wrote:
> > Alan Horstmann wrote:
> > > Is there a way to install both at the same time, so on a PC code can be
> > > compiled and experimented with first -lasound and then -lsalsa without
> > > alternately re-installing the libraries with make install?
> >
> > It should be possible to install salsa-lib into another directory (by
> > using the *prefix configure options) and then to change the include
> > and library paths when compiling the program that uses it.
>
> Thanks, that is the sort of thing I had hoped was possible; will try that
> at the next opportunity.

Just to tidy off this thread, here's what I have done to achieve this.  (I 
know it's not rocket science!)  The problem is actually with the headers, not 
the library, as both libs exist in /usr/lib.

First I manually created the salsa headers seperately in /usr/include/salsa.  
Then in the code put:
	#ifdef SALSA
	#include <salsa/asoundlib.h>
	#else
	#include <alsa/asoundlib.h>
	#endif

Then on the gcc command line  
	... -D SALSA -lsalsa
builds with salsa, or
	... -lasound
with standard Alsa.  Is this all OK?

The salsa standard install prefixes etc seemed to always put the headers under 
a alsa/ subdirectory.  By editing salsa-lib..../src/Makefile.in
	L244    alsaincludedir = $(includedir)/salsa
the headers are put in usr/include/salsa.

I think the option of automatically installing salsa headers as above (ie /
usr/include/salsa/asoundlib.h, etc) would be useful but it doesn't seem that 
the value of 'alsaincludedir' can be set as a configure option.  Might it be 
worth adding it so
	./configure --alsaincludedir=...
is available?

Alan
