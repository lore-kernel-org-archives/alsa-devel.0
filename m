From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Remove useless inline
 function construct
Date: Mon, 6 Dec 2010 19:16:26 +0000
Message-ID: <20101206191625.GJ1924@rakim.wolfsonmicro.main>
References: <1291650560-16710-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2701103908
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 20:16:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291650560-16710-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 03:49:20PM +0000, Dimitris Papastamos wrote:
> There is no need to mark this function as inline.  Inline functions
> usually are small and concise functions that benefit from not needing
> to set up a stack frame and undergo a call/ret sequence upon each
> invocation.

Applied, thanks.
