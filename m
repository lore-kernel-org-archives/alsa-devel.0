From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Question on ALSA versions
Date: Fri, 5 Nov 2004 07:03:51 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411050658540.18780@pnote.perex-int.cz>
References: <cmciu9$hsn$1@sea.gmane.org> <1099596730.1617.61.camel@krustophenia.net>
 <cmf0td$rqv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <cmf0td$rqv$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 5 Nov 2004, Alexander E. Patrakov wrote:

> > In practice it usually works but there have been some specific incidents
> > where this caused problems.  For example when a major change is made to
> > a driver the hardware specific parts of alsa-lib will be updated to
> > reflect the change.
> 
> Isn't it what minor and major versions are for? Or are they just an old
> artifact that should not be relied upon? Or there is just lack of testing?

The alsa-lib 1.0+ should be compatible with ALSA driver code in 2.6
kernels. Of course, it's better to use last alsa-lib because of bug-fixes.  
This is true for drivers as well.

The alsa-lib code tries to emulate new kernel driver features when older 
driver is used. Also, the configuration files might be changes reflecting 
the specific lowlevel driver, so in some cases, you'll need configuration 
files matching specific driver version (emu10k1 driver is an example).

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
