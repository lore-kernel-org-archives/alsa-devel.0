From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: [Fwd: Why do I get broken pipe on write to a pcm in
 statePREPARED?]
Date: Sat, 05 Oct 2002 09:35:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9E9656.2CB0AA01@libero.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D81C8DFD013FF567163F325A"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------D81C8DFD013FF567163F325A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
--------------D81C8DFD013FF567163F325A
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <pbd@op.net>
Delivered-To: abramo@igor.opun.it
Received: from localhost (localhost [127.0.0.1])
	by igor.opun.it (Postfix) with ESMTP id 7FBB7BC1EE
	for <abramo@localhost>; Sat,  5 Oct 2002 09:30:25 +0200 (CEST)
Received: from pop.libero.it [193.70.192.70]
	by localhost with POP3 (fetchmail-5.9.11)
	for abramo@localhost (single-drop); Sat, 05 Oct 2002 09:30:25 +0200 (CEST)
Received: from smtp6.libero.it (193.70.192.59) by ims5a.libero.it (6.5.028)
        id 3D98769A000FAA05 for abramo.bagnara@libero.it; Fri, 4 Oct 2002 23:14:49 +0200
Message-ID: <3D98769A000FAA05@ims5a.libero.it> (added by postmaster@libero.it)
Received: from newmx2.fast.net (209.92.1.32) by smtp6.libero.it (6.5.028)
        id 3D9774AC00F7C064 for abramo.bagnara@libero.it; Fri, 4 Oct 2002 23:14:49 +0200
Received: (qmail 14601 invoked from network); 4 Oct 2002 21:14:46 -0000
Received: from unknown (HELO someip.ppp.op.net) ([209.92.97.141]) (envelope-sender <pbd@op.net>)
          by newmx2.fast.net (qmail-ldap-1.03) with SMTP
          for <abramo.bagnara@libero.it>; 4 Oct 2002 21:14:46 -0000
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Takashi Iwai <tiwai@suse.de>,
	Anders Torger <torger@ludd.luth.se>, Jaroslav Kysela <perex@suse.cz>,
	Tim Goetze <tim@quitte.de>, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Why do I get broken pipe on write to a pcm in statePREPARED? 
In-reply-to: Your message of "Fri, 04 Oct 2002 20:04:00 +0200."
             <3D9DD810.7C3960C4@libero.it>
Date: Fri, 04 Oct 2002 17:19:42 -0400
From: Paul Davis <pbd@op.net>
X-Spam-Status: No, hits=0.2 required=5.0
	tests=IN_REP_TO,MSG_ID_ADDED_BY_MTA,MSG_ID_ADDED_BY_MTA_2,
	      SPAM_PHRASE_00_01
	version=2.41
X-Spam-Level: 

 
 [ abramo: please forward to alsa-devel@lists.sourceforge.net. thanks. ]

>I'm strongly convinced that to have poll waiting for something that
>cannot happens is a big mistake (also as an optional behaviour).

there are several, perhaps even lots, of other device drivers in the
linux kernel that do this.

>That apart I'm sure that to make a change in actual behaviour between
>rcX and 1.0 is a professional suicide. However it's _your_ professional
>suicide so... ;-)))

not *one* person on alsa-devel has described software that would be
broken by this change. 

given that jaroslav is already changing the API between rcX and rcZ,
this doesn't seem like much of a problem, anyway.

>To resume, if you ask me, the answer is no.

well, he did ask you, but my answer is yes :))

--p

--------------D81C8DFD013FF567163F325A--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
