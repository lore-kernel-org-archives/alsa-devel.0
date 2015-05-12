From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 12:49:02 -0500
Message-ID: <55523D0E.5090300@dell.com>
References: <55401602.5050907@dell.com>	<55480021.1090402@dell.com>	<20150511182658.GA8516@isilmar-3.linta.de>	<20150512101258.GL2761@sirena.org.uk>	<55521BA0.3030606@dell.com>	<20150512161849.GD3066@sirena.org.uk>	<CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>	<5552388C.9000500@dell.com> <CAPeXnHss+k4xqYDZsDycKEAtLGMBbsnsMiHsZ_voigbPoq3vUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPeXnHss+k4xqYDZsDycKEAtLGMBbsnsMiHsZ_voigbPoq3vUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Mark Brown <broonie@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/2015 12:43 PM, Matthew Garrett wrote:
> On Tue, May 12, 2015 at 10:29 AM, Mario Limonciello
> <mario_limonciello@dell.com> wrote:
>> Just to be clear, from the Dell side only the XPS 13 9343 has this _REV
>> behavior.
> The Inspiron 7437 queries _REV and uses it to modify its EC behaviour,
> and apparently breaks on Linux without that.
Thanks for bringing this to my attention.  I'll check with my BIOS 
architecture team on this.  XPS 13 9343 was supposed to be the only 
system doing this.

>> What's wrong with a DMI quirk until I2S is mature on the kernel side and
>> userspace is new enough in distros?  Is it too early in boot for DMI quirks?
>> That would enforce that no other machines can use _REV value of 5 to detect
>> Linux without breaking the 9343.
> DMI quirking is fine, but it has to be behind a config option. We're
> going to have to carry the quirk for several years because we have to
> support old userspace for an arbitrarily long time, and if there's no
> config option then Linux will be stuck in HDA mode for that entire
> time.
>

OK, that makes more sense to me.  Thanks.
