From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Thu, 29 Nov 2007 09:20:04 -0700
Message-ID: <200711290920.05010.bjorn.helgaas@hp.com>
References: <474E1189.9030701@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	by alsa0.perex.cz (Postfix) with ESMTP id C340824470
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 17:20:09 +0100 (CET)
In-Reply-To: <474E1189.9030701@keyaccess.nl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "yakui.zhao" <yakui.zhao@intel.com>, "Li,
	Shaohua" <shaohua.li@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 28 November 2007 06:10:33 pm Rene Herman wrote:
> This removes the pnp_resource_change use from the ALSA ISAPnP drivers. In
> 2.4 these were useful in providing an easy path to setting the resources,
> but in 2.6 they retain function as a layering violation only.
> 
> This makes for a nice cleanup (-550 lines) of ALSA but moreover, ALSA is the
> only remaining user of pnp_init_resource_table(), pnp_resource_change() and
> pnp_manual_config_dev() (and, in fact, of "struct pnp_resource_table") in
> the tree outide of drivers/pnp itself meaning it makes for more cleanup
> potential inside the PnP layer.

I think this is great and will certainly clean up the PNP interfaces.

But are you removing functionality that people need?  I don't know
anything about ALSA, but we have to assume that some BIOSes supply
incorrect resource information.  If you remove all these module
parameters, is there still a way to workaround the BIOS defects?

Bjorn
