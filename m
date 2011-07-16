From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Report an error for unknown adav80x
	formats
Date: Sat, 16 Jul 2011 18:17:04 +0900
Message-ID: <20110716091701.GA9653@opensource.wolfsonmicro.com>
References: <1310783737-6075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E2110AC.1000701@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58E2A103A4D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jul 2011 11:17:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E2110AC.1000701@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 16, 2011 at 06:16:44AM +0200, Lars-Peter Clausen wrote:
> On 07/16/2011 04:35 AM, Mark Brown wrote:
> > Not only fixes error handling 

> Doesn't the core make sure that hw_params is only called with those formats
> listed as supported formats?

Yes, but the compiler doesn't know that - I only noticed this due to the
uninitialized variable warnings.
