From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 16:02:15 +0000
Message-ID: <20081205160215.GA3295@localhost>
References: <227999.32830.qm@web65402.mail.ac4.yahoo.com>
	<737104.16616.qm@web65414.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 01515103805
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:49:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <737104.16616.qm@web65414.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pete <peterpion@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 07:23:00AM -0800, Pete wrote:
> Is there likely to be any disadvantage to running arecord rather
> than say Jack to capture? Does (say) Jack read the card in a 'better' 
> way?

jackd runs with realtime priority if -R option is specified
when starting it. Running it without -R produces xruns fairly 
often, but with -R they almost never happen on a properly configured
system. I don't know if arecord can run with realtime priority.

John
