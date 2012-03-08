From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Thu, 08 Mar 2012 15:14:50 +0000
Message-ID: <1331219690.30002.13.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
	<1329512682.29051.1.camel@jonspc> <1329570128.6670.0.camel@jonspc>
	<4F400BBF.9020707@ladisch.de> <1329603022.1089.57.camel@jonspc>
	<4F41FC28.1070605@ladisch.de> <1329926198.22918.10.camel@jonspc>
	<4F45167A.6080706@ladisch.de> <1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de> <1331214439.27232.12.camel@jonspc>
	<4F58C394.3020200@ladisch.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C53D103A11
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 16:14:52 +0100 (CET)
In-Reply-To: <4F58C394.3020200@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-03-08 at 15:35 +0100, Clemens Ladisch wrote:
> Jonathan Andrews wrote:
> > Getting closer, alsalib now builds without the need for pthreads but
> > seems to insist on dlopen dlclose even in static lib ?
> 
> Add --without-libdl.
> 

Ok, that fixed it thanks.

A couple of comments. 

1) A lot of my trouble was this :
configure.in:15: error: Autoconf version 2.62 or higher is required

If autoconf exists, is executed,  but does not complete should configure
not exit with an error ?

I checked the output of the configure/make carefully. Autoconf was
silently failing, gives no clues at all. As the datetime is in the
binary created each library had a unique file hash so I (reasonably)
assumed it to be doing the job :-(

2)  "Add --without-libdl", 
   ok ... should "--static" not turn this on then ?


Thanks,
Jon
