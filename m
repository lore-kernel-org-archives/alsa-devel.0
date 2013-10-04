From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] ASoC: core: Allow DAI links to be specified by using ACPI names
Date: Fri, 04 Oct 2013 19:17:39 +0200
Message-ID: <8087680.MUVDxDi9qT@vostro.rjw.lan>
References: <1380803636-24079-1-git-send-email-jarkko.nikula@linux.intel.com> <1674991.zl8kYFEb4V@vostro.rjw.lan> <524E7062.10405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <524E7062.10405@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Friday, October 04, 2013 10:38:10 AM Jarkko Nikula wrote:
> On 10/04/2013 09:55 AM, Rafael J. Wysocki wrote:
> > You're misreading my suggestion.  What I'm saying is that it seems like
> > it might be useful to have dev_name() return the ACPI name - this would
> > mean that everything, including all the dev_ prints, would use the same
> > name which would then become stable and tied to hardware.
> >> I see. Indeed, this sounds a better idea. At quick look is even more simple.
> > Well, this is slightly ambiguous.  What exactly do you mean by "ACPI names"?
> >
> Ah, yes. What I meant as ACPI name was the <bus_id:instance> based ACPI 
> device name/object (or what is the correct terminology), not the 
> hardware ID.

OK

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
