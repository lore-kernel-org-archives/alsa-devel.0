From: Paul Davis <pbd@op.net>
Subject: Re: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 09:58:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E177cnG-0003WZ-00@usw-sf-list1.sourceforge.net>
References: <000601c1fb4b$7cd77ae0$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Tue, 14 May 2002 09:30:17 EDT."
             <000601c1fb4b$7cd77ae0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Thank you for your prompt reply!
>
>However, this is the first time ever I tried using the CVS, so I had no
>files hanging around prior to this downloading. I am also pretty sure
>that I downloaded the stuff with -P flag (I did it as instructions on
>the alsa-project page have stated it, including the -P flag). On top of
>that I even tried updating the whole CVS tree just to see if that will
>fix it.
>
>So, I am not sure why it is even referencing the file in the first place
>if none of the other files are supposed to mention it.
>
>Should I uninstall every trace of Alsa from my cpu before trying to use
>CVS?

No, thats not the issue. It might be a CVS sync issue at sf.net, as
well. The "anonymous" CVS repository is sometimes 6hrs behind the
"login" CVS repository.

rme9652_mem.c is now in the "Attic" meaning that it was removed from
CVS:

pbd[987]>cvs -z3 status rme9652_mem.c
===================================================================
File: no file rme9652_mem.c             Status: Up-to-date

   Working revision:    No entry for rme9652_mem.c
   Repository revision: 1.8     /cvsroot/alsa/alsa-kernel/pci/rme9652/Attic/rme9652_mem.c,v
pbd[988]>

This means that if you checkout ALSA, you should not get this file. I
would suggest that try 
      
 cvs -z3 update -dP

again, and see if that removes the file.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
