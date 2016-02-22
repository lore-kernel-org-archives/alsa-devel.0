From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [alsa-devel] [PATCH 0/1] ALSA: hda - Use acpi_dev_present()
Date: Mon, 22 Feb 2016 21:23:31 +0100
Message-ID: <20160222202331.GA20052@wunner.de>
References: <cover.1452790983.git.lukas@wunner.de>
 <s5hmvs7l6ys.wl-tiwai@suse.de>
 <20160220224724.GA19638@wunner.de>
 <s5h1t86xyt1.wl-tiwai@suse.de>
 <56CB18A7.3000207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CB18A7.3000207@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

[cc: += Rafael J. Wysocki, Robert Moore, linux-acpi@vger.kernel.org]

Hi Pierre-Louis,

On Mon, Feb 22, 2016 at 08:18:15AM -0600, Pierre-Louis Bossart wrote:
> On 02/21/2016 02:17 AM, Takashi Iwai wrote:
> > On Sat, 20 Feb 2016 23:47:24 +0100,
> > Lukas Wunner wrote:
> >>
> >> Hi Takashi,
> >>
> >> On Fri, Jan 15, 2016 at 06:58:19AM +0100, Takashi Iwai wrote:
> >>> On Thu, 14 Jan 2016 22:05:03 +0100, Lukas Wunner wrote:
> >>>> Hi Takashi,
> >>>>
> >>>> the acpi_dev_present() API has now landed in Linus' tree.
> >>>> Thus, after Linus' tree gets merged back into yours,
> >>>> it would be possible to use the API in the Thinkpad hda drivers
> >>>> as per the following patch.
> >>>>
> >>>> I've also pushed it to GitHub in case anyone prefers
> >>>> perusing it in a browser:
> >>>> https://github.com/l1k/linux/commit/a1473d726b57eaf97c4de8812c5967603068e261
> >>>>
> >>>> An ack for this patch was kindly provided by Hui Wang with:
> >>>> Message-ID: <5653C291.9090607@canonical.com>
> >>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100962.html
> >>>
> >>> A back merge is ugly and I'd like to avoid it.
> >>> This is no urgent fix but rather a cleanup, right?  If so, I'd
> >>> postpone this to 4.6.
> >>
> >> I've noticed this patch isn't in one of your trees, so it looks
> >> like it's not queued for 4.6 yet. If there are objections against
> >> it please let me know. If there aren't, I'd like to gently remind
> >> of the patch's existence.
> > 
> > Sorry for the delay, it's merged now.
>  
> heads-up: we've identified that the ACPI subsystem reports devices as
> present even if they are explicitly disabled in the BIOS _STA routine.
> we have a couple of WIP patches to work around this issue that is
> blocking for some CHT-T devices, and they pretty much amount to a
> revert and addition of an explicit presence test

Thanks for the heads-up. I'm confused though that you're sending this
in reply to the thinkpad_helper.c patch, I assume this only concerns
the ASoC patch?

As you've correctly observed, acpi_dev_present() only checks presence
of a HID in the namespace and does not invoke the _STA control method.
However the code that it replaced also only checked presence in the
namespace, so this is not an issue introduced by my patch but rather
one which was present all along.

If you need to check the "device is present" bit returned by _STA,
you need a pointer to the struct acpi_device. This will allow you
to call acpi_bus_get_status() and check its return value for
ACPI_STA_DEVICE_PRESENT.

We cannot easily add this to acpi_dev_present() because that function
no longer does an expensive namespace walk but rather a cheap list
iteration which does not yield a pointer to the struct acpi_device.

In the first version of acpi_dev_present() I was in fact doing a
namespace walk with acpi_get_devices() but Robert Moore objected
to that, calling it "truly brute force":
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/101046.html

Hence if possible you should try to avoid that as well. You may
want to consider adding a helper to drivers/acpi/utils.c which
takes a HID and returns a struct acpi_device*, it might come in
handy for others as well.

Best regards,

Lukas
