From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Sat, 18 Feb 2012 13:02:08 +0000
Message-ID: <1329570128.6670.0.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc> <1329512682.29051.1.camel@jonspc>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0A124157
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 14:01:54 +0100 (CET)
Received: from [10.10.10.6] (jonspc [10.10.10.6])
	by mail.jonshouse.co.uk (8.14.1/8.13.8) with ESMTP id q1ID28gI009856
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 13:02:13 GMT
In-Reply-To: <1329512682.29051.1.camel@jonspc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-17 at 21:04 +0000, Jonathan Andrews wrote:
> Reposting this:
> 
> # strace -p 443
> > Process 443 attached - interrupt to quit
> > futex(0x4030e144, FUTEX_WAIT_PRIVATE, 2, NULL
> > 
> locks up.  Stops, stalls ... fails to continue ....
> 
> 
> Now tried several alsa-lib versions.  A clue would be nice?
> What do I replace to fix this ?
> 
Now tried 2 kernels, 3 versions of alsalib still stalls.

If I remove alsa code it works forever.

Thanks to everyone who helped (no one at all).

FUCK OPEN SOURCE !!!!!!!!!!!
