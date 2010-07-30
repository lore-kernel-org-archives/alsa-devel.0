From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Fixing ALC269 the right way?
Date: Fri, 30 Jul 2010 13:42:32 +0200
Message-ID: <4C52BAA8.4040503@canonical.com>
References: <4C52813D.5090003@canonical.com> <s5hsk31qtih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040609020801060909050209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A51F024591
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 13:42:31 +0200 (CEST)
In-Reply-To: <s5hsk31qtih.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040609020801060909050209
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2010-07-30 10:11, Takashi Iwai skrev:
> At Fri, 30 Jul 2010 09:37:33 +0200,
> David Henningsson wrote:
>>
>> Here's what I try to fix by playing around with it in hda-emu, it seems
>> like more than one thing is broken here, but let's start with playback.
>> This machine has one internal speaker and one line-out. Codec proc file
>> is attached.
> 
> Please give alsa-info.sh output instead.  It'll contain more
> comprehensive information to analyze.

Sorry. I have an alsa-info of a slightly differently machine here:

http://launchpadlibrarian.net/49532111/alsa-info-forrest

The difference is two outputs (one line, one headphone), and two inputs.

> 
>> Here's my analysis so far:
>>
>> 1) If there's one internal speaker and one line-out (rather than
>> headphone-out), should the internal speaker auto-mute? What's standard
>> practice?
> 
> It's just because the pin is a line-out, no headphone (in addition to
> the bug below).
> If the pin is declared as a headphone, the driver turns on the
> auto-mute function.
> 
>> 2) There are two DAC nids, 0x02 and 0x03, but only 0x02 is used (i e
>> activated on playback). But line-out is connected (via nid 0x0d) to DAC
>> 0x03, so there is no sound on line-out.
> 
> Right, it's a missing check of the pin.  

Should that have given a warning message, or is it a normal condition
to ignore pins?

> The pin 0x1b doesn't exist on
> ALC268, so the parser (shared by both ALC268/269) ignored it.
> The one-liner below fixes the problem.

Nice, thanks for spotting! I've attached a signed-off commit that
un-ignores both 0x1b and 0x1a (the latter one used in the alsa-info link
above). Please apply.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040609020801060909050209
Content-Type: text/x-patch;
 name="0005-Add-analog-output-NIDs-used-by-Dell-Optiplex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0005-Add-analog-output-NIDs-used-by-Dell-Optiplex.patch"

>From 4f4cb61722e71283df17d1cc2e1eae0dc404c838 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 30 Jul 2010 10:51:23 +0200
Subject: [PATCH 5/5] Add analog output NIDs used by Dell Optiplex

This patch enables playback on Dell Optiplex XE, 380 and 980.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b4b7f58..0b87715 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -13108,6 +13108,8 @@ static int alc268_new_analog_output(struct alc_spec *spec, hda_nid_t nid,
 		dac = 0x02;
 		break;
 	case 0x15:
+	case 0x1a:
+	case 0x1b:
 	case 0x21: /* ALC269vb has this pin, too */
 		dac = 0x03;
 		break;
-- 
1.7.0.4


--------------040609020801060909050209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040609020801060909050209--
