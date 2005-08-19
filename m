From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI Soundchip
Date: Fri, 19 Aug 2005 11:46:55 -0600
Message-ID: <20050819174655.GA6376@colo.lackof.org>
References: <20050817101017.008D03658E8@mail.esiee.fr> <Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2005 at 05:35:20PM +0200, Clemens Ladisch wrote:
...
> > reading the patch through webmail doesn't help a lot getting a grasp
> > of its whole but i wonder if we could still find some debugging
> > purposes for these values. Remember this driver is work in progress ;)
> 
> Those fields just aren't used anymore; anything interesting is in the
> chip's registers.

Clemens,
You don't want to be reading chip registers all the time.
It's *very* expensive. Cache any values that don't change
in a local struct if they get referenced regularly.

You might find the mmio_test results interesting.
It would be great if you could add one or two audio devices
to mmio_test program here:
	svn co http://svn.gnumonks.org/trunk/mmio_test/

Please send a patch to Harald Welte <laforge@gnumonks.org>.

thanks,
grant


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
