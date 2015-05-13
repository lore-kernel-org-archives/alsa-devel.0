From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS 13 (2015) until 4.2]
Date: Wed, 13 May 2015 15:44:09 +0200
Message-ID: <1435132.ABVHTMV8VU@vostro.rjw.lan>
References: <55401602.5050907@dell.com> <28099406.1MOrFLUSgY@vostro.rjw.lan> <20150513063647.GA2479@air.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150513063647.GA2479@air.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Matthew Garrett <matthew.garrett@coreos.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Mark Brown <broonie@kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday, May 13, 2015 08:36:47 AM Dominik Brodowski wrote:
> 
> --3MwIy2ne0vdjdPXF
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Wed, May 13, 2015 at 01:38:59AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, May 12, 2015 10:43:33 AM Matthew Garrett wrote:
> > > On Tue, May 12, 2015 at 10:29 AM, Mario Limonciello
> > > <mario_limonciello@dell.com> wrote:
> > > > Just to be clear, from the Dell side only the XPS 13 9343 has this _R=
> EV
> > > > behavior.
> > >=20
> > > The Inspiron 7437 queries _REV and uses it to modify its EC behaviour,
> > > and apparently breaks on Linux without that.
> > >=20
> > > > What's wrong with a DMI quirk until I2S is mature on the kernel side =
> and
> > > > userspace is new enough in distros?  Is it too early in boot for DMI =
> quirks?
> > > > That would enforce that no other machines can use _REV value of 5 to =
> detect
> > > > Linux without breaking the 9343.
> > >=20
> > > DMI quirking is fine, but it has to be behind a config option. We're
> > > going to have to carry the quirk for several years because we have to
> > > support old userspace for an arbitrarily long time, and if there's no
> > > config option then Linux will be stuck in HDA mode for that entire
> > > time.
> >=20
> > One problem with the DMI-based approach is that _REV is constant in ACPIC=
> A,
> > so to be able to return different values from it for different systems, w=
> e'll
> > need to add some ACPICA-ish code handling that specifically for Linux and
> > we're a bit too late in the cycle for that.
> >=20
> > So here's what I'm going to do.  I'll revert commit b1ef29725865 for 4.1,
> > but *only* for 4.1 (I've actually queued up a revert of it already) and
> > I'll revert that revert during the 4.2 merge window.
> 
> Sounds like a good plan. Thanks!
> 
> > In the meantime, we'll develop the code to implement the DMI-based quirks
> > for the Dells and apply it for 4.2.
> >=20
> > Are there any volunteers for doing the last part?
> 
> Will try to prepare patches for that tomorrow.

Thanks a lot!
 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
