From: Paul Davis <pbd@op.net>
Subject: Re: libasound and libpthread
Date: Mon, 29 Jul 2002 12:04:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17ZCzV-0002ec-00@usw-sf-list1.sourceforge.net>
References: <3D455C2D.50302@emt.iis.fhg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Jul 2002 17:15:57 +0200."
             <3D455C2D.50302@emt.iis.fhg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thomas Roeder <rdr@emt.iis.fhg.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>More precisely, I would like to do some breakpoint debugging. The only 
>way I know of doing this with multithreaded programs, is to link 
>libpthread statically (and I tried this with gdb).

% gdb some-dynamically-linked-code
gdb> br main
gdb> run ...args...
Breakpoint 1: ....
gdb> br some_function_in_a_dynamically_linked_library
gdb  c

for code loaded by dlopen() and its cousins and wrappers, the
breakpoint needs to be something other than main - use something
called, or a line reached after the dlopen() call has happened.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
