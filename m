From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on Dell
 XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS 13
 (2015) until 4.2]
Date: Tue, 12 May 2015 10:21:41 -0700
Message-ID: <CAPeXnHtdU=9bMjHh8NSArYngxDC1wSp3ZDiN96e5gHB_LQjr5g@mail.gmail.com>
References: <55401602.5050907@dell.com>
	<55480021.1090402@dell.com>
	<20150511182658.GA8516@isilmar-3.linta.de>
	<20150512101258.GL2761@sirena.org.uk>
	<55521BA0.3030606@dell.com>
	<20150512161849.GD3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150512161849.GD3066@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 12, 2015 at 9:18 AM, Mark Brown <broonie@kernel.org> wrote:
> You need PulseAudio 6.0 but otherwise yes, it works for me.

Since there's no way to get this working without using new userspace,
we're basically stuck with having to support _REV 5. And since we're
supposed to support old userspace basically forever, this isn't going
to be something that we can just remove in a few months. But since the
hardware is intended to be used in I2S mode, we don't want this quirk
to be there forever. So we're basically left with adding
CONFIG_ACPI_WORKAROUND_BROKEN_DELLS which enables the quirk, default
it to Y and then let distributions set it to N when they've got
sufficiently new userspace. Unless someone has a better plan?
