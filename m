From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: clean up cache accesser
Date: Mon, 20 Dec 2010 16:42:02 +0000
Message-ID: <20101220164202.GC14986@sirena.org.uk>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de> <s5h1v5czb5m.wl%tiwai@suse.de>
	<s5hzks0xwjy.wl%tiwai@suse.de> <s5hy67kxwir.wl%tiwai@suse.de>
	<s5hwrn4xwdc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A90A11038EA
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 17:42:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwrn4xwdc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 05:05:51PM +0100, Takashi Iwai wrote:

> Erm, subject might be wrong, but I'm too dizzy now.

I think you just mean "Factor out cache accesses" or something?

> +static inline bool set_cache_val(void *base, unsigned int idx,
> +				unsigned int val, unsigned int word_size)
> +{
> +	if (word_size == 1) {
> +		u8 *cache = base;

Like Dimitris says these really do need to be switch statements.
Otherwise it looks OK.
