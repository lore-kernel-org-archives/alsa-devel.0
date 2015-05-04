From: Arijit De <arijit.de@geosemi.com>
Subject: stereo uac device control over mixer
Date: Mon, 4 May 2015 08:34:16 +0000
Message-ID: <1430728456157.40941@geosemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay05.mycloudmailbox.com (relay05.mycloudmailbox.com
 [199.244.76.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 7396E260469
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 10:34:18 +0200 (CEST)
Received: from S05-MBX02-11.S05.local (unknown [10.30.33.82])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by relay05.mycloudmailbox.com (Postfix) with ESMTPS id 3lgHXl60wfzVfhZ
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 04:34:15 -0400 (EDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on a USB audio MIC device(capture device),
implemented UAC1.0 spec inside the firmware for that,
my device is a stereo uac capture? device.
I am trying to enable left and write channel separate control(volume, mute etc.) over mixer interface.

my understanding about how to enable channel specific control is
in UAC Feature Unit Descriptor
if I add bmaControls(0) and bmaControls(1) with correct bitmap for Mute & Volume support
amixer is able to identify my device as a two MIC device,

amixer output for my usb audio capture device
**********************************
Simple mixer control 'Mic',0
  Capabilities: cvolumecaps joined 780
 cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 9 [60%] [27.00dB] [on]
Simple mixer control 'Mic',1
  Capabilities: cvolumecaps joined 780
 cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 15
  Mono: Capture 9 [60%] [27.00dB] [on]
**********************************

is the correct way of achieving it
OR
ideally there should be a single Mic with "Front Left - Front Right" support ?

Thanks
Arijit
