From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Mon, 11 May 2015 14:01:11 -0500
Message-ID: <5550FC77.5000401@dell.com>
References: <55401602.5050907@dell.com> <55480021.1090402@dell.com> <20150511182658.GA8516@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150511182658.GA8516@isilmar-3.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/11/2015 01:26 PM, Dominik Brodowski wrote:
> Hi,
>
> (CC'ing sound experts)
>
> indeed, commit b1ef29725865 causes a severe regression -- actually, it
> causes sound to be totally unusuable on the Dell XPS 13 (2015) on
> Debian jessie, while it works fine in 4.0 / with b1ef29725865 reverted.
>
> According to an off-list discussion, the sound breakage (and not just some
> jack detection issue) seems to be caused due to alsa-lib being too old.
> The matter is further complicated by the issue that the driver
> asks for some firmware blob intel/IntcPP01.bin which (at least) I
> cannot find anywhere.
>
> Under the no-regression rule, this means that either b1ef29725865 needs
> to be reverted or we need to find another solution to this matter, such as
> an override. And I think it is needed for longer than just for 4.1, as it
> will continue to be cause regressions on quite recent userspace.
>
> Best,
> 	Dominik
>
>
> PS/OT: Probably I'm preaching to the choir, but @Mario: it's a pity the
> XPS (or some versions of it) with pre-installed Ubuntu actually ships
> with a Wifi adapter which seems to be unsupported by upstream Linux...
>
>
Dominik,

Yes I've noticed it's acting much worse for me too with 4.1-rc2 on Ubuntu 15.04 userspace (which is quite new indeed).  I really think the right solution is some sort of quirk against the XPS 13 on the _REV behavior until this is reasonably mature.

OT: Yes, this feedback has been taken to heart by the team.  We're working on adding more variants with alternate adapters.  :)
