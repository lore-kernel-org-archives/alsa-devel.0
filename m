From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Fri, 22 May 2015 03:13:52 +0200
Message-ID: <2098590.Jj0ekzOVtF@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com> <555E2184.3090900@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <555E2184.3090900@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matthew Garrett <matthew.garrett@coreos.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday, May 21, 2015 01:18:44 PM Mario Limonciello wrote:
> 
> On 05/21/2015 01:10 PM, Matthew Garrett wrote:
> > On Wed, May 20, 2015 at 6:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> >> Which doesn't explain why we need a config option per quirk.  To me, such config
> >> options don't add any value, because (a) everyone will set them anyway and (b)
> >> removing the quirks from the source is trivial if needed.
> > We'd disable this quirk in Fedora the moment jack detection works,
> > because we've got the userspace to handle it and using I2S is
> > preferable to using HDA - but in doing so we might break battery
> > detection on the other Dell that's playing _REV tricks. This seems
> > like a suboptimal choice to have to make.
> 
> Having dug into this deeper with you on the other thread, battery 
> detection already wasn't working.
> That machine did the _REV test and fix for Linux only on Windows 2009 
> _OSI and the _REV value of 5.
> The kernel currently responds to a later _OSI that the machine supports 
> so that AML does not get run.
> 
> I believe battery detection may be fixed on that Inspiron by 
> 75646e758a0ecbed5024454507d5be5b9ea9dcbf.
> if it's not, that's a tangential problem that should be fixed to match 
> the Windows behavior for battery detection.

OK, so do we have any proof that anything in addition to the sound thing
is broken by returning 2 from _REV?

If not, then we're probably spending too much time discussing this.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
