From: "Jie, Yang" <yang.jie@intel.com>
Subject: RE: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Wed, 13 May 2015 02:14:56 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A9055272E4@SHSMSX101.ccr.corp.intel.com>
References: <55401602.5050907@dell.com> <55480021.1090402@dell.com>
 <20150511182658.GA8516@isilmar-3.linta.de>
 <20150512101258.GL2761@sirena.org.uk> <55521BA0.3030606@dell.com>
 <20150512161849.GD3066@sirena.org.uk> <55522E34.80702@dell.com>
 <20150512173502.GH3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150512173502.GH3066@sirena.org.uk>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, May 13, 2015 1:35 AM
> To: Mario Limonciello
> Cc: Dominik Brodowski; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; linux-
> acpi@vger.kernel.org; Lu, Han; Jie, Yang; alsa-devel@alsa-project.org;
> Matthew Garrett; Girdwood, Liam R
> Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression
> on Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the
> XPS 13 (2015) until 4.2]
> 
> On Tue, May 12, 2015 at 11:45:40AM -0500, Mario Limonciello wrote:
> 
> > >I'm not seeing any of the hw_params() issues with v4.1 - are you
> > >perhaps using an old linux-firmware?  I don't know how up to date
> > >Ubuntu is there.
> 
> > linux-firmware ubuntu 15.04 version: 1.143.
> > This is based off upstream cef33368c4d3425f11306496f0250f8ef1cf3c1f,
> > updated on March 4 2015.
> 
> That's the same firmware I have.  Weird, I don't know if the Intel guys have
> any bright ideas here?
 
Hi Mario, can you try disabling pulseaudio to see if anything change?
Once I got one XPS 13 9343, I can debug on it, we have ordered it, but been
told still need wait 4 more weeks for lacking of the LCD screen materials.

~Keyon


