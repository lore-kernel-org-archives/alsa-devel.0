From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI Soundchip
Date: Thu, 11 Aug 2005 22:14:23 -0400
Message-ID: <20050812021423.GB14400@roadwarrior.mcmartin.ca>
References: <Pine.HPX.4.33n.0508041503020.11474-100000@studcom.urz.uni-halle.de> <Pine.HPX.4.33n.0508111716090.21860-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0508111716090.21860-100000@studcom.urz.uni-halle.de>
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
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2005 at 05:18:31PM +0200, Clemens Ladisch wrote:
> > This would make the interrupt handler much simpler, as it wouldn't
> > have to reprogram any registers.  And it would solve the problem that
> > the DMA accesses for one period go beyond the buffer when the number
> > of periods per buffer is not an integer.
> 
> ... something like this (please test):
> 

This doesn't apply against PA-RISC Linux CVS head (should have
no changes since submission) nor against ALSA CVS head... care to try
again? I don't have time to clean up the patch right now, it would
have to wait a week or so.

Cheers,
-- 
Kyle McMartin


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
