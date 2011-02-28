From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer segfault (1.0.24+)
Date: Mon, 28 Feb 2011 23:00:53 +0100
Message-ID: <20110228220053.GB15327@ltw.loris.tv>
References: <4D69A0FC.60400@localhost> <20110227111708.GK15327@ltw.loris.tv>
	<4D6AA448.7050401@localhost> <4D6AE436.6000201@localhost>
	<4D6BCB59.30709@drcomp.erfurt.thur.de>
	<AANLkTikr=sBcis_2V=qm9jgWha3P6QR2-xiY9WpXw+vH@mail.gmail.com>
	<4D6C11F4.6000408@drcomp.erfurt.thur.de>
	<AANLkTik8uJT885D0yQd4mbs_ytxYrq2wp6=5hsFvN1V3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C7DD243D5
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 23:01:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTik8uJT885D0yQd4mbs_ytxYrq2wp6=5hsFvN1V3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Craig Bourne <craigbourne@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 28, 2011 at 04:35:36PM -0500, Craig Bourne wrote:

Hi!

> S/PDIF], this is all very reassuring. I will carry on with the testing on
> Wednesday and report back my results.

For all who care, foremost probably Fernando:

   $ git clone http://cluster.inf-ra.uni-jena.de/~adi/alsa-tools.git
   $ git checkout adi-fixes

(or simply pull this branch into your local alsa-tools git repo).

I've reworked the code in question. At least the label thing should be
fine now, but let's wait for Craig to confirm it.

Unfortunately, I won't be around on Wednesday. Maybe Fernando will
prepare another test package, if not, compiling from source isn't that
hard:

After these two git commands, go into hdspmixer an run ./gitcompile.
Then, if everythings builds correctly, run ./src/hdspmixer so see if
it's working.


Note that the git repo above might disappear once we have fixed all
remaining issues, so if you read this mail in a couple of months from
now, don't expect the URL to be still functional. ;)



Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
