From: Paul Davis <pbd@op.net>
Subject: Re: Repeatable exact I/O-delay
Date: Sun, 28 Jul 2002 10:58:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207281457.QAA29904@alsa.alsa-project.org>
References: <20020728143945.D582D902@mail.it4u.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA29904
	for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2002 16:57:00 +0200
In-Reply-To: Your message of "Sun, 28 Jul 2002 16:39:50 +0200."
             <20020728143945.D582D902@mail.it4u.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I've looked through some driver code, and if I understand it correctly, 
>it seems like some drivers, for example the ens1370, check in the 
>trigger function the substream is linked with other substreams on the 

yes, sorry, i forgot about this aspect of things. i was thinking of
snd_pcm_link() across multiple cards, which is handled by the
mid-level code.

--p 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
