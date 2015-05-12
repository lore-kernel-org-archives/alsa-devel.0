From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: commit b1ef29725865 (ACPI _REV=2) causes sound regression on
 Dell XPS 13 [Was: Discussion around quirking the _REV behavior for the XPS
 13 (2015) until 4.2]
Date: Tue, 12 May 2015 11:45:40 -0500
Message-ID: <55522E34.80702@dell.com>
References: <55401602.5050907@dell.com> <55480021.1090402@dell.com> <20150511182658.GA8516@isilmar-3.linta.de> <20150512101258.GL2761@sirena.org.uk> <55521BA0.3030606@dell.com> <20150512161849.GD3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150512161849.GD3066@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "han.lu@intel.com" <han.lu@intel.com>, "yang.jie@intel.com" <yang.jie@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Matthew Garrett <mjg59@coreos.com>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



On 05/12/2015 11:18 AM, Mark Brown wrote:
>
> Please fix your mail client to word wrap within paragraphs and leave
> blank lines between paragraphs.  Your current mail client is doing
> neither which makes your mails hard to read.

Sorry about that, I've adjusted my mail client settings.

> You need PulseAudio 6.0 but otherwise yes, it works for me.
Ubuntu 15.04 is running Pulseaudio 6.0.
>
> That wasn't my question.  I'm asking what else the firmware is changing
> based on detecting Linux, we don't want to just move onto a different
> set of bugs somewhere else.
>
These are the different flows supported and what changes in the 
different flows.
This is up to date as of BIOS A03:

When Linux is detected (_OSI Windows 2013 & _REV 5):
* EC configures the audio controller for HDA mode on next cold boot.
* HDA audio device is included in PCI address space.
* Touchpad is put into I2C mode.

When Windows 8.1 is detected or currently Linux 4.1 (_OSI Windows 2013 & 
_REV 2):
* EC configures the audio controller for I2S mode on next cold boot.
* ADSP audio device included in ACPI (INT3438).
* Touchpad is put in I2C mode.

When Windows 7 is detected (_OSI Windows 2009):
* EC configures the audio controller for HDA mode on the next cold boot.
* HDA audio device included in PCI address space.
* Touchpad is put in PS2 mode.

> I'm not seeing any of the hw_params() issues with v4.1 - are you perhaps
> using an old linux-firmware?  I don't know how up to date Ubuntu is
> there.
linux-firmware ubuntu 15.04 version: 1.143.
This is based off upstream cef33368c4d3425f11306496f0250f8ef1cf3c1f, 
updated on March 4 2015.
