From: Paul Davis <pbd@op.net>
Subject: Re: how to define a 2-index control element?
Date: Tue, 07 May 2002 20:00:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205080000.CAA29681@alsa.alsa-project.org>
References: <3CD84FDC.1056ACA1@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA29681
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 02:00:07 +0200
In-Reply-To: Your message of "Wed, 08 May 2002 00:06:20 +0200."
             <3CD84FDC.1056ACA1@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>We have well designed control keys (id) and I don't see any reason to
>change something that's perfectly suitable (without any compromise) for
>the job.

the implementation is not well designed for cases of 1500
controls. perhaps, as jaroslav says, this could be improved. but even
if that is done, the API forces the user application to do some
special encoding to generate the index that cannot be inferred from
the description provided by the API. an application that wants to
modify the gain for source S to destination D will have to know how to
encode S and D into the index - it cannot discover this from the API.

thats a lot worse than just a compromise if you ask me.

>We have the sane association one control / one value and just because
>this card has many controls, you seems to wish to go toward a different
>(IMO insane and confusing) solution.

IMHO, the 1:1 association is sane only when there are relatively small
numbers of controls. It doesn't make any sense to me to 

>Consider that independently from how you represent the data this card
>will ever have many controls (i.e. many values to show/change).

this isn't true. if we had a MATRIX element type, applications could
easily say

     "i don't display matrix elements"
     "i don't display matrix elements of dimensionality > 2"
     "i don't display matrix elements when the matrix is larger than N"

and so forth. the problem with the current system is that if anyone
makes the mistake of firing up a generic control API program, they
will see all 1500 controls. i'd like to see you explain that as "sane"
to the user.

>I definitely don't see your point, sorry.

are you claiming that you really designed the control API as it exists
now to handle situations with this many controls?

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
