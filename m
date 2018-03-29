From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] ALSA: hda_intel: mark PM functions as
	__maybe_unused
Date: Thu, 29 Mar 2018 13:59:34 +0200
Message-ID: <20180329115934.GA22529@wunner.de>
References: <20180328142020.3275989-1-arnd@arndb.de>
 <20180328143150.GA17992@wunner.de>
 <CAK8P3a2RSDgxOcAqJK9fJ-zsZJu37nTVn3Wdogj3B655d0yr5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62]) by alsa0.perex.cz (Postfix) with ESMTP id 01C83266F92
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 13:59:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAK8P3a2RSDgxOcAqJK9fJ-zsZJu37nTVn3Wdogj3B655d0yr5Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2018 at 12:14:03AM +0200, Arnd Bergmann wrote:
> On Wed, Mar 28, 2018 at 4:31 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Mar 28, 2018 at 04:19:29PM +0200, Arnd Bergmann wrote:
> >> Two callsites of azx_suspend/azx_resume were removed, leaving these
> >> functions only called from the optional SET_SYSTEM_SLEEP_PM_OPS()
> >> and causing a warning without CONFIG_PM_SLEEP:
> >>
> >> sound/pci/hda/hda_intel.c:1029:12: error: 'azx_resume' defined but not used [-Werror=unused-function]
> >>  static int azx_resume(struct device *dev)
> >>             ^~~~~~~~~~
> >> sound/pci/hda/hda_intel.c:994:12: error: 'azx_suspend' defined but not used [-Werror=unused-function]
> >>  static int azx_suspend(struct device *dev)
> >>             ^~~~~~~~~~~
> >>
> >> Keeping track of the correct #ifdef checks is hard, so this removes
> >> all the #ifdefs for power management in this file and instead uses
> >> __maybe_unused annotations that let the compiler do the job right
> >> by itself.
> >
> > Ugh, this isn't as hard as it may seem, just replace
> >
> >         #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
> >
> > with
> >
> >         #if defined(CONFIG_PM_SLEEP)
> >
> > That way it's just a simple one line change which is less intrusive.
> >
> > Care to respin like this?
> 
> I won't be able to test that properly before the merge window. If you
> are sure that works, maybe you can send that patch and just mark
> it as 'Reported-by: Arnd Bergmann <arnd@arndb.de>'?

Okay, I've just sent out the patch.  Could somebody ack this?  I'll then
be able to push it to drm-misc-next-fixes before the merge window opens.
>From that point on the issue will be gone in linux-next.  The drm pull
for 4.17 has already been sent out by Dave Airlie tonight, but he's
indicated that he'll send another pull with fixes during the second
half of the merge window.  Once that lands, the issue will be fixed in
Linus' tree as well.

I've verified that with this patch, the build compiles cleanly using the
drm-misc defconfigs for x86 and arm, and I've also verified that the
compiler warning is present without the patch, and gone with the patch.

Thanks again for the report.

Lukas
