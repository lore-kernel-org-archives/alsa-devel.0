From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [PATCH] Kernel crash
Date: Thu, 16 Sep 2004 21:56:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040916215633.228bfc21.pochini@shiny.it>
References: <s5h7jr7whqj.wl@alsa2.suse.de>
	<XFMail.20040907095502.pochini@shiny.it>
	<20040911210212.317d930b.pochini@shiny.it>
	<s5hekl6tdru.wl@alsa2.suse.de>
	<20040913220729.466531ce.pochini@shiny.it>
	<s5h4qlzx22k.wl@alsa2.suse.de>
	<20040915195008.33713acb.pochini@shiny.it>
	<s5hhdpzs968.wl@alsa2.suse.de>
	<s5hacvqsbty.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacvqsbty.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Sep 2004 13:16:41 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > I think it'd be better to add a new field to substream to indicate the
> > DMA running status so that snd_pcm_stop() can be called safely
> > regardless of the current status.
> >
> > The situation right now is a mess, the DMA running state depending on
> > the stream direction and the state.
>
> We have a snd_pcm_running() so the flag is not always necessary
> (although it would be nice).
>
> In the current code, the PCM state is changed somehow unconditionally
> among all linked substreams via snd_pcm_change_state(), and apparently
> this causes the confusion.
>
> I did clean up and rewrite of pcm core stuff.
> Could you check the attached patch?

I had no time to check the code carefully, but it seems ok. I tested it and
it worked flawlessly. I'll do more testing tomorrow. Tnx.


--
Giuliano.--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
