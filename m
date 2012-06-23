From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sound: fix MODULE_LICENSE typos
Date: Sat, 23 Jun 2012 10:03:17 -0700
Message-ID: <CAGXu5jLGNQj4LqrePpAV_kVBGFX9AxrFs11Hjzg6qk5K=QFxyw@mail.gmail.com>
References: <20120622232149.GA29819@www.outflux.net>
	<20120623105118.GR4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120623105118.GR4037@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Joshua Kroll <joshkroll@google.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 23, 2012 at 3:51 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 22, 2012 at 04:21:49PM -0700, Kees Cook wrote:
>> include/linux/license.h does not recognize "GPLv2", so adjust these
>> declarations to add the needed space before the version.
>
> This patch isn't against current -next which doesn't have this issue,
> I've no idea what you generated against as a version with this has ne=
ver
> even been in -next. =A0Please do also use subject lines that resemble
> those used in the rest of the subsystem, having to hand edit commit l=
ogs
> is tedious.
>
> It seems more sensible to fix license.h, GPLv2 is a pretty common way=
 of
> writing the license name in the wider community.

Ah-ha, yes, I see there's already fixed in -next. Thanks!

http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dcom=
mitdiff;h=3D85f243912b99b053ce0624c30609f5d8fd4445d2

-Kees

--=20
Kees Cook
Chrome OS Security
