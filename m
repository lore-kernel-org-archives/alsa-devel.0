From: Paul Davis <pbd@op.net>
Subject: Re: usb-audio: variable periodsize / nframes per callback can shorten latency times
Date: Tue, 27 Aug 2002 10:19:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208271418.QAA17300@alsa.alsa-project.org>
References: <Pine.LNX.4.21.0208201214450.682-100000@summer.quitte>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA17300
	for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2002 16:18:07 +0200
In-Reply-To: Your message of "Tue, 20 Aug 2002 12:30:11 +0200."
             <Pine.LNX.4.21.0208201214450.682-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>hmm, it's not so easy, since this will break also the assumption of
>>constant period "frames" by applications.  if we introduce the
>>time-based period size, it won't work as compatible as older one,
>>e.g. jack wouldn't run properly if the period size changes
>>dynamically.

this isn't true, or if it is true, it can be fixed fairly easily. what
you might mean is that some JACK clients won't run well under such
circumstances, but the JACK alsa driver/client is written to "present"
uniform "period" sizes to JACK. the fact that the ALSA driver itself
doesn't do this won't affect JACK - we will instead still break up the
"stream" into uniform-sized chunks. 

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
