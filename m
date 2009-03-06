From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No headphone output on HT Omega Claro Halo
Date: Fri, 06 Mar 2009 11:24:51 +0100
Message-ID: <49B0F9F3.2060208@ladisch.de>
References: <49B0965A.1040208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6DFF92438A
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 11:24:56 +0100 (CET)
In-Reply-To: <49B0965A.1040208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Christopher J. Atherton" <the8lack8ox@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christopher J. Atherton wrote:
> I have an HT Omega Claro Halo (CMI8878) card that is not entirely
> working.  This card has two analog outputs, a pair of RCA connectors and
> also a separate headphone output (3.5mm jack).  The RCA outputs work,
> but the headphone output, which notably passes a signal from a built in
> headphone amp, does not.

Please try this patch:

--- linux/sound/pci/oxygen/oxygen.c
+++ linux/sound/pci/oxygen/oxygen.c
@@ -200,6 +200,8 @@ static void halo_init(struct oxygen *chip)
 {
 	ak4396_init(chip);
 	ak5385_init(chip);
+	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL, 0x100);
+	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, 0x100);
 }
 
 static void generic_cleanup(struct oxygen *chip)
