From: Giuliano Pochini <pochini@shiny.it>
Subject: PCI problem
Date: Mon, 19 May 2003 18:10:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030519181029.pochini@shiny.it>
References: <20030519024010.3367.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030519024010.3367.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I would like some hints on this problem. When I load the module
the machine hangs solid or it works fine depending on which
PCI bus slot the card is. Initializations completes if the card
is in a slot that shares IRQ with something (ethernet IIRC). The
card doesn't send IRQs during init.
When I try to play something the box crashed badly:

>Start Transport
>uhci ac00 host system error, PCI problem?
>uhci ac00 host controller process error, something bad happened.
>uhci ac00 host controller halted. Very bad.

:( Any ideas ?

I don't own that card, I just reported what a betatester told
me. The card works fine under windos. Another person has the
same card and no problems.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
