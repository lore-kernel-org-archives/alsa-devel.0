From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Report an error for unknown adav80x
	formats
Date: Sat, 16 Jul 2011 06:16:44 +0200
Message-ID: <4E2110AC.1000701@metafoo.de>
References: <1310783737-6075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id F0A4D103A4D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jul 2011 06:18:59 +0200 (CEST)
In-Reply-To: <1310783737-6075-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 07/16/2011 04:35 AM, Mark Brown wrote:
> Not only fixes error handling 
Doesn't the core make sure that hw_params is only called with those formats
listed as supported formats?

> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
