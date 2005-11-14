From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Mon, 14 Nov 2005 12:17:01 +0000
Message-ID: <20051114121701.GA4044@localhost.localdomain>
References: <E1EbIYV-00019A-4u@localhost.localdomain> <20051113223105.GA4822@localhost.localdomain> <1131923292.27215.1.camel@mindpipe> <20051114003718.GA5041@localhost.localdomain> <1131960635.27215.16.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1131960635.27215.16.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2005 at 04:30:34AM -0500, Lee Revell wrote:
> On Mon, 2005-11-14 at 00:37 +0000, John Rigg wrote:
> > Is there another way, eg. a way to start multi_playback and
> > multi_capture devices with a single jackd command?
> 
> Yes, for example:
> 
> jackd -d alsa -C hw:0,2 -P hw:0,3

I tried the following:

jackd -d alsa -C multi_capture -P multi_playback -p 128

This gives the same poll time out. I tried different values of -p
but it just changes the length of the time out.

Starting capture-only using the following works:
jackd -d alsa -C multi_capture -p 128
Likewise for playback:
jackd -d alsa -C multi_playback -p 128

John


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
