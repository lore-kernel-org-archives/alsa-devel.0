From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Sat, 14 Apr 2018 12:45:12 +0200
Message-ID: <20180414104512.GA27158@wunner.de>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.90.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 27884266BBC
 for <alsa-devel@alsa-project.org>; Sat, 14 Apr 2018 12:45:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > >>@@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,
> > >>struct pci_dev *pci,
> > >> 	if (err < 0)
> > >> 		return err;
> > >>
> > >>+	if (check_dell_switchable_gfx(pci)) {
> > >>+		pci_disable_device(pci);
> > 
> > Now looking at it again... This code disables all ATI and NVIDIA sound
> > cards available in any Dell System (laptop or AIO) if system says that
> > SG is enabled, right?
> > 
> > It means that also any external ATI or NVIDIA PCI card with audio device
> > connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> > unconditionally disabled too?
> 
> I never thought of this case, thanks for bringing this up.
> Do you have any suggestion to check if it connects to the system via
> Thunderbolt?

Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
like this:

if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))


> >>>+	/* Only need to check for Dell laptops and AIOs */
> >>>+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
> >>>+	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> >>>+	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> >>>+	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
> >>>+	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
> >>>+		return false;

It sure would be nice if someone could add macros for the chassis type
to include/linux/dmi.h so that we don't have to use these magic numbers
everywhere:

$ git grep -l DMI_CHASSIS_TYPE
drivers/firmware/dmi-id.c
drivers/firmware/dmi_scan.c
drivers/input/keyboard/atkbd.c
drivers/input/serio/i8042-x86ia64io.h
drivers/platform/x86/asus-wmi.c
drivers/platform/x86/dell-laptop.c
drivers/platform/x86/samsung-laptop.c
include/linux/mod_devicetable.h
scripts/mod/file2alias.c

Thanks,

Lukas
