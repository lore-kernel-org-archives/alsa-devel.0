From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa-tools: cvscompile fails at ./configure for
	qlo10k1
Date: Tue, 29 Mar 2005 15:13:51 -0500
Message-ID: <1112127231.5141.4.camel@mindpipe>
References: <1111805637.24049.11.camel@mindpipe>
	 <20050327214650.GA769@skinner.hem.za.org>  <s5hsm2eiqv2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsm2eiqv2.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-29 at 14:22 +0200, Takashi Iwai wrote:
> At Sun, 27 Mar 2005 23:46:50 +0200,
> Mikael Magnusson wrote:
> > 
> > On Fri, Mar 25, 2005 at 09:53:57PM -0500, Lee Revell wrote:
> > ...
> > > aclocal:configure.in:12: warning: macro `AM_PATH_LD10K1' not found in library
> > > configure.in:12: error: possibly undefined macro: AM_PATH_LD10K1
> > >       If this token and others are legitimate, please use m4_pattern_allow.
> > >       See the Autoconf documentation.
> > > autoreconf: /usr/bin/autoconf failed with exit status: 1
> > ...
> > > 
> > 
> > AM_PATH_LD10K1 is defined in ld10k1.m4, which should have been installed
> > when you installed ld10k1.
> 
> Yes.  Also, ld10k1 requires as10k1 in advance (to compile examples).
> This should be mentioned in README...

OK.  People who expect ./cvscompile to just work will consider this a
bug though.  I guess if there is a bug it's that the cvscompile script
does not handle pre-dependencies.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
