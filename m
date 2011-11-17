From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm8753: Skip noop reconfiguration of DAI
	mode
Date: Thu, 17 Nov 2011 16:48:40 +0000
Message-ID: <20111117164840.GF19918@opensource.wolfsonmicro.com>
References: <1321491170-12297-1-git-send-email-timo.lindfors@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38229103AD0
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 17:48:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321491170-12297-1-git-send-email-timo.lindfors@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timo Juhani Lindfors <timo.lindfors@iki.fi>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, ian@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 17, 2011 at 02:52:50AM +0200, Timo Juhani Lindfors wrote:
> This patch makes it possible to set DAI mode to its currently applied
> value even if codec is active. This is necessary to allow

Applied, thanks, but please make sure to use subject lines that match
the subsystem you're updating.
