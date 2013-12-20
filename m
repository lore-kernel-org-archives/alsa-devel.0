From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [alsa-devel] [RFC PATCH 15/15] ACPI/thinkpad: Fix wrong
 <acpi/acpi.h> inclusion in Thinkpad ACPI users.
Date: Fri, 20 Dec 2013 00:28:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802499192@SHSMSX101.ccr.corp.intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
	<f82182940fe88b1b6428eecc2df1cb1684f0ca80.1387336613.git.lv.zheng@intel.com>
	<20131218114117.GB29631@khazad-dum.debian.net> <s5hd2kuux4o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <s5hd2kuux4o.wl%tiwai@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Brown, Len" <len.brown@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi and Henrique

Thanks for reviewing and commenting.

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Takashi Iwai
> Sent: Wednesday, December 18, 2013 9:06 PM
> 
> At Wed, 18 Dec 2013 09:41:17 -0200,
> Henrique de Moraes Holschuh wrote:
> >
> > On Wed, 18 Dec 2013, Lv Zheng wrote:
> > > CONFIG_ACPI dependent code should include <linux/acpi.h> instead of
> > > directly including <acpi/acpi.h>.  This patch cleans up such wrong
> > > inclusions for Thinkpad ACPI users.
> >
> > ...
> >
> > >  drivers/platform/x86/thinkpad_acpi.c |    1 -
> > >  include/linux/thinkpad_acpi.h        |    2 ++
> > >  sound/pci/hda/patch_conexant.c       |    1 -
> > >  sound/pci/hda/patch_realtek.c        |    1 -
> >
> > I'd prefer if you left the include outside of thinkpad_acpi.h, and just fix
> > the include in the two ALSA users.
> 
> Agreed.
> 
> > We might add some extra stuff to thinkpad_acpi.h someday, and not everything
> > thinkpad_acpi does that might be useful to export to other areas of the
> > kernel would require acpi.h.
> >
> > Looking at patch_conexant and patch_realtek, it might be better to actually
> > move the "am I running on a thinkpad" stuff they use acpi.h for into
> > thinkpad_acpi, and provide a prototype for that in thinkpad_acpi.h.
> 
> True, but we don't want to bind with thinkpad_acpi before identified
> that it's a thinkpad, so the code needs to be in hd-audio codec
> driver.
> 

It looks to me like that there is a relationship between two Henrique's suggestions.
His opinion is all ACPI stuff should be bound into thinkpad_acpi.c, that's why he suggested not to include <linux/acpi.h> in <linux/thinkpad_acpi.h>.
So we might address both of them in order to follow.

I'm not sure if your opinion is: the hd-audio codec driver's needs cannot be met by addressing the second comment.
And I'm not the right person that is able to test such code restructuring work.
The target of this patchset is cleaning up wrong <acpi/acpi.h> inclusions, so let me focus on the first comment.

Can I just update this patch with <acpi/acpi.h> inclusions replaced by <linux/acpi.h> inclusions?

Thanks and best regards
-Lv

> 
> thanks,
> 
> Takashi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
