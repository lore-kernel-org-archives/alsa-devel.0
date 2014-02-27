From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ALSA: hda - Remove dependency on
 bus->pci in hda_beep.c
Date: Thu, 27 Feb 2014 08:44:48 -0800
Message-ID: <CAEUnVG7B6B7wD0xDSi87vZj=WKJdY8ZokQ1zUKz_vknL9e=UkQ@mail.gmail.com>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
 <s5hfvnkzq4y.wl%tiwai@suse.de> <5303A0A3.6050206@wwwdotorg.org>
 <s5hob23y01o.wl%tiwai@suse.de>
 <CAEUnVG4y+14Y8ManPPGVvcQjqpdyzBebLWcq7Sa6xQ3SwFRK+Q@mail.gmail.com>
 <s5hob1swyn0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f169.google.com (mail-qc0-f169.google.com
 [209.85.216.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 94935261B21
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 17:45:10 +0100 (CET)
Received: by mail-qc0-f169.google.com with SMTP id e9so3582928qcy.28
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 08:45:09 -0800 (PST)
In-Reply-To: <s5hob1swyn0.wl%tiwai@suse.de>
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

On Thu, Feb 27, 2014 at 4:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 19 Feb 2014 07:16:38 -0800,
> Dylan Reid wrote:
>>
>> On Wed, Feb 19, 2014 at 12:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 18 Feb 2014 11:04:19 -0700,
>> > Stephen Warren wrote:
>> >>
>> >> On 02/15/2014 02:22 AM, Takashi Iwai wrote:
>> >> > At Sat, 15 Feb 2014 10:17:33 +0100,
>> >> > Takashi Iwai wrote:
>> >> >>
>> >> >> The default parent device can be obtained directly via card object, so
>> >> >> we don't need to rely on pci->dev.parent.  Since there is no access to
>> >> >> pci_dev, we can reduce the inclusion of linux/pci.h, too.
>> >> >>
>> >> >> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> >> >
>> >> > I forgot the cover page: these tree patches are trivial cleanups of
>> >> > hda-codec drivers (not the controller) to work without PCI device
>> >> > assignment. The idea was triggered by Dylan's question.
>> >>
>> >> The series seems fine to me, so briefly,
>> >> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> >
>> > Thanks.  Any chance to work on / submit other changes for Tegra
>> > HD-audio support?
>>
>> That's the plan, hopefully I'll be able to find time to throw together
>> an RFC by the end of the week.
>
> Since there was no patch appearing yet, I merged my latest development
> branch to for-next branch, which includes lots of changes in
> hda_intel.c and hda_codec.c.  If any, please rebase your patches to
> it.

Thanks for the heads up.  I've got a series that is almost ready, I'm
still trying to tease part of the build out from under CONFIG_PCI in
the hda makefile.  I'll try to button that up and get a the whole lot
rebased on top of the for-next branch.

Dylan

>
>
> thanks,
>
> Takashi
