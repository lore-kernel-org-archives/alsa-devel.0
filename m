From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: plz fix this before alsa 1.0.0 get's released
Date: Mon, 15 Dec 2003 01:57:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xn09uew3f.fsf@kth.se>
References: <1071448695.2358.6.camel@d51521F3E.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kristof vansant <de_lupus@pandora.be> writes:

> alsa won't compile on kernel 2.6 
> removing sndversions.h in vxp440.c and vxpocket.c does the trick. 
>
> /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:6:31:
> linux/modversions.h: Onbekend bestand of map
> /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:7:25: sndversions.h:
> Onbekend bestand of map

That's the Dutch message for "No such file or directory", right?  It's
nice to set the language to English when posting error messages.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
