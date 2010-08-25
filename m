From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Add Sony VAIO quirk for ALC269
Date: Wed, 25 Aug 2010 10:33:13 +0200
Message-ID: <4C74D549.4000705@canonical.com>
References: <4C736D35.6000003@canonical.com>
	<1282638540.5459.0.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802040905060106010704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5132410384F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 10:33:14 +0200 (CEST)
In-Reply-To: <1282638540.5459.0.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050802040905060106010704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2010-08-24 10:29, Paul Menzel skrev:
> Am Dienstag, den 24.08.2010, 08:56 +0200 schrieb David Henningsson:
>> The attached patch enables playback on a Sony VAIO machine.
>>
>> References:
>> http://launchpadlibrarian.net/53762567/Card0.Codecs.codec.0.txt
>> http://launchpadlibrarian.net/53762571/PciMultimedia.txt
>> https://bugs.launchpad.net/bugs/618271
> 
> Maybe add these references to the commit message too?

Sure. I'll add the buglink only, since that one in turn points to the
other ones. Does this one look better?

Learning slowly, aren't I? :-)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050802040905060106010704
Content-Type: text/x-patch;
 name="0004-Add-Sony-VAIO-quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-Add-Sony-VAIO-quirk.patch"

>From 1130bd522e5e57aeb4ee847f64ed8e3be32665be Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 23 Aug 2010 08:14:35 +0200
Subject: [PATCH] ALSA: HDA: Add Sony VAIO quirk for ALC269

BugLink: http://launchpad.net/bugs/618271
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a4dd045..627bf99 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14467,6 +14467,7 @@ static const struct alc_fixup alc269_fixups[] = {
 
 static struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9071, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
+	SND_PCI_QUIRK(0x104d, 0x9077, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	{}
 };
 
-- 
1.7.0.4


--------------050802040905060106010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050802040905060106010704--
