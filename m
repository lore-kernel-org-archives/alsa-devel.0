From: Juan Linietsky <coding@reduz.com.ar>
Subject: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 05:57:40 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020818055740.2af8e3e7.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA29799
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 10:56:40 +0200
Received: from server (OL110-150.fibertel.com.ar [24.232.150.110])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id EAA23635
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 04:56:29 -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi! I wanted to ask, how about forcing
an absolute timestamp for _every_ midi event?
I think this would be great for softsynths,
so they dont need to work with root/schedfifo/lowlatency
to have a decent timing. Not allways you are willing
to process midi at the lowest latency possible.
I say because you dont really need all that if you
sequence in the computer and control softsynths and maybe
some external device. 
This way, the softsynth gets the event with the timestamp,
gets the current time, substracts the audio delay (latency) to that
and just mixes internally in smaller blocks processing each 
event in the right time.


Juan Linietsky








-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
