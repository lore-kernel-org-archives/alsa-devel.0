From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode to
	psp
Date: Thu, 5 Mar 2009 13:34:40 +0000
Message-ID: <20090305133440.GA9794@rakim.wolfsonmicro.main>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
	<20090305132126.GE28878@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA98924475
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 14:34:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305132126.GE28878@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 02:21:26PM +0100, Daniel Mack wrote:

> I just saw that one of these bit fields we write to here is only
> available on PXA3xx - so we probably need the whole logic to be
> different for PXA2xx which makes everthing a lot more complicated.

At some point it's going to be better to just split the function using
these into PXA2xx and PXA3xx variants.

> Anyway, could the patch below be taken?

Yes, sure.  Will apply.
