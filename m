From: Travis Place <wishie@wishie.net>
Subject: Issue with onboard sound on Toshiba A110-225
Date: Mon, 13 Oct 2008 04:59:58 +1000
Message-ID: <200810130459.58966.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id DC42624423
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 21:00:18 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 8F2D0EBD10
	for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2008 19:26:20 +1000 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey all,

When working out an issue for a person in #alsa, i found that the onboard 
sound in their laptop (A110-225) has the Subsystem IDs 1179:ff01 . The card 
has an ALC861 codec.. the issue (non-fatal thankfully) is that the above 
mentioned Subsystem IDs match in patch_realtek.c to 'dallas' which is for an 
ALC861VD codec..

	SND_PCI_QUIRK(0x1179, 0xff01, "DALLAS", ALC861VD_DALLAS),

The user was getting the non-fatal:
	
	hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

in dmesg..

I had the user force the 'toshiba' model (which is valid for ALC861) and the 
warning went away, and sound continues to work as it should..

Just wanted to make sure this problem (even though non-fatal) is documented, 
and we are aware of it. Perhaps this laptop, and the 'Dallas' need to be 
matched on some other level.

Thanks,
Travis Place (wishie)
