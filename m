From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Stop region iteration
	when	the desired region is found
Date: Fri, 29 Nov 2013 12:04:35 +0000
Message-ID: <20131129120435.GE10013@opensource.wolfsonmicro.com>
References: <1385656671-18519-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131128181943.GO27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC697265577
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:04:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131128181943.GO27568@sirena.org.uk>
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

On Thu, Nov 28, 2013 at 06:19:43PM +0000, Mark Brown wrote:
> On Thu, Nov 28, 2013 at 04:37:51PM +0000, Charles Keepax wrote:
> > When locating the memory region relating to a coefficient block written
> > through a bin file we keep processing the list of regions even after we
> > have found the region we require. This patch adds a break, so we don't
> > process redundant list items.
> 
> Applied, thanks.  I didn't look but does the same issue exist in the
> main firmware load, it's probably following the same pattern?

I had a look, no similar issues in the main firmware load.

Thanks,
Charles
