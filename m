From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Sun, 17 Jun 2007 20:49:33 -0400
Message-ID: <75b66ecd0706171749x1c29b4b2u8978ac68888960d@mail.gmail.com>
References: <dfd4051f0706161836xa191176ke10deff2868ad8d6@mail.gmail.com>
	<200706171149.27547.rjw@sisk.pl>
	<dfd4051f0706171355i7bc3d4b7qe9aee2acb904c8c@mail.gmail.com>
	<dfd4051f0706171735s72033440sf4d1dc83046e0e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 4010B24431
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 02:49:35 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2044573wag
	for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2007 17:49:34 -0700 (PDT)
In-Reply-To: <dfd4051f0706171735s72033440sf4d1dc83046e0e05@mail.gmail.com>
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
To: Matt Mullins <mokomull@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/17/07, Matt Mullins <mokomull@gmail.com> wrote:
> > I've been reading up on the Intel HD Audio specifications, and I found
> > that the problem is most likely that the driver has to resort to PI/O
> > (single_cmd) mode.  I really haven't had enough time or experience to
> > figure out what is actually causing this.  This is the first time I've
> > done any kernel development; thankfully, Intel has good documentation.
> >  I'm going to keep hacking to see what information I can figure out.
> >
> > I just tried 2.6.22-rc5, and no behavior has changed.

Please retest with latest ALSA Hg sources.  You will first have to
rebuild the kernel with modular ALSA.

Lee
