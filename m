From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Crack sounds in playback
Date: Fri, 5 Aug 2005 14:20:25 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508051415230.3253-100000@studcom.urz.uni-halle.de>
References: <20050805110553.GB32027@brailcom.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA1EB215
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 14:20:26 +0200 (MEST)
In-Reply-To: <20050805110553.GB32027@brailcom.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hynek Hanke <hanke@brailcom.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hynek Hanke wrote:
> after all the suggestions (thanks for them), I got the alsa playback working
> with the non-blocking/polling approach. I'm checking for xrun and suspend
> states in the poll loop and after I send all the samples, I set avail_min to
> the whole buffer and poll() until the states gets to XRUN.

Underruns will interrupt the playback.  You should set avail_min to
the period size so that you can fill up the buffer before playback
gets stopped.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
