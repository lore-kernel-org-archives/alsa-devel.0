From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: make dep
Date: Mon, 09 Jun 2003 12:04:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030609120455.pochini@shiny.it>
References: <Pine.LNX.4.44.0306091046250.1323-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306091046250.1323-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 09-Jun-2003 Jaroslav Kysela wrote:
>
>> How can I tell "make dep" to ignore some of the files listed in
>> "snd-mychip-objs" ?
>
> It is not possible. Could you send me your code? I will try to look what
> is wrong.

There's nothing wrong. The driver is based on the C++ code written by the
manufacturer. That code should be compiled indipendently from ALSA and
then linked to the main driver. "make dep" looks for .c files that don't
exist. As workaround, I defined a set of rules like this:

file.c:
        touch file.c

It works, but it's ugly. I was looking for a better solution.

Bye.



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
