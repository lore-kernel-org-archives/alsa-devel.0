From: Paul Davis <pbd@op.net>
Subject: Re: Timer?
Date: Wed, 06 Mar 2002 13:13:00 -0500
Message-ID: <200203061816.NAA05351@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA20590
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 19:16:07 +0100
In-reply-to: Your message of "Wed, 06 Mar 2002 18:00:27 GMT."
             <NGBBLNODKDFPBFMBBFAFMEBKCDAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> xine won't work the way a user expects if anyone tried to get it to
>> inter-operate *in sync* with another application.
>>
>There has never been a requirement of a audio/video app like xine to be in
>sync with any other application.
>It just needs to sync it's own audio with it's own video streams.

well, i entirely accept that its never been one of your design goals. 

that doesn't mean that somebody might not want to use it in
combination with other applications. i might want to use its video
capabilities while feeding its audio through an FX box. i might want
to replace its audio i/o stream with something else, just to see how
it felt. i might want to run xine along with several other audio
streams, feeding them through a software mixer for a live multimedia
event. etc.

if you had writtten xine for Mac OS X, xine would do all these (extra)
things without any extra work on your part. as is, we'd have to ask
you to reimplement important parts of it (or do that ourselves) if we
wanted to use it in these ways.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
