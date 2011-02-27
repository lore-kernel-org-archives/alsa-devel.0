From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Sun, 27 Feb 2011 12:17:08 +0100
Message-ID: <20110227111708.GK15327@ltw.loris.tv>
References: <4D69A0FC.60400@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AEE1244D7
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2011 12:17:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D69A0FC.60400@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 26, 2011 at 04:55:24PM -0800, Fernando Lopez-Lezcano wrote:

> Hi, I'm getting a segfault from hdspmixer using the current git 
> alsa-tools (1.0.23 works, 1.0.24+ does not). See below for a backtrace. 
> I'm running 2.6.33.x rt30, could this be the problem? (a dependency on 
> newer kernels?)

I have fixed this bug a couple of days ago:

   http://thread.gmane.org/gmane.linux.alsa.devel/82452

They still need to be applied to the alsa-tools.git, but if you like,
you can grab the patches and verify they work for you.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
