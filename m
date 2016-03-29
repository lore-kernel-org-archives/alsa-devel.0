From: Andy Lutomirski <luto@amacapital.net>
Subject: Getting rid of inside_vm in intel8x0
Date: Tue, 29 Mar 2016 14:37:32 -0700
Message-ID: <CALCETrWnsn4CoRXcKDXpMTjxCYj8==mZQHkZRuXfZQyvERB3Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Rodriguez <mcgrof@suse.com>, Konstantin Ozerkov <kozerkov@parallels.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Would it be possible to revert:

commit 228cf79376f13b98f2e1ac10586311312757675c
Author: Konstantin Ozerkov <kozerkov@parallels.com>
Date:   Wed Oct 26 19:11:01 2011 +0400

    ALSA: intel8x0: Improve performance in virtual environment

Presumably one or more of the following is true:

a) The inside_vm == true case is just an optimization and should apply
unconditionally.

b) The inside_vm == true case is incorrect and should be fixed or disabled.

c) The inside_vm == true case is a special case that makes sense then
IO is very very slow but doesn't make sense when IO is fast.  If so,
why not literally measure the time that the IO takes and switch over
to the "inside VM" path when IO is slow?

There are a pile of nonsensical "are we in a VM" checks of various
sorts scattered throughout the kernel, they're all a mess to maintain
(there are lots of kinds of VMs in the world, and Linux may not even
know it's a guest), and, in most cases, it appears that the correct
solution is to delete the checks.  I just removed a nasty one in the
x86_32 entry asm, and this one is written in C so it should be a piece
of cake :)

--Andy
