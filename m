From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Metering on record
Date: Mon, 29 Sep 2003 14:30:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309291426290.1362@pnote.perex-int.cz>
References: <20030928121741.45922701.erikd-alsa@mega-nerd.com>
 <Pine.LNX.4.53.0309291033310.1362@pnote.perex-int.cz>
 <20030929222245.6d5260f8.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030929222245.6d5260f8.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Sep 2003, Erik de Castro Lopo wrote:

> On Mon, 29 Sep 2003 10:37:56 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
>
> > The examples are in alsa-lib/src/pcm/scopes directory, but don't expect
> > a better response times, because the meter plugin is also activated
> > when an application reads or writes data to device.
>
> Does that mean that the only way to get better meter response is to
> read smaller blocks?

Not really. The plugins are activated when snd_pcm_avail_update() is
called, so if you write own meter plugin and call snd_pcm_avail_update
more frequently in the read thread, you may get better results. But I
think that it might be better to read small chunks, because samples are
already processed when snd_pcm_avail_update() is called so there is no
point to delay the processing in application. In other words, it's better
to do additional (large) buffering in application to avoid xruns.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
