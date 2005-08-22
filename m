From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Audiophile USB
Date: Mon, 22 Aug 2005 18:04:45 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508221801100.10838-100000@studcom.urz.uni-halle.de>
References: <4309F0FC.9090209@liris.cnrs.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95AF5217
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 18:04:46 +0200 (MEST)
In-Reply-To: <4309F0FC.9090209@liris.cnrs.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pierre-Antoine Champin <pierre-antoine.champin@liris.cnrs.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Antoine Champin wrote:
> I bought an M-Audio Audiophile USB external sound interface, but I have
> some problems to make it work properly: when recording audio, the signal
> I get is completely saturated.
> [...]
> So I guess that the card has uses format S24_3BE for output, but *not*
> for input; it uses instead some hybrid format, for which the conversion
> to low endian would be:
>     a,b,c -> b,a,c

The driver currently assumes that both playback and capture use
big-endian samples.  I haven't heard any complaints since this was
implemented 21 months ago.

Does it work if you use plughw:3 and .wav files?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
