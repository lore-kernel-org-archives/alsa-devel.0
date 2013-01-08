From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH RFC 000/112] HD-audio generic parser
	improvements
Date: Tue, 08 Jan 2013 14:03:23 +0100
Message-ID: <50EC191B.4070207@perex.cz>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C69E826164D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 14:03:24 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 8.1.2013 12:37, Takashi Iwai wrote:
> Hi,
> 
> this is a large series of patches to implement the really generic
> HD-audio codec parser usable for various codecs.  It's based on the
> Realtek codec parser, so I started hacking patch_realtek.c for more
> generalization and improvements.  Then it's merged to the existing
> generic parser code, hda_generic.c, and let Realtek parser just uses
> this new parser code.  In the end, patch_realtek.c contains only
> the device specific fixups and the call of generic parser functions.

Great step forward. Thanks.

In my opinion, it would be great to handle all fixups in some "user
space" compatible mode. I mean, do not use the C code for fixups, but
use an universal description code which can be loaded from the user
space probably as ASCII text (firmware like behaviour), too. This code
can be buildin to the kernel modules in a default version. I don't mean
the current implemented patch processing, but full codec initialization.
I think that it may be last change to bring the HDA code to more
maintenable state. Just an idea to avoid further HDA code rewrites which
happen periodically. And now (with your rewrite) it's really good time
to propose also this change.

Please, provide the GIT URL with these changes.

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
