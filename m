From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive
	exception	handling
Date: Sun, 8 Dec 2013 14:47:48 +0000
Message-ID: <20131208144748.GB5862@opensource.wolfsonmicro.com>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131203182256.GL27568@sirena.org.uk> <20131203201828.GC29268@sirena.org.uk>
 <20131205142528.GG23979@opensource.wolfsonmicro.com>
 <20131205145746.GU29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D9AD6261B0D
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 15:47:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131205145746.GU29268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 05, 2013 at 02:57:46PM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2013 at 02:25:28PM +0000, Charles Keepax wrote:
> 
> > Tricky thing is making 100% sure we don't enter a poll
> > after we have received the signal, especially if we are just
> > using the standard pattern of communicating the signal using a
> > sig_atomic_t.
> 
> If you don't buffer and use Unix I/O rather than stdio for any I/O in
> the handler you can exit happily from the handler IIRC, the big problem
> is stdio.

Cool, I will have a look at this in more detail and respin the
series. 

Thanks,
Charles
