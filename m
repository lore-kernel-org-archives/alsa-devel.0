From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] hda_intel: Add Oaktrail identifiers
Date: Wed, 04 Jan 2012 10:22:45 +0100
Message-ID: <4F041A65.9080802@canonical.com>
References: <20111228151715.2032.87840.stgit@bob.linux.org.uk>
	<s5hzke8n0o6.wl%tiwai@suse.de>
	<20111231170001.22cdabdd@pyramind.ukuu.org.uk>
	<4F0210CE.1020007@canonical.com>
	<20120103230609.1e3a71ed@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050407000008040100030201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A94A103A4D
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 10:22:53 +0100 (CET)
In-Reply-To: <20120103230609.1e3a71ed@pyramind.ukuu.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050407000008040100030201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2012 12:06 AM, Alan Cox wrote:
>> Btw, you seem to be employed by Intel these days? [1] Any chance you can
>> talk to your firmware developers of this chip? I assume somebody at
>> Intel should know what method to prefer. That would be the safest/best
>> option IMHO.
>
> Indeed I am and by the time I got around to looking at it other Intel
> folsk on the list were already digging. Yes we think it needs the same
> settings as Poulsbo.

Ok, thanks. Let's start there, then. Takashi, would you mind committing 
the attached patch?

Also, we could consider sending both patches to stable as well?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050407000008040100030201
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Use-LPIB-position-fix-for-Oaktrail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Use-LPIB-position-fix-for-Oaktrail.patch"

>From a7c7074e3b9fb993a5e551a911dcd7ec6fba5082 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 4 Jan 2012 10:12:54 +0100
Subject: [PATCH] ALSA: HDA: Use LPIB position fix for Oaktrail

According to the thread on alsa-devel, the LPIB method is to prefer
for Oaktrail controller chip.

Reference: http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/047800.html

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bd447b6..8e232ab 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2997,7 +2997,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Poulsbo */
 	{ PCI_DEVICE(0x8086, 0x080a),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE},
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Oaktrail */
 	/* ICH */
 	{ PCI_DEVICE(0x8086, 0x2668),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-- 
1.7.5.4


--------------050407000008040100030201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050407000008040100030201--
