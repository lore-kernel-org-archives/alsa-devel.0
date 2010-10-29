From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Retrieving original timestamps in dsnoop.
Date: Fri, 29 Oct 2010 17:41:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010291710060.29422@eeebox2.perex-int.cz>
References: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D78@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1216D244A5
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 17:41:50 +0200 (CEST)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BEFE4D78@xmail3.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pontus Oldberg <pontus.oldberg@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010, Pontus Oldberg wrote:

> Hello, I am working in a gstreamer based project where we are using 
> alsasrc to feed the audio pipeline. On of the things that we need to be 
> able to do is to get the monotonic timestamp from the alsalib in order 
> for our video and audio to be perfectly synchronized. This worked fine 
> until we introduced the dsnoop plug-in which creates its own timestamp 
> reference. I have played around with the dsnoop plugin and created a 
> preliminary fix that gives us the result that we want.
>
> I'd like to know if this looks like the way to go or if this can be 
> obtained in any other way. We are using dsnoop in order to be able to 
> create two separate audio pipelines, we don't care about stereo, just 
> simple mono streams.

Your version is a bit tricky. Could you try my version at:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=13b5d972d2e7a5f0e6f3c066684dbb01fafd5121

 					Thank you,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
