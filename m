From: Paul Davis <pbd@op.net>
Subject: Re: question regarding latest CS4205 laptop soundcard driver
Date: Wed, 27 Feb 2002 22:09:11 -0500
Message-ID: <200202280309.WAA14147@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA03931
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2002 04:09:40 +0100
In-reply-to: Your message of "27 Feb 2002 14:11:18 EST."
             <1014837078.10692.18.camel@meowing.memh.uc.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I agree, my "flawless" statement was certainly overrated. Yet, the
>question remains: what am I to do as a musician needing to utilize my
>portable laptop while the apps/software I currently use get ported to
>the JACK architecture (if they get ported at all)? 

1a) Get Abramo to post (or point to) detailed information on using a
   "share" PCM device

1b) Get Abramo or Jaroslav to post (or point to) detailed information
   on setting up libaoss (specifically, how to map /dev/dspN to a specific
   ALSA PCM device)

2) edit your ~/.asoundrc file to define a "share" PCM device

3) run all your legacy (OSS) apps with LD_PRELOAD set to preload libaoss.
      a small wrapper script is useful for this; ALSA may already
      come with one (*)

4) run all your newer (ALSA) apps with an argument telling it to use
     the "share" PCM device

and you should be done. if, that is, the "share" device type is really
working. if not, you can help us debug it.

--p

(*) something like:

% cat aoss
#!/bin/sh

export LD_PRELOAD=/where/i/put/libaoss.so
exec $*
% 

then you can just run OSS apps like this: 

% aoss oss-app-name oss-app-args...

i know this appears hacky. like i said, there is no way around this
because of the way OSS was designed.




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
