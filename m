From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Sun, 27 Feb 2011 11:21:44 -0800
Message-ID: <4D6AA448.7050401@localhost>
References: <4D69A0FC.60400@localhost> <20110227111708.GK15327@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp4.Stanford.EDU [171.67.219.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 029C51037EE
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2011 20:21:53 +0100 (CET)
In-Reply-To: <20110227111708.GK15327@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/27/2011 03:17 AM, Adrian Knoth wrote:
> On Sat, Feb 26, 2011 at 04:55:24PM -0800, Fernando Lopez-Lezcano wrote:
>
>> Hi, I'm getting a segfault from hdspmixer using the current git
>> alsa-tools (1.0.23 works, 1.0.24+ does not). See below for a backtrace.
>> I'm running 2.6.33.x rt30, could this be the problem? (a dependency on
>> newer kernels?)
>
> I have fixed this bug a couple of days ago:
>
>     http://thread.gmane.org/gmane.linux.alsa.devel/82452
>
> They still need to be applied to the alsa-tools.git, but if you like,
> you can grab the patches and verify they work for you.

They do work in a first (remote) test. Thanks very much!!
-- Fernando
