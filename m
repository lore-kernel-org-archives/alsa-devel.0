From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] control, hw,
 rawmidi: accept control device node as card identifier when opening
Date: Tue, 12 May 2009 16:40:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905121610420.25064@eeebox2.perex-int.cz>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
	<20090512123229.GB29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
	<20090512132447.GF29607@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 94D0E103849
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 16:40:25 +0200 (CEST)
In-Reply-To: <20090512132447.GF29607@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009, Lennart Poettering wrote:

> On Tue, 12.05.09 14:42, Jaroslav Kysela (perex@perex.cz) wrote:
>
>>
>> On Tue, 12 May 2009, Lennart Poettering wrote:
>>
>>> With my original patch there are no superfluous opens.
>>
>> If application uses more *open() calls from alsa-lib for one card (for
>> example to open ctl handle and pcm handle), it's better to obtain card
>> index at first, because each conversion requires one or more (card id)
>> open/close sequence for control device to get card_info. Providing direct
>> card index eliminates this conversion. It's just suggested optimization.
>
> I think if apps want to open ctl and hw at the same time the most
> elegant way would be this:
>
> <snip>
> snd_pcm_open(&pcm, "hw:/dev/snd/by-path/yaddayadda", ...);
> snd_pcm_info(pcm, &info);
> snd_ctl_open(&ctl, snprint("hw:%i", snd_pcm_info_get_card(info)));
> </snip>
>
> With my patch that costs exactly two open() calls. It's also more
> flexible since it will handle arbitrary device strings, doesn't need
> to hardcode "hw:".

The mentioned code will work with my patch as well. There is no 
difference, because extended snd_card_get_index() is called from _*open() 
callbacks when card argument is a string.

> You seem to suggest this:
>
> <snip>
> i = snd_card_index("hw:/dev/snd/by-path/yaddayadda");

It should be: i = snd_card_index("/dev/snd/by-path/yaddayadda");

> snd_hw_open(&hw, snprint("hw:%i", i));

You mean probably snd_pcm_open() here.

> snd_ctl_open(&ctl, snprint("hw:%i", i));
> </snip>
>
> Which your patch that costs three open()s.

It's similar to your patch. Two open calls. snd_pcm_open() does not use 
ctl device if a direct card index is specified.

> And hardcodes "hw".

It's not relevant. Your code also hardcodes "hw" (and application should 
decide if hw: is a proper interface not alsa-lib - any defined device 
which accepts the card argument will work).

> I really would like to know why my patch was so bad?

I do not think that an addition of extra argument to open() calls is good 
in this case. The card identification for open() calls is string anyway, 
because you may use syntax like 'hw:FirstHDACard' - see 'cat 
/proc/asound/cards' for string identification. All other extensions 
should be in the configuration area (in .conf files or configuration 
parsing code).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
