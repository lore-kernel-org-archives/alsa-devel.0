From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fixes to McASP configuration
Date: Thu, 17 Sep 2009 13:09:27 +0100
Message-ID: <20090917120926.GA449@rakim.wolfsonmicro.main>
References: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
	<20090916201819.GB20675@rakim.wolfsonmicro.main>
	<002b01ca378e$7f462e70$7dd28b50$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5EEA1038BA
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 14:09:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <002b01ca378e$7f462e70$7dd28b50$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, 'Troy Kisky' <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 05:30:49PM +0530, Chaithrika U S wrote:

> May be my commit message is misleading. Currently, McASP is configured 
> for DSP mode and I have tested for that mode.

Ah, yes - I see that it's just got a hardcoded mode, I had misremembered
the features that are supported since the original i2s driver supports
more.  Thanks for clarifying.  Unless someone says anything I'll apply
this later today or tomorrow.
