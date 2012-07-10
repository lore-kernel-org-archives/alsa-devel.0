From: Andreas Gretler <andreasgretler@googlemail.com>
Subject: MX28EVK mainline Patchs-3.5-rc5 sgtl5000 record not
	working
Date: Tue, 10 Jul 2012 18:11:12 +0200
Message-ID: <CAHE2-smjaK0L+yJ3B2eizq1NgMLdHM_dw6XwfGTJ8vtUcL0yDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 187382417E
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 18:11:13 +0200 (CEST)
Received: by ghbg24 with SMTP id g24so148388ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2012 09:11:13 -0700 (PDT)
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

Hi,

i've tested mainline 3.5-Patchs-3.5-rc5 for MX28EVK and it boot up and
work fine.

But I'm not able to record something. Playback works. I also test it
against the old 2.6.35.3 Kernel and there record works.

arecord -l show me this:

**** List of CAPTURE Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


I try record with arecord -d 2 -D hw:0,1 -f dat test.wav , but it
crash the Linux. No ErrMsg printed and the board stop working.
I have no idea what goes wrong. I put some printk message in
mxs-saif.c and the last message i can see before the board crash is in
mxs_saif_trigger() is before clk_enable is called.

		/*
		 * If the saif's master is not himself, we also need to enable
		 * itself clk for its internal basic logic to work.
		 */
		if (saif != master_saif) {
			clk_enable(saif->clk);
			__raw_writel(BM_SAIF_CTRL_RUN,
				saif->base + SAIF_CTRL + MXS_SET_ADDR);
		}

 In alsamixer i can not toggle the capture source from Mic-In to
Line-in and also can't change the Headphone from DAC to Line-IN.

I'm not sure this is the right place to ask? I will also post it to
linux-arm-kernel@lists.infradead.org.
Can anyone confirm the Problem? Or do/understand I something wrong
with record and there is no Problem?

Andreas Gretler
