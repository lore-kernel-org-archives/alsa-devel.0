From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 21 May 2015 11:10:20 -0700
Message-ID: <CAPeXnHv07HkvcHrYFmZMr8OTp7U7F=k_k=LPYnUtp89iPn2d2Q@mail.gmail.com>
References: <20150517174144.GA17503@light.dominikbrodowski.net>
	<3695901.X9t2lWziuY@vostro.rjw.lan>
	<20150518044711.GA3401@air.dominikbrodowski.net>
	<6154326.X9FC8ZVDIy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <6154326.X9FC8ZVDIy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2015 at 6:24 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> Which doesn't explain why we need a config option per quirk.  To me, such config
> options don't add any value, because (a) everyone will set them anyway and (b)
> removing the quirks from the source is trivial if needed.

We'd disable this quirk in Fedora the moment jack detection works,
because we've got the userspace to handle it and using I2S is
preferable to using HDA - but in doing so we might break battery
detection on the other Dell that's playing _REV tricks. This seems
like a suboptimal choice to have to make.
