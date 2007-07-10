From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Tue, 10 Jul 2007 16:18:19 -0500
Message-ID: <61c0054e0707101418h461afc13sdc9ec6e9d37a8d07@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<75b66ecd0707031137i4c302270oa307df11e0a6ad3@mail.gmail.com>
	<61c0054e0707031151n6d90fc97v4493f41c1ab0cd1@mail.gmail.com>
	<61c0054e0707031206i1717e36dy8e69c872b4f33a@mail.gmail.com>
	<61c0054e0707031240y6d60fed3yea2317b8ad888110@mail.gmail.com>
	<75b66ecd0707031247h842da9j97bce3f85cda33b1@mail.gmail.com>
	<61c0054e0707031414r7565c10ax3edab20bd78d4d4c@mail.gmail.com>
	<61c0054e0707051142h46cd5beer29d91e8b6fd4560c@mail.gmail.com>
	<61c0054e0707101219i5e414590r598b45767e7b462d@mail.gmail.com>
	<20070710155712.18ee1c94.AlsaUser@PragmaSoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C9381038D4
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 23:18:21 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1266355mue
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 14:18:20 -0700 (PDT)
In-Reply-To: <20070710155712.18ee1c94.AlsaUser@PragmaSoft.com>
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
To: "J. Scott Merritt" <AlsaUser@pragmasoft.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/10/07, J. Scott Merritt <AlsaUser@pragmasoft.com> wrote:
>
> On Tue, 10 Jul 2007 14:19:32 -0500
> "Paul Kavan" <pkavan@gmail.com> wrote:
> >
> > Hello all:
> >
> > I have worked on getting some things cleaned up in my kernel and rfs to
> > ensure I was not running out of ramdisk space on my arm development
> board. I
> > am confident that part is okay now, but still getting a segmentation
> fault
> > when I try to run my application. Using gdb, I still get:
> >
> > --snip--
> > /usr/sbin $ gdb grh_audio
> >
> >
> > dlopen failed on 'libthread_db.so.1' - File not found
> > GDB will not be able to debug pthreads.
> >
> > --snip--
> >
> > Not sure what the problem is. I have the alsa libs configured as they
> are
> > supposed to. I assume that the problem has to do with the alsa-libs, but
> I
> > have been successful in getting aplay to work.
> >
> > Any suggestions?
>
> Actually, I would guess that the problem is more likely related to GDB,
> and more specifically that it can't find "libthread_db.so.1" in /usr/lib.
>

I am working on the libthread_db issue right now. Is proving to be harder
than I would have expected. Anyway, I did determine the problem causing the
warnings:

warning: pointer targets in passing argument 3 of
'snd_pcm_hw_params_set_rate_near' differ in signedness

was due to sample_rate being defined as an int and not an unsigned int.
Changing that cleared that warning.

I will let you know what happens once I get the libthread_db going.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
