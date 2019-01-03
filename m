From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Thu, 3 Jan 2019 13:43:32 +0100
Message-ID: <CAJZ5v0gZk-ft7Z+oRx+wxeoD2gEuuN-k52C-QqJNXUORHOa2HQ@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
 <20190103123352.GQ1846@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF88267B2D
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 13:43:45 +0100 (CET)
Received: by mail-ot1-f66.google.com with SMTP id 40so29238466oth.4
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2019 04:43:45 -0800 (PST)
In-Reply-To: <20190103123352.GQ1846@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 3, 2019 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jan 02, 2019 at 06:10:35PM +0000, Sinan Kaya wrote:
>
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> > on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> > IOSF_MBI driver.
>
> I still don't understand what's going on with dependencies here and
> still don't have the cover letter or anything :( .  As far as I can tell
> the above commit is in Linus' tree so I'd expect I can just apply it
> directly

Yes, you can.

> but you were saying that this needs to go via some other tree
> so I'm a bit confused as to what's going on here.

I guess Sinan wanted it to go in via the ACPI tree like 5d32a66541c4,
but that of course isn't necessary.

If you want to pick up anything from this series, please do.  I will
pick up what's left. :-)
