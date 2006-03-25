From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA] ISA drivers bailing on first !enable[i]
Date: Sat, 25 Mar 2006 01:28:07 +0100
Message-ID: <44248E97.2000900@keyaccess.nl>
References: <44238482.50401@keyaccess.nl> <s5hu09onlzd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060901030309040100050101"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 94FB11DB
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 01:27:06 +0100 (MET)
In-Reply-To: <s5hu09onlzd.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060901030309040100050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>> Assuming this was indeed the idea, I've attached a patch against 2.6.16.
>> If it's correct, but you need it against ALSA CVS instead, please say so
> 
> Yes, these are correct fixes.  Most of them should have been already
> in the latest ALSA tree, i.e. also in Linus git tree now.

I had a feeling I should've checked that when I was composing the message...

> Could you check what's still missing?  I might missed some drivers.

CMI8330 was missing, see attached (generated against -git9). Yes, the 
original patch is still useful for -stable; will submit.

Rene.

--------------060901030309040100050101
Content-Type: text/plain;
 name="alsa_cmi8330_enable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_cmi8330_enable.diff"

Index: linux-2.6.16-git9/sound/isa/cmi8330.c
===================================================================
--- linux-2.6.16-git9.orig/sound/isa/cmi8330.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git9/sound/isa/cmi8330.c	2006-03-25 01:10:37.000000000 +0100
@@ -690,9 +690,9 @@ static int __init alsa_card_cmi8330_init
 	if ((err = platform_driver_register(&snd_cmi8330_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (! enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);

--------------060901030309040100050101--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
