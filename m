From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Use only a few bds.
Date: Thu, 22 Aug 2002 08:45:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208220844200.702-100000@pnote.perex-int.cz>
References: <3D646C59.22B1BBBB@multitech.co.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA11997
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 08:45:31 +0200
In-Reply-To: <3D646C59.22B1BBBB@multitech.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Shaju Abraham <shaju@multitech.co.in>
Cc: Alsa-Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Aug 2002, Shaju Abraham wrote:

> Hi all,
> 
>     In our study that we are doing abt latency of sound cards, we want
> to have a situation where I do not want to use all of the 32 bds
> available. we want to use say only 4 or 8 of the bds with each bd
> pointing to only a small fragment of data.( This is basically to make
> the card interrupt frequently and will also should not be able to
> proceed if the interrupts raised by the past bds have not been serviced.
> So want to restrict it to 4 or 8 ) .
> 
> It will be of great help if you can help us on the following two points.
> 
>             i)  What is the significance of ICH_MAX_FRAGS?  ( It seems
> to be used only for the allocation of pages for the buffer and for
> little else during the actual functioning of the card.)
> 
>             ii)    What is the significance of ICH_REG_LVI_MASK?  (This
> is more used during the actual functioning of the card & is used in the
> interrupt service sub-routine to update the lvi.)  It is by default 0x1f
> . Is this 'cos it can be used to address the 32 bds available.  I
> changed this to 3 and 7 . I observed that this makes the card to use
> only 4 or 8 of the bds available. Am I correct in this conclusion?  If I
> do this, I get some noise. Is this because of the interrupts raised by
> the unused bds?
> 
>     If I am wrong abt all this, how should I go abt my idea of using
> only 4 or 8 of the bds available?

I'm rewriting the intel8x0 driver to use scatter-gather DMA access and 
adding support for I845. So these question will be obsolete after a few days.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
