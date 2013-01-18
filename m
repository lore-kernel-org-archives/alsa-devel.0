From: Robin Gareus <robin@gareus.org>
Subject: Focusrite Scarlett 18i6 mixer
Date: Fri, 18 Jan 2013 05:05:15 +0100
Message-ID: <50F8C9FB.3010200@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
 by alsa0.perex.cz (Postfix) with ESMTP id DD401261658
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 05:05:22 +0100 (CET)
Received: from [10.8.0.6] (rg42.org [85.214.110.134])
 by smtp.strato.de (joses mo29) (RZmta 31.12 AUTH)
 with ESMTPA id u07fbcp0I3Kez8 for <alsa-devel@alsa-project.org>;
 Fri, 18 Jan 2013 05:05:21 +0100 (CET)
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

Hi,

I've started to reverse engineer the 18i6 mixer protocol and came up
with a proof-of-concept test script which includes documentation:

  https://github.com/x42/scarlettmixer

Except for a few fixed controls and switches, the 18i6's mixer and
router is [likely] too complex to be exposed via ALSA's mixer interface.
AFAICT it'll require a dedicated control application - like hdspmixer -
in order to make full use of it.

The current proof-of-concept uses pyUSB to send URB control messages and
therefore requires root access. It will also not work while the device
is in use (by snd-usb-audio). A dedicated ioctl interface - similar to
SNDRV_HDSP_ - should be added to ALSA. However, it is yet unclear to me
how much of the protocol should be moved to kernel-space.

Anyway, the script can be used to configure the device, save settings to
it and subsequently use those settings with snd-usb-audio and Martin's
patch.

Thoughts, comments?
robin

PS. the same protocol may apply to other Focusrite Scalett USB2 devices
such as the 8i6 - some of the factory-reset traces hint at that, but I
would not know.
