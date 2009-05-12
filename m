From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] control, hw,
	rawmidi: accept control	device node as card identifier when opening
Date: Tue, 12 May 2009 15:24:47 +0200
Message-ID: <20090512132447.GF29607@tango.0pointer.de>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
	<20090512123229.GB29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E19CC103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 15:25:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12.05.09 14:42, Jaroslav Kysela (perex@perex.cz) wrote:

> 
> On Tue, 12 May 2009, Lennart Poettering wrote:
> 
> > With my original patch there are no superfluous opens.
> 
> If application uses more *open() calls from alsa-lib for one card (for 
> example to open ctl handle and pcm handle), it's better to obtain card 
> index at first, because each conversion requires one or more (card id) 
> open/close sequence for control device to get card_info. Providing direct 
> card index eliminates this conversion. It's just suggested optimization.

I think if apps want to open ctl and hw at the same time the most
elegant way would be this:

<snip>
snd_pcm_open(&pcm, "hw:/dev/snd/by-path/yaddayadda", ...);
snd_pcm_info(pcm, &info);
snd_ctl_open(&ctl, snprint("hw:%i", snd_pcm_info_get_card(info)));
</snip>

With my patch that costs exactly two open() calls. It's also more
flexible since it will handle arbitrary device strings, doesn't need
to hardcode "hw:".

You seem to suggest this:

<snip>
i = snd_card_index("hw:/dev/snd/by-path/yaddayadda");
snd_hw_open(&hw, snprint("hw:%i", i));
snd_ctl_open(&ctl, snprint("hw:%i", i));
</snip>

Which your patch that costs three open()s. And hardcodes "hw". 

I really would like to know why my patch was so bad?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
