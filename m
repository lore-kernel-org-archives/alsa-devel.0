From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Sat, 19 Jul 2003 18:24:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307191823440.3903-100000@pnote.perex-int.cz>
References: <3F193061.2050505@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F193061.2050505@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vince <fuzzy77@free.fr>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 19 Jul 2003, Vince wrote:

> Jaroslav Kysela wrote:
> > On Fri, 18 Jul 2003, Vince wrote:
> > 
> > 
> >>P.S.: I intended to test alsa 0.9.5 (in the hope that this bug was 
> >>already known & has already been fixed), but unfortunately I get a 
> >>compile error (I simply dropped alsa-kernel 0.9.5 in the 2.6.0-test1-mm1 
> >>source tree):
> > 
> > 
> > Copy also header files from alsa-kernel/include to linux/include/sound.
> > 
> > 						Jaroslav
> 
> Thanks... If I made no mistake in installation, it appears that I still 
> get the exact same oops with 0.9.5 (btw alsa-kernel/include/version.h 
> still says 0.9.4 in the tarball):

Please, send us contents of /proc/asound/card0/pcm0p/sub0/* files after 
oops occured.

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
