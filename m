From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 13:14:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19LQuD-0008Kt-00@sc8-sf-list1.sourceforge.net>
References: <3ED63954.2070603@klingt.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 29 May 2003 18:46:12 +0200."
             <3ED63954.2070603@klingt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: d <dieb13@klingt.org>
Cc: Kai Vehmanen <kai.vehmanen@wakkanet.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>sorry for all the noise on the list.
>i am running a singleprocessor system, but forgot to turn off the smp 
>support in the kernel config. now - after recompiling everything- the 
>kernel doesn't panic any more when i adjust the output-levels, but i 
>still get nothing but silence from my card.

oh dear. now i realize that i didn't read your subject line carefully
enough. 

the hdsp 9652 driver has one major issue at this time. i have been in
lots of contact with RME to get the problem resolved, but they have
not followed through on the most recent requests. the driver is not
setting the card up so that you can hear anything, even though it does
actually run quite normally. nobody (myself, thomas or anyone else)
knows what might be wrong, and RME have told me that in theory nothing
is necessary to make this work: by default, the hdsp9652 works just
like the old hammerfall (i.e. playback stream N is routed at unity
gain to output stream N). so, we are basically waiting for RME to
respond in some way. it will probably turn out to be a one or two line
change. i wish i could tell you when it will happen, but that would be
dishonest.

--p


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
