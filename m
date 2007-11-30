From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Fri, 30 Nov 2007 01:49:00 +0100
Message-ID: <474F5DFC.6040507@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl>
	<200711290920.05010.bjorn.helgaas@hp.com>
	<474EF871.7090400@gmail.com>
	<200711291230.24323.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id B8D4E2437A
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 01:49:35 +0100 (CET)
In-Reply-To: <200711291230.24323.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "yakui.zhao" <yakui.zhao@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On 29-11-07 20:30, Bjorn Helgaas wrote:

> OK, good.
> 
> Anyone who relies on the manual settings will have to change the
> way it's done, so maybe the changelog and documentation update
> should include some text along the lines of:
> 
>   - this removes module parameters for ISAPNP ALSA resources
>   - the drivers *should* work with no manual resource settings
>   - if you need manual resource settings (usually to work around
>     a broken BIOS),

Actually, the ALSA drivers with PnPBIOS support (snd-cs4232, snd-es18xx and 
snd-opl3sa2) do not in fact loose any parameters and the few known trouble 
spots there are using

	modprobe snd-foo isapnp=0 port=...

as their workaround, bypassing all of PnP, and this still works completely 
the same as before.

I do not expect any trouble. A few users might have _mistakingly_ added 
parameters to an ISAPnP only (as in, not also PnPBIOS) driver due to 
googling up your generic bad-advice webforum that said that worked for 
someone with a heavy sounding nickname, but we can deal with that.

Moreover, as I've been experiencing on the ALSA list for a while now (where 
I've been somewhat responsive to ISA related issues) basically anything but 
PnPBIOS/ACPI ISA is mostly dead and as said, with an isapnp=0 in the drivers 
there which known issues are using, there's no difference.

Advice is always good, but I'd not put in the ALSA documentation (wrong 
place) and even in the changelog it sounds a bit overly alarming in my own 
opinion. The expected fall-out is... <crickets>...

Rene.
