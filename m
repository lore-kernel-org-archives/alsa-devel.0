From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 21 May 2015 13:18:44 -0500
Message-ID: <555E2184.3090900@dell.com>
References: <20150517174144.GA17503@light.dominikbrodowski.net>	<3695901.X9t2lWziuY@vostro.rjw.lan>	<20150518044711.GA3401@air.dominikbrodowski.net>	<6154326.X9FC8ZVDIy@vostro.rjw.lan> <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 05/21/2015 01:10 PM, Matthew Garrett wrote:
> On Wed, May 20, 2015 at 6:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
>> Which doesn't explain why we need a config option per quirk.  To me, such config
>> options don't add any value, because (a) everyone will set them anyway and (b)
>> removing the quirks from the source is trivial if needed.
> We'd disable this quirk in Fedora the moment jack detection works,
> because we've got the userspace to handle it and using I2S is
> preferable to using HDA - but in doing so we might break battery
> detection on the other Dell that's playing _REV tricks. This seems
> like a suboptimal choice to have to make.

Having dug into this deeper with you on the other thread, battery 
detection already wasn't working.
That machine did the _REV test and fix for Linux only on Windows 2009 
_OSI and the _REV value of 5.
The kernel currently responds to a later _OSI that the machine supports 
so that AML does not get run.

I believe battery detection may be fixed on that Inspiron by 
75646e758a0ecbed5024454507d5be5b9ea9dcbf.
if it's not, that's a tangential problem that should be fixed to match 
the Windows behavior for battery detection.
