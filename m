From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: alsa on Atmel at91
Date: Mon, 11 Jun 2007 09:58:26 +0000 (UTC)
Message-ID: <loom.20070611T115541-119@post.gmane.org>
References: <c88e466f0704151238q326df219uf95679897f4c44@mail.gmail.com>
	<c88e466f0704180218p708ba602h766f6a3f36c1add0@mail.gmail.com>
	<1176889951.32188.246.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180500l2f016c4bs28c6a3c1a3663575@mail.gmail.com>
	<1176900272.32188.274.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>
	<c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>
	<c88e466f0705100644q50f89fbfr3499a4491d741f2b@mail.gmail.com>
	<c88e466f0705100716j44711fdnaa6f83e2f27afa3d@mail.gmail.com>
	<c88e466f0705110013n72325746w3698f4627cbbea6e@mail.gmail.com>
	<c88e466f0705110207k3129fa46ye1f618800024265@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BAD6243D2
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 12:00:17 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxggS-0006Op-6C
	for alsa-devel@alsa-project.org; Mon, 11 Jun 2007 11:59:36 +0200
Received: from 88-136-166-18.adslgp.cegetel.net ([88.136.166.18])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 11:59:36 +0200
Received: from matthieu.castet by 88-136-166-18.adslgp.cegetel.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2007 11:59:36 +0200
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

Hi,

Michel Benoit <murpme <at> gmail.com> writes:

> 
> For anyone who has been following this thread, setting the configure
> option "with-versioned=no" for alsa-lib solves the problem.
> 
> I still don't understand why the wrong version of the symbols was
> being used but that is irrelevant on our embedded system.
> 

I hit the same problem (arm EABI platform), and "with-versioned=no" solve it.

Is there plan to investigate on this


Matthieu
