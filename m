From: Andy Wingo <wingo@pobox.com>
Subject: Re: What is the current status of the alsa sound server (signal polling)?
Date: Fri, 19 Apr 2002 21:00:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020420010011.GT5353@jesus>
References: <200204191659.g3JGxPT15571@post2.fast.net> <000101c1e7ef$c91178d0$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from jesus (rdu162-226-026.nc.rr.com [24.162.226.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA15288
	for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2002 03:01:31 +0200
Content-Disposition: inline
In-Reply-To: <000101c1e7ef$c91178d0$ac1f830a@ico>
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

On Fri, 19 Apr 2002, Ivica Bukvic wrote:

> Hmmm, but it seems that on their website docs they mention that you can
> use oss-sink and other audio routing in order to provide audio routing,
> so I was wondering if I could use that for my purposes...
> 
> Ico
> 
> > From: Paul Davis [mailto:pbd@op.net]
> >
> > >Also, what is the current status of gstreamer in this department and
> > 
> > gstreamer has nothing to do with this. gstreamer is an internal
> > architecture/framework for a single application and has nothing to do
> > with sharing audio interfaces or audio data with other processes.
> > 

As a GStreamer developer, I'd like to say that Paul is right on this
one. GStreamer can be used for architecture internal to an app, not for
app communication or resource sharing. That has to be provided at the
hardware or alsa-lib level.

regards,

wingo.

ps. any further questions into gstreamer et al are welcome on
gstreamer-devel at lists.sourceforge.net or on our irc channel, but it's
probably not terribly interesting wrt the topic of this list...
