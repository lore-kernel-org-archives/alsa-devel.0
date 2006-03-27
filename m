From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Mantis: APPLICATION ERROR #401
Date: Mon, 27 Mar 2006 16:56:01 -0500
Message-ID: <1143496562.1792.289.camel@mindpipe>
References: <20060327232446.4435e280.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060327232446.4435e280.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-27 at 23:24 +0200, Giuliano Pochini wrote:
> I tried to add a note to the bug #1850. It seems lRevell wrote another note
> while I was writing mine. When I clicked "add note" Mantis replied:
> 
> 
> APPLICATION ERROR #401
> 
> Database query failed. Error received from database was #1062: Duplicate
> entry '8994' for key 1 for the query: INSERT INTO mantis_bugnote_text_table
> [...]
> 
> 
> Revell's note has been added. I tried to log out and in a few times, but
> I can't add a note the #1850 anymore.

Nice, you found a Mantis bug!  Looks like a missing LOCK TABLE ;-)

Redirecting to -devel list.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
