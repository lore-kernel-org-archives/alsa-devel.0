From: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Subject: basic workflow when playing some sounddata
Date: Tue, 24 Jul 2007 13:51:09 +0530
Message-ID: <46A5B675.5050202@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from john.hrz.tu-chemnitz.de (john.hrz.tu-chemnitz.de
	[134.109.132.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A710103852
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 10:18:40 +0200 (CEST)
Received: from [203.145.183.24] (helo=dexsys58.DOMAIN.dexceldesigns.com)
	by john.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66) (envelope-from <markus.franke@s2002.tu-chemnitz.de>)
	id 1IDFbL-0004bn-SH
	for alsa-devel@alsa-project.org; Tue, 24 Jul 2007 10:18:40 +0200
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

Dear Alsa-Developers,

I am very new to Alsa driver development and have some problems to get a
clue how the process of playing sounddata works. Let me explain my point
of view and it would be nice if anybody could give some clarifications
and corrections on it.

Suppose I want to play a *.wav file from userspace with "aplay". After
triggering all the configuration functions for PCM and the DAI at some
point the chip_pcm_trigger() function get's called. As per "Writing Alsa
Drivers" the TRIGGER_START command should now do something for "enabling
the PCM engine". As per my understanding this could be for example to
enable the interrupts of my DAI, which is (I2S over GSI) in my case. The
interrupt handler by itself should call snd_pcm_period_elapsed()
whenever a period of sounddata is copied to the device. Furthermore the
so called "hw_pointer" should be updated in the interrupt handler,
right? To make it easy I don't want to use DMA in the beginning. I
simply want to copy the data to the hardware buffer of my DAI (I2S via
GSI) and from there it is copied automatically to my codec. The question
is now, at which place in the alsa framework I have to put the copy
process of the sounddata. It should not be done in the interrupt handler
because this would take to much time. But whereelse could this be done?

Also I don't know the meaning of chip_pcm_pointer() callback. As far as
I could figure out from the source, this function is called whenever
snd_pcm_period_elapsed() is called, right? But what should be done
exactly in this callback. Again I want to say that I don't want to use
DMA at all by now.

I've read already "Writing Alsa Drivers" but the questions above still
remain for me and I am quite confused as you maybe noticed already from
my questions above. ;-) It would be nice if anybody can give me a basic
workflow which functions/callbacks are necessary for the playing part of
an Alsa driver.


Thanks in advance for any help,

Regards,
Markus
