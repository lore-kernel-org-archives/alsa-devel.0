From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix warning from strict_strtoul()
Date: Sun, 6 Jul 2008 00:23:25 +0100
Message-ID: <20080705232324.GA12558@sirena.org.uk>
References: <1215183674-13038-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h3amplm8f.wl%tiwai@suse.de>
	<20080704195753.GA20719@sirena.org.uk>
	<s5h3amo6ais.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B87B2439C
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 01:23:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3amo6ais.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 05, 2008 at 09:43:55AM +0200, Takashi Iwai wrote:

> Anyway this also fixes another strange behavior - strict_strtoul()
> stores 0 when it gets a parse error.  So, in the older version, the
> pop_wait itself is reset to 0 at error while the value is kept in the
> newer version.

Oh, so it does - how unhelpful (if understandable) of strict_strtoul().
Good job I decided to do this fix rather than changing the type of
pop_time :)
