From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: 2.5.5-pre1 kernel - compile as modules?
Date: Fri, 15 Feb 2002 15:54:45 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFOENICAAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA31838
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 16:54:43 +0100
In-Reply-To: <E16bdov-0001iK-00@baldrick>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Duncan Sands <duncan.sands@math.u-psud.fr>, Guenther Sohler <guenther.sohler@newlogic.com>
Cc: curtisv@lineo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could this be a devfs (device filesystem) problem ?
With devfs, devices appear as if by magic in the /dev directory.
The old system had all devices having entries in /dev whether present or
not.

Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Duncan Sands
> Sent: 15 February 2002 08:34
> To: Guenther Sohler
> Cc: curtisv@lineo.com; alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] 2.5.5-pre1 kernel - compile as modules?
>
>
> On Friday 15 February 2002 9:30 am, Guenther Sohler wrote:
> > did you insmod the snd.o ???
>
> Yes.  I have /proc/asound with all entries.  They just aren't
> readable.  The soundcard is detected when I modprobe the
> card module (nonetheless /proc/asound/cards is not readable:
> no such device).  I have been using the CVS and other versions
> of alsa with no problems, so this is presumably something to do
> with the kernel sound patch.
>
> Thanks for thinking about this,
>
> Duncan.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
