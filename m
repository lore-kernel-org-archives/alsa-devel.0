From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Query devices in a non-blocking fashion / 3D
 capabilties.
Date: Mon, 15 Dec 2003 10:02:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312151001180.31653@pnote.perex-int.cz>
References: <oprztqwoi4q1sf88@mail.broadpark.no>
 <200312071919.hB7JJTNk004757@oud.linuxaudiosystems.com>
 <20031208161936.310df2cb.pochini@shiny.it>  <oprzvc5mu3q1sf88@mail.broadpark.no>
  <Pine.LNX.4.58.0312081745340.20863@pnote.perex-int.cz>
 <oprzvh60rmq1sf88@mail.broadpark.no> <3FDC8D16.6070608@boosthardware.com>
 <oprz6jjyl7q1sf88@mail.broadpark.no> <1071428796.17638.21.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1071428796.17638.21.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@mat.utfsm.cl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Dec 2003, Manuel Jander wrote:

> I looked into "alsa-kernel/core/control.c" and after finding out that
> every control interaction does a control lookup (iterated through all
> controls), i don't feel very confortable about using kcontrols to update
> hardware parameters in at tens of milisecond intervals.

Use it. We can improve the lookup algorithm (use hashes etc.).

> Then i discovered the ALSA /proc interface, but the docs read "use for
> debugging". They have a lot less overhead. Would it be OK to use them
> for hardware parameter update ? And if so, why don't you use this
> interface for queries ? They seem to give much more freedom about
> locking and other issues.

No, the proc interface is not definitely for these things.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
