From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 13:34:32 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19LRDo-0006qW-00@sc8-sf-list1.sourceforge.net>
References: <3ED641E5.5020108@klingt.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 29 May 2003 19:22:45 +0200."
             <3ED641E5.5020108@klingt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: d <dieb13@klingt.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>inbetween i have been able to
>1) get another kernel panic with the new kernel+drivers

ok, what you do with the trace is to find it in /var/log/messages
after the reboot, cut the several lines of the panic trace into a new
file and feed it to ksymoops. then send that here. it will enable us
to find out where the panic occurs.

>2) sometimes get some noise with a self-written testtone-prog on channel 
>  3 and/or 6 of adat1 (*should* be a sinewave on all 26 channels).
>could it be that the S32_LE noninterleaved is interpreted wrong?
>4) once got jack+ardour to produce noise (*should* have been music), but 
>couldn't repoduce this

that's intriguing. all the reports so far (and my experience, since i
have one of these cards too) is no noise, ever, under any
circumstances. still, it doesn't get us closer.

>seems i'll have to find some other hardware if i want a quick solution

i'm afraid so, yes. i am very sad that this has turned out this way.


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
