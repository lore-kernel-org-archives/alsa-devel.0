From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: future ALSA development
Date: Mon, 23 Jun 2003 09:41:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306231335.PAA10806@alsa.alsa-project.org>
References: <s5hof0p2azh.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail08.voicenet.com (mail08.voicenet.com [207.103.0.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA10806
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 15:35:08 +0200
In-reply-to: Your message of "Mon, 23 Jun 2003 15:13:06 +0200."
             <s5hof0p2azh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>my afraid is that the more control flows like conditionals may lead to
>a difficulty for a parser utility.  i.e. the parser itself would be
>like an interprerter.  but it's true that an extesion is needed
>anyway...

with a smile, i seem to recall noting that we'd end up with
lisp. quasimodo had gone through the same song and dance with a custom
configuration parser only to eventually find that guile made more
sense in almost every way. there is some adage about reinventing lisp
that i forget.

>IMO, the current simple-mixer API is still too complicated and not a
>good abstraction.  as you mentioned, there is a big gap between the
>low-level expressions (control API) and the reasonable mixer
>appearance.  the extra information for the mixer would be needed to
>fill this gap, too.

i'd like to put in a plug for a API that includes the one basic 
operation that JACK cannot implement on "generic" hardware:

	  "make the signal coming to the current capture input
	   appear at the output".

i.e. hardware monitoring. this is a really major flaw in JACK when run
on all consumer audio interfaces: they are quite capable of doing 
analog-level h/w monitoring, but JACK can't use it.

i know that the semantics need to be better defined than in my
sentence above.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
