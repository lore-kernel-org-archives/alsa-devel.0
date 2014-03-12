From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Split firmware load into
	smaller chunks
Date: Wed, 12 Mar 2014 15:31:21 +0000
Message-ID: <20140312153121.GO8570@opensource.wolfsonmicro.com>
References: <1394029696-25975-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140312002906.GA4063@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70444264F09
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 16:31:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140312002906.GA4063@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2014 at 12:29:06AM +0000, Mark Brown wrote:
> On Wed, Mar 05, 2014 at 02:28:16PM +0000, Charles Keepax wrote:
> > The firmware files can be quite large and allocating the whole firmware
> > a single DMA safe buffer can be problematic if the system is under a
> > high memory load. Ease the requirements slightly by writing the firmware
> > out in page sized chunks.
> 
> While looking at some other related stuff it occurred to me that while
> this is probably what you want for your backported code for upstream you
> probably want to just convert to vmalloc() - SPI will do DMA mappings in
> page sized chunks in order to support this so you get a similar effect
> but without needing to split into multiple physical writes so it can all
> be pushed down into hardware for best performance.

Sounds sensible I will look at testing this and doing a patch for
it.

Thanks,
Charles
