From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: alsa on Atmel at91
Date: Fri, 11 May 2007 08:12:21 -0400
Message-ID: <f21mj5$mt7$1@sea.gmane.org>
References: <c88e466f0704151238q326df219uf95679897f4c44@mail.gmail.com>	<c88e466f0704180218p708ba602h766f6a3f36c1add0@mail.gmail.com>	<1176889951.32188.246.camel@a10072.wolfsonmicro.main>	<c88e466f0704180500l2f016c4bs28c6a3c1a3663575@mail.gmail.com>	<1176900272.32188.274.camel@a10072.wolfsonmicro.main>	<c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>	<c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>	<c88e466f0705100644q50f89fbfr3499a4491d741f2b@mail.gmail.com>	<c88e466f0705100716j44711fdnaa6f83e2f27afa3d@mail.gmail.com>	<c88e466f0705110013n72325746w3698f4627cbbea6e@mail.gmail.com>
	<c88e466f0705110207k3129fa46ye1f618800024265@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 612F2244A0
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 14:12:43 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HmTz2-0005lM-M9
	for alsa-devel@alsa-project.org; Fri, 11 May 2007 14:12:28 +0200
Received: from bas17-toronto12-1096795800.dsl.bell.ca ([65.95.198.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 14:12:28 +0200
Received: from fmandarino by bas17-toronto12-1096795800.dsl.bell.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 14:12:28 +0200
In-Reply-To: <c88e466f0705110207k3129fa46ye1f618800024265@mail.gmail.com>
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

Michel Benoit wrote:
> For anyone who has been following this thread, setting the configure
> option "with-versioned=no" for alsa-lib solves the problem.
> 
> I still don't understand why the wrong version of the symbols was
> being used but that is irrelevant on our embedded system.

Michel,

It works!  Well done.  Until now I have had to statically link aplay to
get it to work.  Linking dynamically saves me 1.5MB of precious NAND
filesystem space.

Thanks for your determined effort for solve this.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
