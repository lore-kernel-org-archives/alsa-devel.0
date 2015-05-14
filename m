From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] ACPI: provide an override for _REV
Date: Fri, 15 May 2015 01:56:35 +0200
Message-ID: <3891042.KkPtjJx6jq@vostro.rjw.lan>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net> <1515962.ItIFxq4Pla@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1515962.ItIFxq4Pla@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday, May 14, 2015 10:31:59 PM Rafael J. Wysocki wrote:
> On Thursday, May 14, 2015 03:31:24 PM Dominik Brodowski wrote:
> > As promised, here are a few patches which allow to override the _REV
> > (supported ACPI revision) setting of the ACPI implementation. With
> > this patch in place (and possibly with other quirks added to
> > drivers/acpi/osl.c -- Matthew mentioned the Inspiron 7437), the
> > patch b1ef29725865 can be applied again (or the revert of
> > b1ef29725865 be reverted).
> > 
> > Also throw in a re-ordering of the kernel-parameters Documentation.
> > 
> > Dominik Brodowski (4):
> >   acpi: use same type for acpi_predefined_names values as in definition
> >   acpi: allow for an override to set _REV
> >   acpi: add _REV quirk for Dell XPS 13 (2015)
> >   acpi: fix kernel-parameters ordering in Documentation
> 
> Thanks!
> 
> That's mostly OK, but I have a concern about the command line arg.

I've queued up patches [1/4] and [4/4] for 4.2.

Rafael

