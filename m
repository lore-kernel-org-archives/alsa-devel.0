From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 27 Apr 2015 11:52:52 -0600
Message-ID: <20150427175252.GJ550@huh.zplane.com>
References: <20150419133733.GA551@huh.zplane.com>
 <CAN8cciYqdJ-m+M0+F09115nocy7szAfgdAf834c2bS4=gL7DAA@mail.gmail.com>
 <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E3752606AD
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 19:53:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8xt4hsa.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [2015-04-27 19:12:21 +0200]:
> 
> I see no such warning in the log you attached, so it's not the issue,
> as it seems.
> 
> Below is a debug patch, and now you should see messages like "XXX ..."
> in kernel log at loading the driver.  If there is no such a message,
> it means that the thinkpad hook isn't built in at all.  Please check
> the kernel log again with the patch.
> 

Actually, before adding your debug patch, a question about something that may 
be relevant here: I noticed just now that the kernel build, which I performed 
in accordance with the instructions from the Archlinux Wiki:

    https://wiki.archlinux.org/index.php/Kernels/Compilation/Traditional

did not result in a /lib/modules/extramodules-3.19-ARCH-gdg01 directory
being created ("ARCH-gdg01" being the suffix used for the custom-built
kernel).

The only extant modules directories are /lib/modules/3.19.3-ARCH-gdg01
and of course the extramodules dir /lib/modules/extramodules-3.19-ARCH
that already existed from the previously installed ARCH distro kernel.

I suspect this may be a problem vis a vis ACPI, because with the new kernel
loaded, the battery level indicator is stuck at zero. :)

What's the magic incantation to build the extramodules?  I did look through
this:

    https://www.kernel.org/doc/Documentation/kbuild/modules.txt

but it did not seem to address this question that I could tell.
