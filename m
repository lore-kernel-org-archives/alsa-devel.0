From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_mmap_begin returns 0 but sets areas to NULL
Date: Wed, 23 Jul 2003 08:57:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307230853020.6261-100000@pnote.perex-int.cz>
References: <20030722135158.GA12258@alinoe.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030722135158.GA12258@alinoe.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlo Wood <carlo@alinoe.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Jul 2003, Carlo Wood wrote:

> Is it ever allowed that:
> 
>     snd_pcm_channel_area_t const* areas;
>     snd_pcm_uframes_t offset;
>     snd_pcm_uframes_t size = period_size;
>     if (size > 0)
>     {
>       snd_pcm_uframes_t frames = size;
>       int err = snd_pcm_mmap_begin(handle, &areas, &offset, &frames);
> 
> returns err == 0, but results in areas == NULL ?
> 
> Or is that a bug in alsa?

Perhaps, you're in a bad state. Did you call hw_params() with a MMAP
access request before?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
