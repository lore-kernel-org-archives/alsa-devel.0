From: Matthew Clarke <Matthew_Clarke@mindlink.bc.ca>
Subject: Re: problems compiling current CVS
Date: Mon, 2 Jun 2003 21:38:13 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030603043813.GA30485@ds0.van.maves.ca>
References: <20030603031534.GA27280@ds0.van.maves.ca> <E19N2mg-0008HZ-00@dewey.paralynx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E19N2mg-0008HZ-00@dewey.paralynx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

lundi, le 2 juin, 2003, Paul Davis nous a dit ceci:

> >This bit:  
> >
> >        ${xtmp:0:5}
> >
> >is a Bash-ism.  Normal Bourne shells don't understand this.  I'm guessing
> >that your system's /bin/sh isn't Bash.  You might be able to put a 
> >
> >        SHELL=/bin/bash
> 
> paul[2846]>which sh
> /bin/sh
> paul[2847]>ls -l /bin/sh
> lrwxrwxrwx   1 root     root            4 Aug 16  2000 /bin/sh -> bash
> paul[2852]>bash -version
> GNU bash, version 1.14.7(1)

Looks like I guessed wrong.  The only system I still have access to with
Bash 1.x on it isn't accessible right now, and the newer ones I do have
access to don't say when the ${foo:0:5} syntax was added.

Dunno why it's not working.  You might try bash2, viz.:

------------------------------------------------------------------------------
21:34 [clamat@ds0:~] 168 > /bin/bash -version
GNU bash, version 2.04.0(1)-release (i586-pc-linux-gnu)
Copyright 1999 Free Software Foundation, Inc.
21:35 [clamat@ds0:~] 169 > /bin/bash
bash-2.04$ x=testvalue
bash-2.04$ echo ${x:0:5}
testv
bash-2.04$ exit
21:35 [clamat@ds0:~] 170 > 
------------------------------------------------------------------------------

Matt.
-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
				-- Richard P. Feynman


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
