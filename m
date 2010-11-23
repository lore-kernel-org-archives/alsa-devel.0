From: Ramya Desai <ramya.desai@gmail.com>
Subject: Writing a driver for Sound Card
Date: Tue, 23 Nov 2010 18:17:10 +0530
Message-ID: <AANLkTins58fB33LiFbNpbgAwKWDBtKs71=9ae3D+i+V4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C5C8A103919
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 13:47:12 +0100 (CET)
Received: by iwn2 with SMTP id 2so9770188iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 04:47:12 -0800 (PST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Dear All,

I am new to this Advanced Linux Sound Architecture (ALSA) driver. I developed a
few drivers in Linux kernel environment for PCI based devices which
are of type character and block. I am going through the following link
for writing a driver for my custom sound card.

http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/writing-an-alsa-driver.pdf

I have a doubt about the Linux sound driver architecture. I need to
develop the driver with mixer, player, recorder, MIDI etc. components.
Do I need to develop these components in single driver OR Do I need to
develop as a individual component (one driver for one component).

I looked into the /usr/src/linux-2.6.35/sound directory. I did not
understand it completely. Is there any driver (sample) which I can go
through?

Please let me know.

Any help greatly appreciated and helpful to me.

Thanks and Regards,
Srinivas G
