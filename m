From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Virtual multi channel devices
Date: Mon, 13 Sep 2004 09:46:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040913094642.pochini@shiny.it>
References: <Pine.LNX.4.58.0409121359230.9366@linux.iitis.gliwice.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409121359230.9366@linux.iitis.gliwice.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Artur Rataj <arataj@iitis.gliwice.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 12-Sep-2004 Artur Rataj wrote:

> As far as I have read ALSA documentation, virtual multi channel devices do
> not resolve sync problems between the cards. Is this possible to resolve
> the problems by checking time differences between feeding the card
> buffers, and just adding buffer length/frequency to these times to
> determine when a sound is played, with a precision of about 1 ms or less?

In theory, yes it is. But the times between read/writing to the
buffers are not accurate. IMO the times between interrupts are
better, expecially if the two cards are using the same period
size. Maybe ALSA-kernel already exports the required timestamps.


> At least with some cards?

The two cards must have some way to syncronize the sample
clock (word clock or similar) so the difference between
the two cards is constant.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
