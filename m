From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI device probing
Date: Tue, 25 Nov 2014 17:48:24 -0800
Message-ID: <54753168.9010303@linux.intel.com>
References: <1416034608-24238-1-git-send-email-benzh@chromium.org> <CACxGe6stjCvaQZkh=hFcF-56v5qJVar11jRZz0PRSd2wz6EUyA@mail.gmail.com> <5474A78C.7030805@linux.intel.com> <20141125172120.GI7712@sirena.org.uk> <5474CB5D.9050807@linux.intel.com> <20141125184304.GK7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141125184304.GK7712@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Ben Zhang <benzh@chromium.org>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Anatol Pomozov <anatol@google.com>, Dylan Reid <dgreid@chromium.org>, flove@realtek.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: alsa-devel@alsa-project.org



On 11/25/14 10:43, Mark Brown wrote:
> On Tue, Nov 25, 2014 at 10:33:01AM -0800, Darren Hart wrote:
>> On 11/25/14 09:21, Mark Brown wrote:
> 
>>> Given the design of _DSD is to share with DT and we already
>>> have device tree bindings for the device we should be using,
>>> it's not clear to me if we want to grind them all through UEFI
>>> and I suspect they'd be unhappy if we tried but pretty much all
>>> audio CODECs are good candidates for use with ACPI given the
>>> new hardware designs Intel have so if we are doing it I ought
>>> to be bouncing everyone to UEFI forum.
> 
>> Right, I realized between sending and driving into the office
>> that my statement might be construed this way. I meant *new* _DSD
>> bindings should go through the ACPI/UEFI forum. Where we can
>> reuse DT bindings, we should absolutely do that, agreed. We
>> should still document this and link to the DT binding so it can
>> be referenced and used even when Linux is not the target OS.
> 
> Link from where - do we want to talk to the ACPI/UEFI forum and
> figure out some kind of fast track process for them to add an "it's
> already covered by DT, see here" entry to their database for
> example?  We also ought to work out how to make sure ACPI IDs are
> registered there as well, should be possible to have something
> simple as part of that.
> 

As to registering ACPI IDs, I believe this is the right link:
http://www.uefi.org/PNP_ACPI_Registry

Or did you mean a HID/CID<->DSD mapping?

-- 
Darren Hart
Intel Open Source Technology Center
