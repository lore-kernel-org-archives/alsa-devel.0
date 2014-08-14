From: Xuebing Wang <xbing6@gmail.com>
Subject: What is the command line commands to use UAC2 at USB
	client side?
Date: Thu, 14 Aug 2014 14:16:30 +0800
Message-ID: <53EC543E.9050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A1ED626565A
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 08:16:36 +0200 (CEST)
Received: by mail-pa0-f51.google.com with SMTP id ey11so1039361pad.38
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 23:16:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-usb-devel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: thomas.besemer@gmail.com, Richard.Jiang@infocus.com
List-Id: alsa-devel@alsa-project.org

Hi Community,

Based on Freescale platform , I am trying to use USB Audio Class version 
2.0.  Host can detect this UAC2 device.

At device side (after modprobe g_audio):

root@imx6slevk:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: wm8962audio [wm8962-audio], device 0: HiFi wm8962-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: imxspdif [imx-spdif], device 0: S/PDIF PCM Playback dit-hifi-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: UAC2Gadget [UAC2_Gadget], device 0: UAC2 PCM [UAC2 PCM]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

At device side, in driver/usb/gadget/Kconfig, it says before for 
CONFIG_USB_AUDIO
-------------------------
           This driver doesn't expect any real Audio codec to be present
           on the device - the audio streams are simply sinked to and
           sourced from a virtual ALSA sound card created. The user-space
           application may choose to do whatever it wants with the data
           received from the USB Host and choose to provide whatever it
           wants as audio data to the USB Host.
-------------------------

My question is: at device side, how to configure sink/source for UAC2 
virtual ALSA sound card (hw:2,0, UAC2_Gadget)?

Thank you very much.

Xuebing Wang
