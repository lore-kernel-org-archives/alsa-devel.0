From: Juan Linietsky <coding@reduz.com.ar>
Subject: ALSAseq and timing.
Date: Sun, 11 Aug 2002 20:14:26 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020811201426.5f7306cb.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA24449
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2002 01:14:48 +0200
Received: from server (OL110-150.fibertel.com.ar [24.232.150.110])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id TAA14023
	for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2002 19:14:24 -0400
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

Hi, i'm trying to implement a proper timing control in a sequencer
client implementation,
but i have a question not covered in the documentation. Basically,
does alsalib or alsa
do any kind of timing conversion or something at the time of the event
arrival?
what i mean is, basically my seq client app (a softsynth) has to to
take care of _all_ kind of timings?
(direct/timestamp absolute and relative/tick), or does alsa proovide
some method (for timing conversion or something) so i can easily parse
those? This is basically so i can process audio in large blocks and
sync properly with the audio being played, even if there is a certain
latency. I checked out
some existing apps (timidity and iiwusynth) and none seem to bother
about checking the time of
the event, so they'll screwup when using bigger audio buffersizes. 
Has this been ever implemented? 

Thanks!

Juan Linietsky




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
