From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
 drivers
Date: Thu, 13 Jan 2011 11:42:03 +0000
Message-ID: <20110113114203.GA30351@opensource.wolfsonmicro.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F9C324601
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 12:44:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 05:06:19PM +0530, Koul, Vinod wrote:

> Yes on both of these, but I didn't want to break current method.
> So I kept these to ensure both methods work fine.

> One we have converted all driver to use register then we can remove these.
> Would have made sense to put a comment for that

My plan for this when I originally wrote the comment had been to make
the contents of the soc-audio device probe and removal look exactly like
what you'd write directly in a machine driver so no code except for the
code doing the soc-audio device had any idea it was there.  This would
keep backwards compatiblity without special casing, making things more
maintainable.
