From: Artur Rataj <arataj@iitis.gliwice.pl>
Subject: RE: Virtual multi channel devices
Date: Mon, 13 Sep 2004 13:39:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409131332250.11209@linux.iitis.gliwice.pl>
References: <XFMail.20040913094642.pochini@shiny.it>
Reply-To: Artur Rataj <arataj@iitis.gliwice.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20040913094642.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Mon, 13 Sep 2004, Giuliano Pochini wrote:

> In theory, yes it is. But the times between read/writing to the
> buffers are not accurate. IMO the times between interrupts are
> better, expecially if the two cards are using the same period
> size. Maybe ALSA-kernel already exports the required timestamps.
>

Is something like that planned in ALSA? Like dropping samples or
adding interpolated samples to slow/fast cards?

Artur


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
