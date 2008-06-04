From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revised AT32 ASoC Patch
Date: Wed, 4 Jun 2008 14:28:07 +0100
Message-ID: <20080604132806.GB2166@sirena.org.uk>
References: <200806031103.10785.geoffrey@pager.net>
	<s5hd4mx5ryk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BD68410380A
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 15:28:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4mx5ryk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 04, 2008 at 02:01:55PM +0200, Takashi Iwai wrote:
> Geoffrey Wossum wrote:

> > +struct at32_ssc_info {
> > +	char *name;
> > +	struct ssc_device *ssc;
> > +	spinlock_t lock;	/* lock for dir_mask */

> Just wondering whether this lock is really needed.
> Is it really racy?

Bidirectional ports could be in two PCMs and have configuration
happening simultaneously.
