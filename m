From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS 13 (2015) until 4.2]
Date: Wed, 13 May 2015 01:38:59 +0200
Message-ID: <28099406.1MOrFLUSgY@vostro.rjw.lan>
References: <55401602.5050907@dell.com> <5552388C.9000500@dell.com> <CAPeXnHss+k4xqYDZsDycKEAtLGMBbsnsMiHsZ_voigbPoq3vUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPeXnHss+k4xqYDZsDycKEAtLGMBbsnsMiHsZ_voigbPoq3vUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, Mark Brown <broonie@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, May 12, 2015 10:43:33 AM Matthew Garrett wrote:
> On Tue, May 12, 2015 at 10:29 AM, Mario Limonciello
> <mario_limonciello@dell.com> wrote:
> > Just to be clear, from the Dell side only the XPS 13 9343 has this _REV
> > behavior.
> 
> The Inspiron 7437 queries _REV and uses it to modify its EC behaviour,
> and apparently breaks on Linux without that.
> 
> > What's wrong with a DMI quirk until I2S is mature on the kernel side and
> > userspace is new enough in distros?  Is it too early in boot for DMI quirks?
> > That would enforce that no other machines can use _REV value of 5 to detect
> > Linux without breaking the 9343.
> 
> DMI quirking is fine, but it has to be behind a config option. We're
> going to have to carry the quirk for several years because we have to
> support old userspace for an arbitrarily long time, and if there's no
> config option then Linux will be stuck in HDA mode for that entire
> time.

One problem with the DMI-based approach is that _REV is constant in ACPICA,
so to be able to return different values from it for different systems, we'll
need to add some ACPICA-ish code handling that specifically for Linux and
we're a bit too late in the cycle for that.

So here's what I'm going to do.  I'll revert commit b1ef29725865 for 4.1,
but *only* for 4.1 (I've actually queued up a revert of it already) and
I'll revert that revert during the 4.2 merge window.

In the meantime, we'll develop the code to implement the DMI-based quirks
for the Dells and apply it for 4.2.

Are there any volunteers for doing the last part?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
