From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aoss failures under Alsa-1.0.0rc1
Date: Fri, 5 Dec 2003 09:56:01 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKEIDECAB.mknecht@controlnet.com>
References: <Pine.HPX.4.33n.0312051804500.8570-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312051804500.8570-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
> There is a change in alsa-oss.c, immediately after rc1 came out, with
> the following log message:
>
> - avoid the assert in snd_pcm_drain().
> - fixed the possible segfault at the wrong release of resources.
> - more debug messages.
>
Clemens,
   Thanks. In this case I will either make the effort to modify the Gentoo
ebuild myself, or wait for Gentoo to catch up. They were only 2 days behind
this time on rc1 making me think an Alsa developer must be right in the
ebuild loop these days.

   Thanks for all your help. Hopefully we can get this working soon.

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
