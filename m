From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_async_add_pcm_handler() and SND_PCM_ACCESS_MMAP_INTERLEAVED
Date: Thu, 15 May 2003 11:11:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305151108590.9877-100000@pnote.perex-int.cz>
References: <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030515095924.03421e38@pop.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Vollmer <remllov_@gmx.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 15 May 2003, Peter Vollmer wrote:

> Hi all,
> 
> I am trying to use the mmap access method together with an async_handler 
> function (ice1712 in multitrack mode),
> but in a setting where multiple periods fit into a buffer, I get back the 
> same address pointer to the accessible data in  snd_pcm_mmap_begin(...) in 
> areas[x].addr multiple times (one for every period in the buffer, I guess) 
> in the signal handler. I was following the pcm.c sinus generator demo more 
> or less, but the combination of mmap/async_handler is not used there.

I've added async_direct method to show you the right code. The updated 
pcm.c is in CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
