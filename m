From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Bug: Alsa-lib 1.05 doesn't work with dmix plugin
 and noninterleaved mmap'ed access and regions-buffer ?
Date: Fri, 30 Jul 2004 19:37:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407301934210.1767@pnote.perex-int.cz>
References: <1b0d01c47649$a9f36f90$2c0aa8c0@lumpidu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1b0d01c47649$a9f36f90$2c0aa8c0@lumpidu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Schnell <daniel.schnell@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Jul 2004, Daniel Schnell wrote:

> ...
> 257 (!) frames avilable
> 108 chunked 149 chunked
> 511(!) frames available
> 363 chunked 148 chunked

Sorry, I don't understand this description.
Also, the dump of PCM configuration would be nice for analysis 
(snd_pcm_dump()).

> This seems to be where the problem arises, as I use the internal regions
> buffers, which are certainly allocated only to 256 frames (1024 bytes)
> and here a buffer overflow occurs. Afterwards the audio output ceases to

You may get more frames available - it depends on hardware interrupt 
acknowledge (in some cases the interrupt is delayed by some reason).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
