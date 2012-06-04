From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: [Q] Writing an alsa module for usb audio & video
	capture device
Date: Mon, 4 Jun 2012 18:50:06 -0300
Message-ID: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 60B8D24367
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 23:50:07 +0200 (CEST)
Received: by ghbg24 with SMTP id g24so1727714ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 14:50:06 -0700 (PDT)
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

Hi everyone,

I'm writing a driver for stk1160 usb bridge (audio & video capture device).
The video part is almost done [1] and now I've started the alsa part.

As the driver replaces an in-tree staging driver I could just grab the alsa part
from the original driver (called easycap), or look into em28xx sources.

But as I want to learn a thing or two in this life, I've decided to
take a look at sound drivers first.
Currently I'm reading through sound/usb/6fire driver (picked randomly).

I would like to know: do you have any suggestions and/or hints in
order to write a *nice* driver?
What driver would you consider as being a *correct* usb sound capture
implementation?

[1] http://patchwork.linuxtv.org/patch/11577/

Thanks,
Ezequiel.
