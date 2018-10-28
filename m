From: Mutz Heuer <mutz.heuer@gmail.com>
Subject: [USB-Audio - PX USB,
 playback] snd-usb-audio: probe of 2-3:1.0 failed with error -22
 after kernel upgrade
Date: Sun, 28 Oct 2018 22:00:35 +0100
Message-ID: <CAHU8kApb6us8A4r9vwzZaM+Y7BQoty0HqXARJXLpQJqjv0OMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 304212675BA
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2018 22:00:47 +0100 (CET)
Received: by mail-lf1-f65.google.com with SMTP id c16so4526960lfj.8
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2018 14:00:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

USB-Audio Connection on Bowers & Wilkens PX Bluetooth Headphones started
working when upgrading kernel from 4.13 to 4.15 series. Then it suddenly
stopped working again on newer kernels. The bug report has been generated
on the latest working mainline kernel 4.15.7. All newer kernels have some
usb quirks in place, which should fix the playback sample rates to 48 kHz.
The quirk seems not to be working correctly - it seems to hinder the audio
system to recognize the USB-device as a sound device.

The Headphones work on kernels before 4,15.7 when manually configuring
pulseaudio to a default samplerate of 48 kHz.

PX Headphones are on the newest firmware level.

See https://patchwork.kernel.org/patch/10265345/. Dropping that patch and
recompiling the kernel leads to a situation where alsa and pulseaudio seem
to to be working again.

Adding

      default-sample-rate = 48000

to /etc/pulse/daemon.conf leads to working headphones.

Maybe the patch has to be adjusted to newer firmware? A quirk seems to be
really necessary to avoid the specific patch to daemon.conf.


More details can be found in
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1773697
What would be the best way to proceed?
