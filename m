From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Repeatable exact I/O-delay
Date: Sat, 27 Jul 2002 17:59:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020727155858.F15468D1@mail.it4u.net>
References: <Pine.LNX.4.21.0207271704220.666-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA12974
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 17:59:31 +0200
In-Reply-To: <Pine.LNX.4.21.0207271704220.666-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 27 July 2002 17.18, you wrote:
> Anders Torger wrote:
> >Does anyone have any comments on this? Is repeatable exact I/O-delay
> >possible to achieve today with current hardware (and ALSA)?
>
> It is the normal mode of operation for memory-mapped IO.

Is it really? How do I trigger play exactly X samples after I trigger 
capture? To copy samples exactly X samples into a buffer is simple, the 
problem is to tell the sound card to synchronise the playback ptr with 
the capture ptr, that is "start running the playback ptr exactly X 
samples after the capture ptr started". The window of X samples is then 
used by the software to do its magic.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
