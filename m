From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] crec: Add primitive
	exception	handling
Date: Thu, 5 Dec 2013 14:25:28 +0000
Message-ID: <20131205142528.GG23979@opensource.wolfsonmicro.com>
References: <1386088075-21011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1386088075-21011-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131203182256.GL27568@sirena.org.uk> <20131203201828.GC29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DDBB265536
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:25:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131203201828.GC29268@sirena.org.uk>
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

On Tue, Dec 03, 2013 at 08:18:28PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 06:22:56PM +0000, Mark Brown wrote:
> 
> > You can't safely do most of this such as calling fclose() from within a
> > signal handler, the set of functions that are guaranteed safe is quite
> > limited - see signal(7).
> 
> I should also have mentioned that it looks like you're probably looking
> for setvbuf() with _IONBF.

All good points, it is probably worth just merging the first
patch in the series for now and I can have a more detailed look
at the second patch.

Tricky thing is making 100% sure we don't enter a poll
after we have received the signal, especially if we are just
using the standard pattern of communicating the signal using a
sig_atomic_t.

Thanks,
Charles
