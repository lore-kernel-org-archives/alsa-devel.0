From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Kernel crash
Date: Fri, 17 Sep 2004 08:54:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409170847400.1774@pnote.perex-int.cz>
References: <s5h7jr7whqj.wl@alsa2.suse.de> <XFMail.20040907095502.pochini@shiny.it>
 <20040911210212.317d930b.pochini@shiny.it> <s5hekl6tdru.wl@alsa2.suse.de>
 <20040913220729.466531ce.pochini@shiny.it> <s5h4qlzx22k.wl@alsa2.suse.de>
 <20040915195008.33713acb.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040915195008.33713acb.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Sep 2004, Giuliano Pochini wrote:

> snd_pcm_playback_drain() (when state=RUNNING) calls
> snd_pcm_change_state(DRAINING). When substreams are linked, it changes the
> state of all linked substreams *without* passing through
> snd_pcm_capture_drain(DRAINING).

Guys, it's because Takashi changed the linked stream behaviour at some 
time. The first definition for linked streams was that only start of all 
stream was linked. The drain/drop operations were separated.

The linking makes sense for hardware that support that. Otherwise, we can 
start streams in most close time, but draining and dropping doesn't make 
much sense, because different clocking sources for different cards will 
produce jitter, thus there is no real sync and application must care.

I suggest to return back to state when only snd_pcm_start() 
is synchronized.

You can look to pcm_multi.c and test/latency.c - the drop/drain is called 
for all streams.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
