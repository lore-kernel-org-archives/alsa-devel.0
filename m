From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Semantics of a single period per buffer?
Date: Sun, 25 Nov 2007 21:09:26 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711252107060.7688@tm8103.perex-int.cz>
References: <1196020698.3609.20.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 126A824604
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 21:09:27 +0100 (CET)
In-Reply-To: <1196020698.3609.20.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Dillow <dave@thedillows.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Nov 2007, Dave Dillow wrote:

> While refining the sis7019 for submission, I found a possible issue with
> having a single period per buffer. The easy way out is to set the
> minimum number of periods to 2, but I see other drivers allow a single
> period. This leads to a question about the semantics of a single period
> that I've not been able to resolve using Google.
> 
> Any one have any thoughts or pointers to a discussion on having a single
> period per buffer? Should it be a one-shot play, or just let it hit XRUN
> every time? Other ideas?

I think, one period buffer can be only useable when XRUN check is disabled 
(endless ring buffer playing) and application has own timing and polls for 
the actual position in the ring buffer.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
