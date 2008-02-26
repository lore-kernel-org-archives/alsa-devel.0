From: "Isaac Manuel" <isaacjun16@gmail.com>
Subject: ATI HD 2600 Sound?
Date: Tue, 26 Feb 2008 13:32:30 -0800
Message-ID: <31f069e00802261332y2b80f116hdb4a49674f6de616@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E7AAB10382D
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 22:32:36 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 60so3351845wri.8
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 13:32:31 -0800 (PST)
Content-Disposition: inline
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

HP Pavilion HDX9200 Laptop PC
Ubuntu 7.10 (Gutsy Gibbon)
Linux Kernel 2.6.22-14-generic

Sound only play through headphones.

*aplay -l*

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 0: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

*sudo lspci -v

*Audio device: ATI Technologies Inc Unknown device aa08
Subsystem: Hewlett-Packard Company Unknown device 30d4
Flags: bus master, fast devsel, latency 0, IRQ 17
Memory at e8310000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Capabilities: [58] Express Legacy Endpoint IRQ 0
Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
*
**sudo lspci -nv*

0403: 1002:aa08
Subsystem: 103c:30d4
Flags: bus master, fast devsel, latency 0, IRQ 17
Memory at e8310000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 3
Capabilities: [58] Express Legacy Endpoint IRQ 0
Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
