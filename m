From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH 15/15] ACPI/thinkpad: Fix wrong <acpi/acpi.h>
 inclusion in Thinkpad ACPI users.
Date: Wed, 18 Dec 2013 09:41:17 -0200
Message-ID: <20131218114117.GB29631@khazad-dum.debian.net>
References: <cover.1387336613.git.lv.zheng@intel.com>
 <f82182940fe88b1b6428eecc2df1cb1684f0ca80.1387336613.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f82182940fe88b1b6428eecc2df1cb1684f0ca80.1387336613.git.lv.zheng@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 18 Dec 2013, Lv Zheng wrote:
> CONFIG_ACPI dependent code should include <linux/acpi.h> instead of
> directly including <acpi/acpi.h>.  This patch cleans up such wrong
> inclusions for Thinkpad ACPI users.

...

>  drivers/platform/x86/thinkpad_acpi.c |    1 -
>  include/linux/thinkpad_acpi.h        |    2 ++
>  sound/pci/hda/patch_conexant.c       |    1 -
>  sound/pci/hda/patch_realtek.c        |    1 -

I'd prefer if you left the include outside of thinkpad_acpi.h, and just fix
the include in the two ALSA users.

We might add some extra stuff to thinkpad_acpi.h someday, and not everything
thinkpad_acpi does that might be useful to export to other areas of the
kernel would require acpi.h.

Looking at patch_conexant and patch_realtek, it might be better to actually
move the "am I running on a thinkpad" stuff they use acpi.h for into
thinkpad_acpi, and provide a prototype for that in thinkpad_acpi.h.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
