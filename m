From: Eric Lammerts <alsa-devel@lists.lammerts.org>
Subject: Re: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Sun, 21 Nov 2010 20:23:11 -0500 (EST)
Message-ID: <Pine.LNX.4.61.1011212021350.27576@kermit.ultrawaves>
References: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
	<4CE4EDAF.4010200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ultrawaves.com (rrcs-71-43-195-114.se.biz.rr.com
	[71.43.195.114]) by alsa0.perex.cz (Postfix) with ESMTP id 03CF52447B
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 02:23:14 +0100 (CET)
In-Reply-To: <4CE4EDAF.4010200@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Dan Allongo <gongo2k1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Thu, 18 Nov 2010, Clemens Ladisch wrote:
> Thanks.  Please provide a Signed-off-by tag as described in
> Documentation/SubmittingPatches.


CM6206: Turn off de-emphasis channel status bit in S/PDIF output.

Signed-off-by: Eric Lammerts <eric@lammerts.org>

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cf8bf08..3e9d870 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -387,7 +387,7 @@ static int snd_usb_cm106_boot_quirk(struct usb_device *dev)
  static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
  {
  	int err, reg;
-	int val[] = {0x200c, 0x3000, 0xf800, 0x143f, 0x0000, 0x3000};
+	int val[] = {0x2004, 0x3000, 0xf800, 0x143f, 0x0000, 0x3000};

  	for (reg = 0; reg < ARRAY_SIZE(val); reg++) {
  		err = snd_usb_cm106_write_int_reg(dev, reg, val[reg]);
