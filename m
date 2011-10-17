From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: /dev/dsp open failure
Date: Mon, 17 Oct 2011 14:07:38 +0530
Message-ID: <CAODvfaFr-GiT1N=t3m9ZexdFQT00un5S2dX+uqMn-cN9=D4mGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f171.google.com (mail-yx0-f171.google.com
	[209.85.213.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B354D24378
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 10:37:39 +0200 (CEST)
Received: by yxl11 with SMTP id 11so3010882yxl.30
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 01:37:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have developed a audio driver in ALSA model, the audio ic is
interfaced with the TI DM365 processor MCBSP ports. I am working with
the 2.6.32 kernel.

I am able to play the audio using the aplay command.  but when i try
to open the device using /dev/dsp i am getting the -ve value. it fails
to open the device.

when i check the

>> ls /dev/dsp

it is available in the device directory.

I have enabled the Sound OSS related options in the kernel menuconfig.
with the same options i am able to open the device for the tlv320aic3x
device.

Could anyone please suggest where i am doing wrong? and help to solve
this problem.

One more observation :

after doing aplay i am able to open the device using the /dev/dsp.

if try to open the device using the /dev/dsp before aplay i am getting
the error.

could you please tell me where i am doing.

-Sreedhar.
