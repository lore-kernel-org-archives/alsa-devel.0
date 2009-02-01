From: Frank van de Pol <fvdpol@gmail.com>
Subject: work in progress: USB driver for Behringer BCD 2000
Date: Sun, 1 Feb 2009 22:57:59 +0100
Message-ID: <beefc6ea0902011357k44ede76crf7b1644b4f8a0111@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id E42F11037E3
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 22:57:59 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so465661fge.44
	for <alsa-devel@alsa-project.org>; Sun, 01 Feb 2009 13:57:59 -0800 (PST)
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

I'm currently working on Alsa support for the Behringer BCD 2000, a DJ
control surface (http://www.behringer.com/EN/Products/BCD2000.aspx).
Unfortunate this device does not act as a standard class device. Since
proper technical documentation from Behringer is non-existent my work
is based on analysis of the USB data stream.

Current status:
- driver supports midi input data for all controls/buttons that are
able to send midi data (some of tje controls do not send out data but
are hardwired to the analogue circuitry, eg. headphone volume etc.)

still todo:
	- get the midi-output working to allow control of the LEDs on the
control surface.
	- cleanup of the code (mostly remove debugging stuff)
	- documentation


The unit has also a 4 channel 24-bit audio interface;  at the moment I
have little interest in trying to get this audio interface
operational.

If anyone else on this list has a similar device and would like to
test it please let me know so I can send patches.

Regards,
Frank.
