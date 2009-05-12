From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCH] control, hw,
	rawmidi: accept control	device node as card identifier when opening
Date: Tue, 12 May 2009 18:04:37 +0200
Message-ID: <20090512160436.GA14622@tango.0pointer.de>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
	<20090512123229.GB29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
	<20090512132447.GF29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121610420.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BA5BD10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 18:05:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905121610420.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12.05.09 16:40, Jaroslav Kysela (perex@perex.cz) wrote:

> > With my patch that costs exactly two open() calls. It's also more
> > flexible since it will handle arbitrary device strings, doesn't need
> > to hardcode "hw:".
> 
> The mentioned code will work with my patch as well. There is no 
> difference, because extended snd_card_get_index() is called from _*open() 
> callbacks when card argument is a string.

Yes, it will work. But at the price of one extra open. 

> > You seem to suggest this:
> >
> > <snip>
> > i = snd_card_index("hw:/dev/snd/by-path/yaddayadda");
> 
> It should be: i = snd_card_index("/dev/snd/by-path/yaddayadda");

Yes, of course.

> 
> > snd_hw_open(&hw, snprint("hw:%i", i));
> 
> You mean probably snd_pcm_open() here.

Yes, you are right.

> > snd_ctl_open(&ctl, snprint("hw:%i", i));
> > </snip>
> >
> > Which your patch that costs three open()s.
> 
> It's similar to your patch. Two open calls. snd_pcm_open() does not use 
> ctl device if a direct card index is specified.

Hmm? The first thing snd_pcm_hw_open() does is calling
snd_ctl_hw_open(). So with your code, the name will bre resolved and
the ctl device opened and closed for that. And then shortly after the
device will be reopened right-away and then kept open. In my code
after the resolving I'd just keep the device open.

Your code requires three open()s for this, mine required two. 

> > And hardcodes "hw".
> 
> It's not relevant. Your code also hardcodes "hw" (and application should 
> decide if hw: is a proper interface not alsa-lib - any defined device 
> which accepts the card argument will work).

The example code I gave doesn't hardcode it. You can specify any
device as long as the stream info knows the card parameter properly.

> > I really would like to know why my patch was so bad?
> 
> I do not think that an addition of extra argument to open() calls is good 
> in this case. The card identification for open() calls is string anyway, 
> because you may use syntax like 'hw:FirstHDACard' - see 'cat 
> /proc/asound/cards' for string identification. All other extensions 
> should be in the configuration area (in .conf files or configuration 
> parsing code).

Hmm? The whole point of my patch was to make ALSA devices a bit more
like other devices, i.e. with persistancy of device symlinks and
stuff. Also, AFAICS the snd_pcm_hw_open() call (and friends) are
internal anyway?

Anyway, given that your code has the same effect as mine, it's
probably not worth dicussing this any further...

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
