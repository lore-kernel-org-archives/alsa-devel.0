From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI
 Soundchip
Date: Sun, 28 Aug 2005 14:57:11 +0200
Message-ID: <20050828145711.07974414@Tatooine.r3z0>
References: <20050817101017.008D03658E8@mail.esiee.fr>
	<Pine.HPX.4.33n.0508171249360.19860-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org, kyle@parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Aug 2005 17:35:20 +0200 (METDST)
Clemens Ladisch <clemens@ladisch.de> wrote:

> Thibaut VARENE wrote:
> > > -/* "<ggg> T-Bone: parisc IOMMU can start DMA at any address.
> > > -   But the IOMMU can only map at page size granularity."
> > > -   This affects in particular .period_bytes_min */
> > > -#define BUF_SIZE        PAGE_SIZE
> > > -#define MAX_BUFS        32
> > > -#define DMA_SIZE	(MAX_BUFS*BUF_SIZE)
> >
> > don't remove these defines please, i'd rather have every constants
> > defined in the header file.
> 
> I removed them because it wouldn't make sense to derive the buffer
> size from the period size in the patched driver.  I used some more or
> less random values because these values aren't anymore restricted by
> the chip's constraints.
> 
> > Besides, the comment is very relevant to PA-RISC architecture,
> > where no matter what the value is, the minimum allocated space
> > will always be at page size granularity.
> 
> Most IOMMUs have this restriction.  ALSA's PCM buffer is always page
> aligned, so drivers that do DMA over the entire buffer just don't
> care.

ok fine then.

> 
> Attached is a new patch with symbols for buffer size etc.

Tested and it works fine, as far as i can tell. I can't see any other
objection against it being merged in our tree and in the patch i sent
upstream ;) As far as I'm concerned, the driver is now ok to be included
in mainline.

kyle: if it's fine for you too, please let us know and commit this patch
to the parisc tree, i'll be offline for yet another bunch of days alas :P

HTH

Thibaut VARENE
The PA/Linux Team
http://www.pateam.org/


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
