From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: performance difference between ioctl and read/write?
Date: Mon, 11 Mar 2002 15:01:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203111457010.550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5h8z8zfczq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Mar 2002, Takashi Iwai wrote:

> Hi,
> 
> the current alsa driver uses ioctl for read and write pcm data.
> while writing the 32 -> 64 bit ioctl wrapper, i found that there might
> be difference between ioctl and read/write wrt the performance on
> SMP.
> sys_ioctl() calls a global lock_kernel() during ioctl operation,
> while read and write don't.
> i'm not sure whether/how this affects.  did anybody investigate this
> already?

This lock is released when ioctl code calls schedule*(). We have no CPU
intensive data processing in the kernel space, so I think that this
penalty is minimal. Sure, it would be better to move such locking from
sys_ioctl to driver code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
