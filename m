From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ALSA: hda - Remove dependency on
 bus->pci in hda_beep.c
Date: Wed, 19 Feb 2014 07:16:38 -0800
Message-ID: <CAEUnVG4y+14Y8ManPPGVvcQjqpdyzBebLWcq7Sa6xQ3SwFRK+Q@mail.gmail.com>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
 <s5hfvnkzq4y.wl%tiwai@suse.de> <5303A0A3.6050206@wwwdotorg.org>
 <s5hob23y01o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B982658E4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:16:59 +0100 (CET)
Received: by mail-qg0-f48.google.com with SMTP id a108so863788qge.7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 07:16:59 -0800 (PST)
In-Reply-To: <s5hob23y01o.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 19, 2014 at 12:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 18 Feb 2014 11:04:19 -0700,
> Stephen Warren wrote:
>>
>> On 02/15/2014 02:22 AM, Takashi Iwai wrote:
>> > At Sat, 15 Feb 2014 10:17:33 +0100,
>> > Takashi Iwai wrote:
>> >>
>> >> The default parent device can be obtained directly via card object, so
>> >> we don't need to rely on pci->dev.parent.  Since there is no access to
>> >> pci_dev, we can reduce the inclusion of linux/pci.h, too.
>> >>
>> >> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> >
>> > I forgot the cover page: these tree patches are trivial cleanups of
>> > hda-codec drivers (not the controller) to work without PCI device
>> > assignment. The idea was triggered by Dylan's question.
>>
>> The series seems fine to me, so briefly,
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>
> Thanks.  Any chance to work on / submit other changes for Tegra
> HD-audio support?

That's the plan, hopefully I'll be able to find time to throw together
an RFC by the end of the week.

>
> As already mentioned, I think a cleaner way would be to write
> hda_platform.c instead of hacking hda_intel.c with ifdefs.
> Some code in hda_intel.c (e.g. bus ops and PCM callbacks) can be moved
> out, either as a new helper module or just merging into snd-hda-codec
> helper module, so that they can be used by both hda_intel.c and
> hda_platform.c.

That sounds like a good idea.  There aren't a lot of differences,
mostly isolated to init and suspend/resume.  That should be easy to
put in hda_platform.

Thanks,

Dylan

>
> Ideally, we may rename hda_intel.c with hda_pci.c, but I'm afraid this
> would bring too many regressions for module options.
>
>
> Takashi
