From: William Weston <weston@sysex.net>
Subject: Re: [Patch] hda-intel: Add quirks for RTL888 &
 RV630/M76 based MSI GX710
Date: Wed, 8 Jul 2009 01:10:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0907080106030.13445@astarte.lysdexia.org>
References: <alpine.LFD.2.00.0906210513170.28136@astarte.lysdexia.org>
	<s5hiqi34rj0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from astarte.lysdexia.org (unknown [207.55.232.252])
	by alsa0.perex.cz (Postfix) with ESMTP id BCD96103898
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 10:10:07 +0200 (CEST)
In-Reply-To: <s5hiqi34rj0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Jul 2009, Takashi Iwai wrote:

> Could you rebase your patch to the latest sound GIT tree?
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> There have been lots of changes in patch_realtek.c, and your patch
> can't be applied cleanly.
>
> Also, don't forget to give your sign-off.
>
>
> thanks,
>
> Takashi

No problem.  Here's the patch rebased to latest sound-2.6.git:

Signed-off-by: William Weston <weston@sysex.net>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index de72b72..0227b0c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8422,6 +8422,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x1462, 0x3fc3, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x3fcc, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x3fdf, "MSI", ALC883_TARGA_DIG),
+	SND_PCI_QUIRK(0x1462, 0x42cd, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4314, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4319, "MSI", ALC883_TARGA_DIG),
  	SND_PCI_QUIRK(0x1462, 0x4324, "MSI", ALC883_TARGA_DIG),
@@ -8435,6 +8436,7 @@ static struct snd_pci_quirk alc882_cfg_tbl[] = {
  	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1462, 0x7350, "MSI", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
+	SND_PCI_QUIRK(0x1462, 0xaa08, "MSI", ALC883_TARGA_2ch_DIG),

  	SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
  	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R", ALC883_CLEVO_M720),
