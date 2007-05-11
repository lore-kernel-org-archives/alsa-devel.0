From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: alsa on Atmel at91
Date: Fri, 11 May 2007 11:07:08 +0200
Message-ID: <c88e466f0705110207k3129fa46ye1f618800024265@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 03886243AF
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 11:07:09 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so871476nzf
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 02:07:08 -0700 (PDT)
In-Reply-To: <c88e466f0705110013n72325746w3698f4627cbbea6e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

For anyone who has been following this thread, setting the configure
option "with-versioned=no" for alsa-lib solves the problem.

I still don't understand why the wrong version of the symbols was
being used but that is irrelevant on our embedded system.
