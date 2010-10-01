From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Microphone not working on PCI ID 8086:3b56
Date: Fri, 1 Oct 2010 10:15:48 +0800
Message-ID: <20101001021548.GA7115@localhost>
References: <Pine.LNX.4.64.1009302047410.25061@boston.corp.fedex.com>
	<s5hsk0rtlun.wl%tiwai@suse.de>
	<AANLkTinT3EU3aLSBt5WmA=qDOf1cFABUNG+RiT3Nvx3e@mail.gmail.com>
	<s5h4od7tf43.wl%tiwai@suse.de> <20100930154557.GD11399@localhost>
	<AANLkTinnTeseJY4RDuGNkTjNE--QJ0Mw_S8FVKy_RT7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 59F4F1039A7
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 04:15:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinnTeseJY4RDuGNkTjNE--QJ0Mw_S8FVKy_RT7h@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 01, 2010 at 02:08:09AM +0800, Jeff Chua wrote:
> On Thu, Sep 30, 2010 at 11:45 PM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> 
> > As a kindly reminder, these verbose options are pretty useful:
> >
> > CONFIG_SND_VERBOSE_PROCFS=y
> > CONFIG_SND_VERBOSE_PRINTK=y
> > CONFIG_SND_DEBUG=y
> > CONFIG_SND_DEBUG_VERBOSE=y
> 
> Attached alsa log and dmesg with above enabled.

Jeff, this should make your mic work.

Thanks,
Fengguang

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index a6c68cb..c0c2b33 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3110,6 +3110,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD),
+ 	SND_PCI_QUIRK(0x17aa, 0x2156, "Lenovo X201s", CXT5066_THINKPAD),
  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
  	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x390a, "Lenovo S10-3t", CXT5066_IDEAPAD),
