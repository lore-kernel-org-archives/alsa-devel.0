From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA vs OSS: Some questions
Date: Mon, 7 Apr 2003 19:09:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304071900450.1675-100000@pnote.perex-int.cz>
References: <20030407162854.GD20285@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030407162854.GD20285@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Apr 2003, Frank Barknecht wrote:

> Hallo,
> 
> Jaroslav Kysela hat gesagt: // Jaroslav Kysela wrote:
> > OSS can handle more formats, of course. But, the main difference
> > between ALSA and OSS is that OSS doesn't handle non-interleaved
> > sample buffers at all in the mmap mode. 
> 
> I got another question here: Am I right to assume, that mmap mode is
> used, because it is the most efficient or is there hardware, that
> requires mmapped access?

The difference between mmap and the standard read/write access is that we 
have only one copy of data between application and the kernel space (it's 
also called "zero-copy" sometimes).

r/w access (playback):

application -> local buffer -> write() -> driver -> copy data from user to 
DMA ring buffer (you have duplicated data in local buffer and DMA ring 
buffer)

mmap access (playback):

application -> copy data to mmaped DMA buffer -> notify driver that there 
are new data (using mmaped ring buffer pointer, so we don't need to cross 
the user space / kernel boundary at all)

Note: OSS API does not use the mmaped ring buffer pointers, too. It's 
ALSA's invention.

Note2: All ALSA's drivers are mmap capable (except GUS GF1 PCM, but I'll 
recode this driver as well).

Note3: the r/w access can be always emulated on top of the mmap access

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
