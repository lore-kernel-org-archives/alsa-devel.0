From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Can't set 88.2/96kHz samplerate with Hammerfall
Date: Fri, 05 Dec 2003 14:57:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20031205145725.pochini@shiny.it>
References: <oprzphu41uq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprzphu41uq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: alsa-devel@lists.sourceforge.net, Mark Knecht <mknecht@controlnet.com>
List-Id: alsa-devel@alsa-project.org


> Actually, I'm not completely opposed to the idea. But I am totally
> clueless when it comes to writing device drivers, and would have no
> idea where to start.

Start here: http://www.alsa-project.org/documentation.php3#Driver

You don't have to start writing the driver from scratch. You only
have to fix the current driver so you can also select 96KHz from
the PCM interface. The API is not difficult to learn.

> Do you know if RME were forthcoming with specs?

I asked for infos one year ago, but they just said no.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
