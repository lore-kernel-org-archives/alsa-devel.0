From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Alsa won't load (Delta 410 and latest
 cvs snapshot)
Date: Tue, 21 Jan 2003 08:43:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301210830550.19857-100000@studcom.urz.uni-halle.de>
References: <3E2C0C7E.8040600@cvmt.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E2C0C7E.8040600@cvmt.dk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?S=F8ren?= Bovbjerg <sb@cvmt.dk>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Søren Bovbjerg wrote:
> /lib/modules/2.4.18-6mdk/kernel/sound/acore/snd-pcm.o:
> unresolved symbol vmalloc_to_page

This is a bug in ALSA.

Revision 1.4 of alsa-driver/acore/pcm_sgbuf.c added the following code:

	...
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
	page = vmalloc_to_page(vmaddr + (i << PAGE_SHIFT));
	...

but vmalloc_to_page() doesn't exist before 2.4.19.

AFAICS alsa-driver/drivers/vx/vx_pcm.c doesn't define it for 2.4.18,
either.


Clemens



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
