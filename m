From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: intek8x0 driver
Date: Sun, 20 Jul 2003 13:57:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307201355360.3903-100000@pnote.perex-int.cz>
References: <200307201304.51654.dirk_aust@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307201304.51654.dirk_aust@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Aust <dirk_aust@gmx.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Jul 2003, Dirk Aust wrote:

> Hello all,
> I have some difficulties using the /dev/dsp devices, when trying to use the 
> call: 
> 
> mmap2(NULL, 16384, PROT_READ, MAP_SHARED, 5, 0) = -1 EIO (Input/output error)

Note that you are allowed to mmap only stereo 16-bit streams with 
the intel8x0 driver (and maybe only at 48kHz rate - check your 
/var/log/messages, if your codec is restricted).

> If I'm not root, I even can't read() from that device, even though I'm the 
> owner of /dev/dsp0.

Probably a permission problem.

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
