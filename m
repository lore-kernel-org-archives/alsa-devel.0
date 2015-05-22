From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Sat, 23 May 2015 00:15:54 +0200
Message-ID: <23116293.JAxziy2cCE@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <2098590.Jj0ekzOVtF@vostro.rjw.lan> <DB6E482E89290547898851B8CC9D8110016A5EBC17@AUSX7MCPS302.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <DB6E482E89290547898851B8CC9D8110016A5EBC17@AUSX7MCPS302.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario_Limonciello@dell.com
Cc: matthew.garrett@coreos.com, linux@dominikbrodowski.net, linux-acpi@vger.kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday, May 22, 2015 04:19:05 PM Mario_Limonciello@Dell.com wrote:
> > OK, so do we have any proof that anything in addition to the sound thing is broken by returning 2 from _REV?
> > 
> > If not, then we're probably spending too much time discussing this.
> 
> From a Dell perspective I'm not aware of anything else breaking, but I'll be sure to raise its attention and any associated details if I become privy to them.  I'm working with architecture to ensure that future products are not relying on _REV values as well.
> I know Matthew had mentioned that another OEM's product was using this as well, but I don't know what for.

OK, here's a deal.

I'll wait for the next few days for someone to tell me if there's any
known system in addition to the XPS 13 (2015) which breaks as a result
of the change to return 2 from _REV.  If none are reported before the
next Friday, I'll just apply the patch I posted some time ago.  If any
reports come in later, we'll still be able to rearrange things during
the 4.2 cycle or even later.

If *something* is reported next week, I'll reconsider the approach depending
on what that thing is.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
