From: Paul Davis <pbd@op.net>
Subject: Re: Where could I find devices number for each card ?
Date: Sun, 14 Apr 2002 18:25:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204142224.AAA06415@alsa.alsa-project.org>
References: <20020414182324.A917@pengouin.univ-valenciennes.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA06415
	for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2002 00:24:21 +0200
In-Reply-To: Your message of "Sun, 14 Apr 2002 18:23:24 +0200."
             <20020414182324.A917@pengouin.univ-valenciennes.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Charles Fl che <charles.fleche@meletu.univ-valenciennes.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Just a simple question : in the rawmidi functions, I have to know the 
>card and the device number... OK ! But where could I find this number ? 
>I'm using alsa 0.5 serie, and so I have no asound.conf (or equivalent). 
           ^^^^^^^^

	   thats your first problem. 0.5.X is not unsupported at this
	   point, but nobody involved in the development or heavy use
	   of ALSA at this time is using 0.5.X. the API and the
	   internal design are dead (and problematic). upgrade and
	   save yourself more hassle.

	   or follow tim's (and my) advice and use open/read/write/close
	   with /dev/snd/midiCcDd where c and d typically small
	   integers starting at 0.

--p
