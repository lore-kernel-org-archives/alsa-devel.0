From: Paul Davis <pbd@op.net>
Subject: Re: Why do I get broken pipe on write to a pcm in statePREPARED?
Date: Tue, 17 Sep 2002 09:03:25 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rHyz-0000fo-00@usw-sf-list1.sourceforge.net>
References: <Pine.HPX.4.33n.0209171012400.10979-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 17 Sep 2002 11:05:44 +0200."
             <Pine.HPX.4.33n.0209171012400.10979-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Anders Torger <torger@ludd.luth.se>, Abramo Bagnara <abramo.bagnara@libero.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>IMHO the current behaviour is the proper behaviour as implemented by other
>file descriptors, and as mandated by POSIX.
>
><http://www.opengroup.org/onlinepubs/007904975/functions/write.html>
>says regarding pipes, FIFOs and sockets:
>| The write() function shall fail if:

the discussion here is about the behaviour of poll(2), not
write(2). as i read it, nobody has any problems with ALSA's write
implementation. 

--p


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
