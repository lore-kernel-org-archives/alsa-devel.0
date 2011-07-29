From: "`/ET!-i1S!-i" <yethish7@gmail.com>
Subject: Copy ALSA buffer to the buffer allocated in my driver.
Date: Fri, 29 Jul 2011 20:07:37 +0530
Message-ID: <CAB+ez9vcA5NAqLco8up2oVNpRX=dLd1N_du0QuAQ_aBD0XC3Xg@mail.gmail.com>
References: <4E32C3F4.4050105@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D211037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 16:37:38 +0200 (CEST)
Received: by wwj26 with SMTP id 26so2683439wwj.20
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2011 07:37:37 -0700 (PDT)
In-Reply-To: <4E32C3F4.4050105@globaledgesoft.com>
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

Hi everyone.

I'm writing a virtual ALSA driver for a playback device, with the help of
dummy driver available at the linux kernel source code.

I need to manually copy data from the ALSA buffer to my buffer.

I have no idea how to do this, since dummy driver has completely discarded
handling of buffers.

So can anyone please provide a sample code to copy the audio data to the my
buffer allocated in the driver.

Is it ok to use the hrtimer interrupts (which is used in dummy driver) or
mutex / spinlocks for my driver.

Best regards,

cherry
