From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: using a single stereo output from two distinct
 sources
Date: Sat, 6 Nov 2004 20:51:32 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411062051001.19991@pnote.perex-int.cz>
References: <20041106160411.25864.qmail@webmail2.aruba.it>
 <yw1xpt2rne14.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xpt2rne14.fsf@ford.inprovide.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Nov 2004, M?ns Rullg?rd wrote:

> "ubaldo" <ubaldo@eja.it> writes:
> 
> > Hi,
> >
> > my problem is that I have a single stereo output and I would like to
> > use the left channel from a program and the right one from another,
> > how can I open twice the "same" soundcard?
> 
> Use the dmix plugin.  Sufficient searching in the docs should reveal
> how.

dshare is more efficient for this case (no mixing only channel 
separation).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
