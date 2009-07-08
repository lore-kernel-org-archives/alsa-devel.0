From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: pcm,
	don't play 1st sound period twice
Date: Wed, 8 Jul 2009 16:00:34 +0100
Message-ID: <20090708150033.GC7678@rakim.wolfsonmicro.main>
References: <1247013366-32737-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4FF232445E
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 17:00:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247013366-32737-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2009 at 05:36:06PM -0700, Troy Kisky wrote:
> Update the dma link with correct data as soon as
> the master channel has copied it. Otherwise, the
> 1st period will play twice.

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

applied, thanks.
