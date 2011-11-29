From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/7] firmware: Sigma: Prevent out of
 bounds memory access
Date: Tue, 29 Nov 2011 10:12:48 +0000
Message-ID: <20111129101247.GA2851@opensource.wolfsonmicro.com>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1958A24495
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 11:12:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322469860-8210-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 09:44:14AM +0100, Lars-Peter Clausen wrote:

> Mark, in case you are ok with these patches could you take them through your
> ASoC tree? The firmware subsystem is orphaned.

Yeah, I was planning to do that but I was waiting for Mike to be happy
with everything as he'd had a few concerns on the previous round.  He's
now acked some but not all of the series but there was no followup on
the other patches - Mike, are you OK with the other changes?
