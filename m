From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: HG -> GIT migration
Date: Fri, 23 May 2008 12:31:08 +1000
Message-ID: <1211509868.3811.119.camel@localhost>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
	<200805221016.27143.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id C674B244B5
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 04:31:12 +0200 (CEST)
In-Reply-To: <200805221016.27143.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I get the same problem as Eliot. The procedure 
$ git clone git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror
$ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver  
$ cd alsa-driver
$ ./gitcompile

results in

No alsa-kernel is found.
Please specify the correct location via ALSAKERNELDIR environment variable.

The problem is masked once alsa-driver/alsa-kernel exists, 
which can be arranged by running once

$ ALSAKERNELDIR=../alsa-kmirror ./gitcompile

I haven't found how this creates the link though.

The Makefile references ../alsa-kmirror by default, 
but the gitcompile (and probably other stuff too) needs to be updated to agree. 

This solves one of the problems mentioned in my other post. Now that I
know how to get around this, I'll try it on the RH kernel.

Ben Stanley.


On Thu, 2008-05-22 at 10:16 +1200, Eliot Blennerhassett wrote:
> On Wednesday 21 May 2008 18:09:17 you wrote:
> > It's not required to set ALSAKERNELDIR to ../alsa-kmirror - it's default
> > now.
> 
> Without it I get this:
> 
> cd alsa-driver/
> eliot@zaphod:~/src/alsagit/alsa-driver$ ./gitcompile
> No alsa-kernel is found.
> Please specify the correct location via ALSAKERNELDIR environment variable.
> 
> 
> Looking at gitcompile script it doesn't mention alsa-kmirror
> 
> Meanwhile I will avoid the error by specifying the cards I'm interested in.
> 
> --
> Eliot
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
