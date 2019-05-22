From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: Cannot build broadwell on for-5.3
Date: Wed, 22 May 2019 11:30:31 -0700
Message-ID: <CAOReqxjUk_6Fvc=CRnCWu7c=QvObxhwA_psWLz5gLO_v5Fc5Pg@mail.gmail.com>
References: <CAOReqxjQAya8GQ4bOSBfTBHwXd38c33pOMc35rrSj4O4jMaMSQ@mail.gmail.com>
 <s5hwoii1rd3.wl-tiwai@suse.de>
 <6eb7cc4d-aa95-74b9-e849-22559737f47a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C786CF8079B
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 20:30:44 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id d8so2431041lfb.8
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 11:30:44 -0700 (PDT)
In-Reply-To: <6eb7cc4d-aa95-74b9-e849-22559737f47a@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, Guenter Roeck <groeck@google.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 22, 2019 at 8:22 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> >> It appears the for-5.3 branch had some broken commits pulled in at
> >> 1c7c3237c0cc4ad3c7b0df458290c8e2a652f178 ("Merge tag 'v5.2-rc1' into
> >> asoc-5.3 ")
> >>
> >> building for the pixelbook I get the following build errors:
> >>
> >> Invalid absolute R_X86_64_32S relocation: _etext
> >> make[3]: *** [/mnt/host/source/src/third_party/kernel/v4.14/arch/x86/boot/compressed/Makefile:130:
> >> arch/x86/boot/compressed/vmlinux.relocs] Error 1
> >> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> >>
> >> Mainline is still broken as well. Not sure how to propagate this up to
> >> the responsible parties, figured I would start a discussion here
> >> first. I am also open to suggestions if there is a chance I am missing
> >> something.
> >
> > Looks like some leftover interfering the build.
> > Try to cleanup your work directory, e.g. make distclean and rebuild.
>
> works for me with the attached .config.
> Likely an environment problem.
Yea, cleaning didn't help, Pierre is right, it appears to be tied to
our gcc version we are stuck on. I will see what I can do to work
around this. Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
