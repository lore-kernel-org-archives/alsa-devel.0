From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: doom 3 sounds also messed up
Date: Thu, 10 Mar 2005 12:09:47 -0500
Message-ID: <1110474587.12805.23.camel@mindpipe>
References: <1110473123.6829.3.camel@linux.site>
	 <1110473496.12805.9.camel@mindpipe>  <1110474067.6829.9.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110474067.6829.9.camel@linux.site>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: jpshark <jpomanto@satx.rr.com>
Cc: alsa list <alsa-user@lists.sourceforge.net>, alsa-devel@sc8-sf-spam1.sourceforge.net, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-10 at 11:01 -0600, jpshark wrote:
> Lee, I don't know why Gnome is using 44100 if it's suppose to default to
> 48000. It's version 2.6 with SuSE 9.2 on a fresh install (yesterday).
> You said I'll have to use the ALSA plug layer to get 48000. I don't know
> what you mean. Can you explain? Please make it newb friendly. Thanks.

Sorry, though I do use it, I don't know the internals of Gnome well
enough to comment further.  Maybe someone else can help?

Really, the root cause of all these problems with the Audigy LS driver
is that it's almost 100% reverse engineered.  It's impressive that James
got it to work so well.  But apparently people are buying Audigy LS
hardware and expecting it to work as well as a real SBLive or Audigy.
That's just not going to happen until Creative gives us some more docs
(or even better, a driver, but fat chance).  There are some pretty good
reverse engineers on alsa-devel but a reverse engineered driver will
just never work as well as one written with proper docs.

Maybe we should update the soundcard matrix to make it clear that the
Audigy LS is not supported on the same level as the emu10k1/2.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
