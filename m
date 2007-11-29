From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] sound/isa: kill pnp_resource_change.
Date: Thu, 29 Nov 2007 12:30:23 -0700
Message-ID: <200711291230.24323.bjorn.helgaas@hp.com>
References: <474E1189.9030701@keyaccess.nl>
	<200711290920.05010.bjorn.helgaas@hp.com>
	<474EF871.7090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g4t0014.houston.hp.com (g4t0014.houston.hp.com [15.201.24.17])
	by alsa0.perex.cz (Postfix) with ESMTP id CFB672432F
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 20:30:30 +0100 (CET)
In-Reply-To: <474EF871.7090400@gmail.com>
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

On Thursday 29 November 2007 10:35:45 am Rene Herman wrote:
> On 29-11-07 17:20, Bjorn Helgaas wrote:
> 
> > On Wednesday 28 November 2007 06:10:33 pm Rene Herman wrote:
> 
> >> This removes the pnp_resource_change use from the ALSA ISAPnP drivers. In
> >> 2.4 these were useful in providing an easy path to setting the resources,
> >> but in 2.6 they retain function as a layering violation only.
> >>
> >> This makes for a nice cleanup (-550 lines) of ALSA but moreover, ALSA is the
> >> only remaining user of pnp_init_resource_table(), pnp_resource_change() and
> >> pnp_manual_config_dev() (and, in fact, of "struct pnp_resource_table") in
> >> the tree outide of drivers/pnp itself meaning it makes for more cleanup
> >> potential inside the PnP layer.
> > 
> > I think this is great and will certainly clean up the PNP interfaces.
> > 
> > But are you removing functionality that people need?  I don't know
> > anything about ALSA, but we have to assume that some BIOSes supply
> > incorrect resource information.  If you remove all these module
> > parameters, is there still a way to workaround the BIOS defects?
> 
> Yes, sure, by just echoing resource values into sysfs files as a direct 
> replacement (ie, doing the same thing at the PnP layer directly) and 
> possibly by adding quirks for any definite and standing issues. We already 
> have a few of those in fact for SB16, AWE32 and CMI8330 chips, in 
> drivers/pnp/quirks.c.

OK, good.

Anyone who relies on the manual settings will have to change the
way it's done, so maybe the changelog and documentation update
should include some text along the lines of:

  - this removes module parameters for ISAPNP ALSA resources
  - the drivers *should* work with no manual resource settings
  - if you need manual resource settings (usually to work around
    a broken BIOS),
      - please report the problem in the Drivers/PNP component at
        http://bugzilla.kernel.org/enter_bug.cgi and attach the
        dmesg log, /proc/{interrupts,iomem,ioports} contents,
        dmidecode output, and broken and working resource settings
      - work around the problem by echoing resource settings directly
        into the sysfs resource file, e.g.,
          # cd /sys/devices/pnp0/00:06
          # cat resources > /tmp/resources
          # <edit resource settings in /tmp/resources>
          # cat /tmp/resources > resources
          # modprobe <driver>

Bjorn
