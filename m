From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Wed, 13 May 2015 16:32:29 -0500
Message-ID: <5553C2ED.2030406@dell.com>
References: <55401602.5050907@dell.com> <55480021.1090402@dell.com> <20150511182658.GA8516@isilmar-3.linta.de> <20150512101258.GL2761@sirena.org.uk> <55521BA0.3030606@dell.com> <20150512161849.GD3066@sirena.org.uk> <55522E34.80702@dell.com> <20150512173502.GH3066@sirena.org.uk> <E7B1D079BA13FB44A978CC8F69C7D6A9055272E4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A9055272E4@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Jie, Yang" <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/2015 09:14 PM, Jie, Yang wrote:
>   
> Hi Mario, can you try disabling pulseaudio to see if anything change?
> Once I got one XPS 13 9343, I can debug on it, we have ordered it, but been
> told still need wait 4 more weeks for lacking of the LCD screen materials.
>
> ~Keyon
>
>

Keyon,

Yes, if I kill pulseaudio (and prevent it from starting back up), I am 
able to get audio by running:
speaker-test -c 2 -t wav -D plughw:broadwellrt286

I've tried to remove .config/pulse, but it's still not working at all 
when pulse launches up.

Thanks,
