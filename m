From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Tue, 1 Feb 2011 01:49:37 +0000
Message-ID: <AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id DFD33245AA
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 02:50:03 +0100 (CET)
Received: by qyk34 with SMTP id 34so3693852qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 17:50:02 -0800 (PST)
In-Reply-To: <AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Because ubuntu had disabled OSS emulation , you have to disable OSS
> emulation too.
>
> ./configure --with-oss=no

Thanks for the tip. I've compiled the 1.0.24 drivers tarball using
./configure --with-debug=full --with-oss=no and it now loads
correctly. I have a large number of controls in alsamixer, having set
model=test in /etc/modprobe.d/alsa-base.conf.

The control names are now generic, but I have found that LOUT1 is the
headphones and LOUT2 is the speakers. There are also GPIO pins 0-3
available. I have tried toggling these, but it does not affect the
jack sense, which still does not operate.

The new alsa-info is at the following URL:
http://www.alsa-project.org/db/?f=3fb1a67066b9d06ac8405685ff7358af053e2668

How should I proceed? I've looked at the pci/drivers/hda_intel.c, and
I notice that several "quirk" modes are enabled for particular models.
Is it sensible to try enumerating these on my laptop, or are tables
like this:

   SND_PCI_QUIRK(0x1025, 0x009f, "Acer Aspire 5110", POS_FIX_LPIB),
   SND_PCI_QUIRK(0x1025, 0x026f, "Acer Aspire 5538", POS_FIX_LPIB),
   SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
   SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_LPIB),
   SND_PCI_QUIRK(0x1028, 0x01f6, "Dell Latitude 131L", POS_FIX_LPIB),

changing different addresses for each laptop model?

Thanks again for your help so far.
