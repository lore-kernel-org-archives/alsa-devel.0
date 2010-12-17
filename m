From: Manu Abraham <abraham.manu@gmail.com>
Subject: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 10:28:03 +0530
Message-ID: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2257410382B
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 05:58:04 +0100 (CET)
Received: by wwe15 with SMTP id 15so268352wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 20:58:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

By now I am a bit confused.

I am seeing a certain pattern in which the callbacks are invoked:

- hw_params()
- prepare()
- trigger(); // Start DMA
- pointer();
            --> gets data after interrupt is handled
- trigger(); // Stop DMA
- prepare();
- trigger(); // Start DMA
- pointer();
           --> gets data after interrupt is handled

..
..

and so on.

Is this the right behaviour that's expected from a function ALSA
capture driver ?
I am trying to understand why there is Start DMA, Stop DMA, Start DMA, Stop DMA
in a cyclic fashion for each of the interrupts in my setup.

Thanks,
Manu
