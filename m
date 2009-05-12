From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] control, hw,
 rawmidi: accept control device node as card identifier when opening
Date: Tue, 12 May 2009 18:54:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905121844280.25064@eeebox2.perex-int.cz>
References: <20090511224130.GA10955@omega>
	<alpine.LNX.2.00.0905120744260.25064@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0905121336130.25064@eeebox2.perex-int.cz>
	<20090512123229.GB29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121433510.25064@eeebox2.perex-int.cz>
	<20090512132447.GF29607@tango.0pointer.de>
	<alpine.LNX.2.00.0905121610420.25064@eeebox2.perex-int.cz>
	<20090512160436.GA14622@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5565F10385F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 18:54:07 +0200 (CEST)
In-Reply-To: <20090512160436.GA14622@tango.0pointer.de>
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

> Hmm? The first thing snd_pcm_hw_open() does is calling
> snd_ctl_hw_open(). So with your code, the name will bre resolved and
> the ctl device opened and closed for that. And then shortly after the
> device will be reopened right-away and then kept open. In my code
> after the resolving I'd just keep the device open.
>
> Your code requires three open()s for this, mine required two.

I see your point now - I forgot that control API is used to prefer 
subdevices. But it would be better to add some cache for ctl opens in 
alsa-lib rather than abusing other levels of API with additional 
information.

 				Thanks,
 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
