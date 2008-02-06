From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 (no sound)
Date: Wed, 6 Feb 2008 16:47:36 +1030 (CST)
Message-ID: <200802060617.m166HaYL003540@turbo.physics.adelaide.edu.au>
References: <47A8E672.9080202@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 767E624481
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 07:17:40 +0100 (CET)
In-Reply-To: <47A8E672.9080202@harddisk.is-a-geek.org> from "Marco Schuster"
	at Feb 05, 2008 11:42:58 PM
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Marco

> > Having said that I don't think this is the *general* case with the
> > ALC268 because as I have mentioned a user has reported success with the
> > ALC268 under Linux and a recent hg snapshot with both the "test" and
> > "auto" models.
> Strange.

Not really.  There's very strong evidence that the silicon may be different
and this sort of thing occurs from time to time.  While you may have an
actual ALC-268 chip on your mainboard, someone else may have an ALC268 core
integrated into some other chip vendor's jungle chip.  The other issue is
that different vendors choose to integrate the codec chips in different ways
- different pin-to-jack mappings, use of GPIOs etc etc.  With this sort of
thing going on it's really no surprise to me that one ALC268-based system
works while another does not.

> I have uploaded the driver to
> http://rapidshare.com/files/89478591/ALC268_Compal.rar (but I left out the
> Vista stuff). Do you think it's possible to find out _what_ makes the
> problem with this?

I've had a quick look at the contents and nothing jumps out at me.  Others
with more experience with the windoze driver structure and knowledge of how
various files are used may have more success.

My past experience has shown that in cases like this the best approach is to
poke at the hardware until you find something that works.  Admittedly that's
becoming less feasible as time goes on and the hardware gets more complex
and the fragility of hardware increases the likelihood of permanent damage.

Regards
  jonathan
