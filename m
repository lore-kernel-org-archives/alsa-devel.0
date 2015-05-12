From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 10:26:24 -0500
Message-ID: <55521BA0.3030606@dell.com>
References: <55401602.5050907@dell.com> <55480021.1090402@dell.com> <20150511182658.GA8516@isilmar-3.linta.de> <20150512101258.GL2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150512101258.GL2761@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/2015 05:12 AM, Mark Brown wrote:
> On Mon, May 11, 2015 at 08:26:58PM +0200, Dominik Brodowski wrote:
>
> Also CCing Matthew who came up with the original version of the version
> change and Liam who is one of Intel's audio experts.
>
>> According to an off-list discussion, the sound breakage (and not just some
>> jack detection issue) seems to be caused due to alsa-lib being too old.
> Right, it needs the userspace configuration files installing.
Is it just configuration files?  With 4.1-rc3 I've not been able to get sound working mucking with any mixers.
>
>> The matter is further complicated by the issue that the driver
>> asks for some firmware blob intel/IntcPP01.bin which (at least) I
>> cannot find anywhere.
> As previously advised that firmware is optional.
The errors in dmesg make it seem like that was related to the firmware missing, but that is a red herring it sounds like.
>
>> Under the no-regression rule, this means that either b1ef29725865 needs
>> to be reverted or we need to find another solution to this matter, such as
>> an override. And I think it is needed for longer than just for 4.1, as it
>> will continue to be cause regressions on quite recent userspace.
> Does this also affect other behaviour of the system?  I'd be pretty
> unhappy if it introduce power regressions for example, I mostly don't use
> audio on my laptops but I care a lot about how long it'll run
> disconnected.  It *is* quite a new laptop and my experience installing
> was very much that it was in bringup (though quite a bit of this was
> userspace).
I just tried it with 4.1-rc3 from Ubuntu's mainline PPA and an Ubuntu 15.04 userspace.  It does affect the behavior of the system.    See all the PCM errors in dmesg:
https://bugzilla.kernel.org/attachment.cgi?id=176511

At least with BIOS A03 (latest), Ubuntu 15.04 (3.19ish and modern userspace) or with 4.0 and recent userspace the experience shouldn't be bringup.

Keyon,

There is a bug opened at https://bugzilla.kernel.org/show_bug.cgi?id=93361.  I've added updated notes to this for 4.1-rc3 experience.

