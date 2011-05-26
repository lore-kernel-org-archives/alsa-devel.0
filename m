From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix comment in cs4270 codec
	driver
Date: Thu, 26 May 2011 09:27:00 +0800
Message-ID: <20110526012659.GA13425@opensource.wolfsonmicro.com>
References: <1306309992-3624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D9DF12414A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 03:27:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306309992-3624-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2011 at 09:53:12AM +0200, Daniel Mack wrote:
> The comment does not reflect reality anymore since the multi-component
> monster patch landed. Things are matched by names now, and not by
> exporting and referencing a struct. Fix it to avoid confusion.

Applied, thanks.
