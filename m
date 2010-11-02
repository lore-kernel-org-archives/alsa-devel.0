From: Benjamin BERTRAND <beenje@xboxmediacenter.com>
Subject: sound over HDMI on AppleTV (1G) with nvidia drivers
Date: Tue, 2 Nov 2010 19:25:29 +0100
Message-ID: <A882A934-20C3-40A3-AEAF-6FC07CE05FEE@xboxmediacenter.com>
Reply-To: beenje@xbmc.org
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id AFBB4243E4
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 19:25:35 +0100 (CET)
Received: by ewy22 with SMTP id 22so3541342ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 11:25:32 -0700 (PDT)
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

Currently to get sound over HDMI on AppleTV (1st generation) (with linux of course), NVIDIA 100.14.19 drivers are required (and they compile only on Ubuntu 8.04).
It doesn't work with newer drivers.

I made a few tests with Ubuntu 9.10 + kernel 2.6.32 + alsa-driver 1.0.23 + NVIDIA drivers 256.35
atv uses a SiI1390 chip for HDMI output (and NVidia GeForce Go 7300 / G72 pci-express chipset).
In current alsa-driver, SiI1390 uses the ATI HDMI codec which hasn't been updated in a while.
So I patched alsa-driver to use the INTEL HDMI codec instead.

After boot, and before starting X, I have sound (tested with aplay).
See alsa-info log here: http://pastebin.com/dsaqnDKb

As soon as I start X, no more sound. alsa-info log here: http://pastebin.com/fHqyJw6Q

Trying to mute - unmute with alsamixer (it puts the digital output back to enable) or reloading the driver doesn't help. Can't get any sound with X.

One thing I noticed is that the function hdmi_intrinsic_event is never called. I never get any "HDMI hot plug event". So monitor_present and eld_valid are never set. Not sure this is really relevant, but that's where I got stuck so far.
Is the HDMI output disabled because alsa doesn't give the right information?

Any advice? 
What more could I test?

Thanks

Benjamin
