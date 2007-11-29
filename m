From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Thu, 29 Nov 2007 18:34:32 +0100
Message-ID: <474EF828.7010905@keyaccess.nl>
References: <474E1189.9030701@keyaccess.nl>
	<200711290920.05010.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EEE9244A5
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 18:37:00 +0100 (CET)
In-Reply-To: <200711290920.05010.bjorn.helgaas@hp.com>
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
	Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 29-11-07 17:20, Bjorn Helgaas wrote:

> On Wednesday 28 November 2007 06:10:33 pm Rene Herman wrote:

>> This removes the pnp_resource_change use from the ALSA ISAPnP drivers. In
>> 2.4 these were useful in providing an easy path to setting the resources,
>> but in 2.6 they retain function as a layering violation only.
>>
>> This makes for a nice cleanup (-550 lines) of ALSA but moreover, ALSA is the
>> only remaining user of pnp_init_resource_table(), pnp_resource_change() and
>> pnp_manual_config_dev() (and, in fact, of "struct pnp_resource_table") in
>> the tree outide of drivers/pnp itself meaning it makes for more cleanup
>> potential inside the PnP layer.
> 
> I think this is great and will certainly clean up the PNP interfaces.
> 
> But are you removing functionality that people need?  I don't know
> anything about ALSA, but we have to assume that some BIOSes supply
> incorrect resource information.  If you remove all these module
> parameters, is there still a way to workaround the BIOS defects?

Yes, sure, by just echoing resource values into sysfs files as a direct 
replacement (ie, doing the same thing at the PnP layer directly) and 
possibly by adding quirks for any definite and standing issues. We already 
have a few of those in fact for SB16, AWE32 and CMI8330 chips, in 
drivers/pnp/quirks.c.

But the expected use is just no manual settings at all, same as with say 
PCI. I've always been a little disappointed at the ISAPnP bad rep. It's a 
fully sane bus as far as the interface is concerned.

And by the way, real-life issue with sound and PnP seems to be confined to 
older laptops with an onboard Cirrus CS423x advertised through PnPBIOS/ACPI 
  and PnPBIOS/ACPI claiming the resources could not actually be changed, 
which the now removed code tried to do anyway. You were CCed on a report of 
that a while ago. Don't know if that went anywhere but if anything, this 
removal of the problematic code makes it better (probably fixes it fully in 
fact...).

Rene.
