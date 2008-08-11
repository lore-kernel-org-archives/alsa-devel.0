From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Kill snd_assert()
Date: Mon, 11 Aug 2008 10:52:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808111047050.21669@tm8103-a.perex-int.cz>
References: <s5h1w0wlz9a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F20D10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 10:52:30 +0200 (CEST)
In-Reply-To: <s5h1w0wlz9a.wl%tiwai@suse.de>
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

On Mon, 11 Aug 2008, Takashi Iwai wrote:

> Hi,
> 
> as some people already mentioned, we have a pretty ugly macro, snd_assert().
> Actually, this macro is sometimes useful, but the implementation including
> the code flow in arguments is really bad.
>
> I tried to kill this, either the following way:
> 
>  - replace
> 	snd_assert(cond, flow...);
>    with
> 	if (snd_BUG_ON(!cond))
> 		flow...;

For my eyes, many uses of snd_assert with direct 'return VALUE' are more
"sexy", easy understandable and smaller. But, as mentioned, when goto is
used to change the code flow, we end up with a compiler warning. It should 
be eliminated.

I have no strong objections to accept this change as you proposed. Thank 
you for your work.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
