From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Echoaudio, card "appears" later
Date: Mon, 26 Sep 2005 12:02:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0509261159370.13989@denise.shiny.it>
References: <Pine.HPX.4.33n.0509260955560.13755-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509260955560.13755-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Mon, 26 Sep 2005, Clemens Ladisch wrote:

> > I'm using alsa-lib/kernel/driver I downloaded last friday
> > with cvs, linux 2.6.13rc6, 2.6.13.2, on SMP powerpc. Just
> > after the moduled is loaded, aplay -l (or any other app)
> > cannot find any card. After a few attemps to run the app the
> > card becomes visible and everything works file.
>
> Are you using udev?  How fast are the device nodes in /dev/snd/ being
> created?

Ah. Yes, I installed Gentoo recently and it uses udev, indeed. Sorry for
the noise.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
