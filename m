From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Release method?
Date: Wed, 23 Oct 2002 20:06:08 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210231953050.27945-100000@ecabase.localdomain>
References: <20021023165112.GA3423@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78169135.pp.htv.fi [62.78.169.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA31512
	for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2002 19:07:32 +0200
In-Reply-To: <20021023165112.GA3423@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@ieee.org>
Cc: Matthias Saou <matthias@rpmforge.net>, core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Oct 2002, Matt Flax wrote:

> One of the more beautiful things about ALSA is the fact that it is not 
> ready to settle ... it is progressive ... that in my opinion is why  the 
> API changes, along with other things like module names, etc.
> I'm sure though that it will and is mature enough to start settling 
> naturally ....

And, really, if you look at kernel development, this a very good way to do
development - not just while closing in on 1.0. 

If we continue comparing to the kernel, biggest problem with ALSA has been
the 'app-developers <-> ALSA' interface. While glibc has been the stable
wrapper for linux, alsa-lib's public API has been changing as much as the
internals - if not even more. ;) But of course, this comparison isn't
really fair as glibc mostly implements existing standard interfaces
(POSIX, XOPEN), while ALSA's APIs are new ones.

Anyway, my main point is that these two sides of ALSA (the alsa-lib public
API, and the rest), should be discussed separately. For the former,
changes are highly undesirable, while for the latter, continuous progress
is the only way to go.

PS Btw; nothing stops from developing new, better public interfaces
   for alsa-lib after 0.9 and 1.0, but these should be developed as 
   alternatives, not breaking the old API.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
