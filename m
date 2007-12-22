From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Disable conversions
Date: Sat, 22 Dec 2007 23:37:01 +0100
Message-ID: <20071222223701.GB13486@tango.0pointer.de>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hsl2zhlmh.wl%tiwai@suse.de>
	<20071125204132.GA15151@tango.0pointer.de>
	<Pine.LNX.4.61.0711261638320.24363@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id DFFCB1038C5
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 23:37:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0711261638320.24363@tm8103.perex-int.cz>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26.11.07 16:55, Jaroslav Kysela (perex@perex.cz) wrote:

> 1) Proposal - one argument specifying multiple disabled conversions:
> 
>    plughw:CARD=0,DEV=0,DISABLECONV=cfr
> 
>    c = channels
>    f = format
>    r = rate
> 
>    And add 'disableconv' to pcm/pcm_plug.c configuration parser.

Works for me. However, abbreviating things too brutally doesn't seem
like a good idea, I'd thus vote for your proposal #2:

> 2) Proposal - multiple arguments
> 
>    plughw:CARD=0,DEV=0,DISABLECHANNELS=1,DISABLERATE=1,DISABLEFORMAT=1
> 
> I prefer first proposal (I don't think that it will be widely used), but I 
> have no objections for second, too.
> 
> This can be applied to plug: device as well.

It would be great if something like this would be available. I am
happy with either, as long as I can make use of it!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
