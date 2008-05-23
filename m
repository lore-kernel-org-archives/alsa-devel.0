From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG -> GIT migration
Date: Fri, 23 May 2008 08:38:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805230837400.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<200805211430.06653.linux@audioscience.com>
	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>
	<200805221016.27143.linux@audioscience.com>
	<1211509868.3811.119.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 445F4245BD
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 08:39:00 +0200 (CEST)
In-Reply-To: <1211509868.3811.119.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Stanley <Ben.Stanley@exemail.com.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 23 May 2008, Ben Stanley wrote:

> I get the same problem as Eliot. The procedure 
> $ git clone git://git.alsa-project.org/alsa-kmirror.git alsa-kmirror
> $ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver  
> $ cd alsa-driver
> $ ./gitcompile
> 
> results in
> 
> No alsa-kernel is found.
> Please specify the correct location via ALSAKERNELDIR environment variable.

Oops. I forgot to modify gitcompile script, too. I only modified Makefile. 
It's fixed now. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
