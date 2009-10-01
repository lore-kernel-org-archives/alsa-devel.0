From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: ioplug plugin programming: HW_PERIOD_BYTES and
 HW_PERIODS constraints ?
Date: Thu, 01 Oct 2009 14:17:16 +0200
Message-ID: <4AC49DCC.7060806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id DE0D910392A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:17:23 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 67A2D4BE06
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:18:11 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j27dUmPp94d3 for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:18:11 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id F0C7D4BE02
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:18:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm currently developing an ALSA ioplug plugin that should transfer
audio samples to a DSP over UART.

In my plugin code I set up the hardware constrains (HW_PERIOD_BYTES and
HW_PERIODS being among them) and then I utilize the transfer callback to
send the audio chunk over UART.

The DSP application would like to have exactly 156 - 164 audio samples
at a time, where the sampling rate has to be 8 kHz and the format is S16_LE.
In between there has to be a delay of 20ms (which is equal to 164 audio
frames at a sampling rate of 8 kHz (i.e. 164 * 125us = 20,5 ms).

For this reason I configured HW_PERIOD_BYTES with these values.
The result is that each time the transfer callback gets called, exactly
312 bytes (thus 164 frames with each one having 2 bytes) are transfered.


However, what I do not understand is the setup of HW_PERIODS which is
AFAIK the number of periods being transfered at a time ?


* What is the influence of this constraint on my ioplug plugin ?

* How does it change the way data is being transfered with the transfer
callback ?

* What would be the correct setup for the mentioned application ?


cheers,
stefan
