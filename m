From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_lib_preallocate_pages_for_all
Date: Tue, 6 Jul 2004 10:34:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407061029490.2318@linux.local>
References: <A6991F0FA073F34C94E97976CAC0323116F8E5@server2.nordicid.com>
 <s5hzn6e7lrj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzn6e7lrj.wl@alsa2.suse.de>
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

On Mon, 5 Jul 2004, Takashi Iwai wrote:

> Ah, of course, the crash in snd_pcm_lib_preallocate_pages_for_all has
> nothing to do with mmap.  I overlooked the point of crash.
> 
> The attached patch should fix it.

The patch looks wrong. Some architectures does not mark pages as reserved
and other do it. I discussed this problem with Russell and it seems that
there is no way to distinct these diferences using a generic way, so we
need to add #ifdefs for some platforms.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
