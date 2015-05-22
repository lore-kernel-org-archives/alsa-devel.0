From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Fri, 22 May 2015 03:02:56 +0200
Message-ID: <2151643.NYQBfFsFjv@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <6154326.X9FC8ZVDIy@vostro.rjw.lan> <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@coreos.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday, May 21, 2015 11:10:20 AM Matthew Garrett wrote:
> On Wed, May 20, 2015 at 6:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > Which doesn't explain why we need a config option per quirk.  To me, such config
> > options don't add any value, because (a) everyone will set them anyway and (b)
> > removing the quirks from the source is trivial if needed.
> 
> We'd disable this quirk in Fedora the moment jack detection works,
> because we've got the userspace to handle it and using I2S is
> preferable to using HDA - but in doing so we might break battery
> detection on the other Dell that's playing _REV tricks. This seems
> like a suboptimal choice to have to make.

What about removing the quirk from the table in that case?  Do we
really need a special config option around it?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
