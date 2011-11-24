From: "Matthias Wieloch" <matthias_wieloch@web.de>
Subject: WM8974 on AT91SAM9263EK
Date: Thu, 24 Nov 2011 14:45:10 +0100
Message-ID: <A63F82CB7CD649AFAF623D416B2C30E9@SWEntwicklung>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E6E5103A90
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 14:45:35 +0100 (CET)
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de
	[172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id 957461AB18790
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 14:45:24 +0100 (CET)
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

Hello,

I hope you can help me find the missing part of my problem.

I would like to the WM8974 sound codec instead of the AC97 codec of the eval
board.

After starting the kernel (2.6.38) no error messages are shown and the sound
card got detected by ALSA. But as soon as I run either aplay or arecord I
run into a timeout due to pcm_write/pcm_read error. Additionally the dmesg
buffer gets messed up.

After analysing with an oscilloscope I'm sure that I2C is working and that
the codecs responses at least with ACK. But I couldn't see any changes on
the SSC lines.
So far I disabled all peripherals and GPIOs that use the same pins as SSC1.
Looking at the register values the SSC peripheral seems not to be
initialised although the application flow is similar to the AT91SAM9g20EK I
based my code on.

What I find strange is that the WM8974 codec does not provide a .set_sysclk
function although most other codecs do. Do I have to call other functions to
set up the SSC or rather where should these be set?

My current source file located in <kernel>/sound/soc/atmel can be found at
http://pastebin.com/mrFFxxdF

Regards Matthias
