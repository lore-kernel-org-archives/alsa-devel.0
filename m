From: James Courtier-Dutton <James@superbug.co.uk>
Subject: E-MU 0404/0202 USB implementation
Date: Mon, 17 Sep 2007 22:34:41 +0100
Message-ID: <46EEF2F1.7030404@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B46824351
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 23:34:43 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.67)
	id 1IXOEs-000A2r-HX
	for alsa-devel@alsa-project.org; Mon, 17 Sep 2007 21:34:42 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am looking to implement support for the E-Mu USB cards.
The card is basically following a mix of USB 1.0 and USB 2.0 descriptors.

The bInterfaceClass field of the standard interface descriptors for the
Audio Control, Audio Streaming, and MIDI Streaming interfaces are set to
0xFF (vendor-specific) instead of 0x01 (USB Audio).

Can I put in a quirk into the snd-usb-audio driver to handle this?

The card also has customised controls. Can one add those to
snd-usb-audio, or would it be better to add those to a totally new driver?

Kind Regards
James
