From: VDR User <user.vdr@gmail.com>
Subject: NVIDIA HDMI surround sound is broken starting with
	kernel 2.6.36
Date: Mon, 31 Jan 2011 09:38:51 -0800
Message-ID: <AANLkTikFWjahA8TcGzTuWjkvkvg4chA0Q7s-1nXj179e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B9027103874
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 18:38:55 +0100 (CET)
Received: by iye19 with SMTP id 19so5676756iye.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 09:38:51 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The behavior described below started with 2.6.36 and follows through
up to the most recent stable kernel, 2.6.37.  The last properly
working driver is in kernel 2.6.35.9.  I should also mention that
while the tests below use the static_hdmi_pcm flag recently introduced
to alsa git, I also tested with the in-kernel drivers for each stable
kernel.  The particular device used for testing is an Nvidia GT220
video card connected directly to my receiver via HDMI.

Can someone please look into this?

Tested:
cold boot, kernel 2.6.37, alsa snapshot jan.25,2010,
static_hdmi_pcm=1, receiver ON

cold boot, kernel 2.6.37, alsa snapshot jan.25,2010,
static_hdmi_pcm=1, receiver OFF

cold boot, kernel 2.6.37, alsa snapshot jan.25,2010,
static_hdmi_pcm=0, receiver ON

cold boot, kernel 2.6.37, alsa snapshot jan.25,2010,
static_hdmi_pcm=0, receiver OFF

In all cases only the front-left and front-right speakers worked.
LFE, rear-left, rear-right, and center were missing.  ELD correctly
reported channels corresponding to receiver ON/OFF. (receiver on=7.1,
receiver off=tv stereo).

Also, even though the eld file is removed, the eld info is _not_
updated when stopping alsa & unloading drivers, then reloading.  A
reboot is required to get the eld info to update.  This is why I cold
boot the pc for each test.

With kernel 2.6.35.9 drivers, front-left & front-right worked with
receiver OFF as expected.  I then turn the receiver on and all
channels worked.  I didn't bother to stop alsa, reboot, or even look
at eld info since it works.

Thanks for any & all help,
Derek
