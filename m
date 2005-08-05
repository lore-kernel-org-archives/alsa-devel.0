From: Hynek Hanke <hanke@brailcom.org>
Subject: Re: Crack sounds in playback
Date: Fri, 5 Aug 2005 14:29:40 +0200
Message-ID: <20050805122940.GC11890@brailcom.cz>
References: <20050805110553.GB32027@brailcom.cz> <Pine.HPX.4.33n.0508051415230.3253-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out4.iol.cz (smtp-out4.iol.cz [194.228.2.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A9A74216
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 14:33:06 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0508051415230.3253-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2005 at 02:20:25PM +0200, Clemens Ladisch wrote:
> Hynek Hanke wrote:
> > after all the suggestions (thanks for them), I got the alsa playback working
> > with the non-blocking/polling approach. I'm checking for xrun and suspend
> > states in the poll loop and after I send all the samples, I set avail_min to
> > the whole buffer and poll() until the states gets to XRUN. 
> Underruns will interrupt the playback.  You should set avail_min to
> the period size so that you can fill up the buffer before playback
> gets stopped.

I'm sorry, maybe I didn't explain myself clearly. I set avail_min to this state
and expect to get XRUN only *after* I've sent all the samples to the buffer.
So only at the very end, I get an XRUN and thus I know the playback terminated.
>From the logs, I'm sure there are no XRUNs reported *during* the playback.

With Regards,
Hynek Hanke


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
