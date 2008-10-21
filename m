From: "Jan Arie Gutter" <alsa@jangutter.com>
Subject: Intel DG45ID motherboard and weird pinouts
Date: Tue, 21 Oct 2008 18:01:13 +0200
Message-ID: <9bcb35630810210901t5959bfev654898b0e58e3a68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id F2EFE247BC
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 18:01:31 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so690798qwj.56
	for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2008 09:01:13 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I'm running Gentoo stable with kernel 2.6.27 (I think it comes
with alsa 1.0.17) on my brand-new Intel DG45ID motherboard (hda-intel,
therefore). I'm trying to get analogue out on all the correct
channels, but it seems that something is slightly wierd: if I unmute
headphones only, the front channel works, otherwise it seems that the
front channel is split all over the place (I can provide more specific
details if requested).

I tried alsa-driver-1.0.18rc3 as well (keeping alsa-lib and alsa-utils
the old version), but the headphones control disappeared: I could not
find any equivalent settings to enable front speakers.

Now, to the questions:

1) Can I help fix the pinout information in ALSA? I'm willing to
experiment (especially if I can do it against 1.0.17).
2) Is there a doc somewhere that describes a step-by-step method to
add a quirk to the codec (IDT 92HD73E1X5, I presume) for my board?
3) Would the problem be fixed if I update alsa-libs and alsa-utils to
1.0.18rc3, or is the problem only in the hda-intel kernel driver?

I've got moderate kernel-hacking skills: I can compile, patch, debug
minor stuff, etc, I've got ready access to the hardware and I'm
willing to experiment! I DON'T have experience with ALSA or audio
drivers, and since the PC is at home, I can only hack after hours. Any
help would be greatly appreciated!

Thanks!

Jan Gutter

-- 
"-and those damned stupid barbarians with their
damned stupid swords will win after all..."
-- Larry Niven (The Magic Goes Away)
