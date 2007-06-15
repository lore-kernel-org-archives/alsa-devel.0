From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda-intel without headphone output
Date: Thu, 14 Jun 2007 19:26:14 -0700
Message-ID: <1181874374.12385.203.camel@razman.gruemaster.com>
References: <20070614083156.GB26945@sandbender>
	<s5h8xamk612.wl%tiwai@suse.de>  <20070614182703.GA9443@sandbender>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RswdAy6OXp0V6vNawFDg"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C2E3524341
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 04:26:16 +0200 (CEST)
In-Reply-To: <20070614182703.GA9443@sandbender>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Lemmen <robertle@semistable.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-RswdAy6OXp0V6vNawFDg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch should take care of your system.

Summary:  hda-codec:  Add Fujitsu Siemens v3515 support to
patch_conexant.

This patch adds support for the Fujitsu Seimens Amilo Pro v3515
notebook.

Signed off by:  Tobin Davis <tdavis@dsl-only.net>

On Thu, 2007-06-14 at 20:27 +0200, Robert Lemmen wrote:

> On Thu, Jun 14, 2007 at 03:41:13PM +0200, Takashi Iwai wrote:
> > The conexant codec is much better supported on ALSA 1.0.14.
> > Give it a try first.
> 
> and i thought my alsa version was recent :P
> 
> this did the trick in combination with model=laptop, other models didn't
> work. thanks for the help, and if there is any additional information
> you need in order to make the driver autodetect the model in future
> versions (if such a thing is possible), just tell me.
> 
> thanks again  robert
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-RswdAy6OXp0V6vNawFDg
Content-Disposition: attachment; filename=conexant-FS3515.patch
Content-Type: text/x-patch; name=conexant-FS3515.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d2662f0d43b1 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Thu May 31 09:09:20 2007 +0200
+++ b/pci/hda/patch_conexant.c	Thu Jun 14 19:22:53 2007 -0700
@@ -802,6 +802,7 @@ static struct snd_pci_quirk cxt5045_cfg_
 	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
+	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_FUJITSU),
 	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
 	{}
 };

--=-RswdAy6OXp0V6vNawFDg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-RswdAy6OXp0V6vNawFDg--
