From: Chakravarthi Pradeep <doubleq7@gmail.com>
Subject: How to inform application about sample rate changed
	from device.
Date: Mon, 3 Dec 2018 16:50:29 +0530
Message-ID: <CALW20Z03dWeGNjZJpPaN=aH2xwDtSJCi=VU0uKYw77Yx9ureqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8779726770D
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2018 12:20:43 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id 101so6305650pld.6
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2018 03:20:43 -0800 (PST)
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

Hi All,

I'm working in FPGA device, which can provide raw video and pcm data.
I'm using v4l2 and alsa framework for video and audio respectively.
Audio flow path is using ALSA framework and video flow path is using
v4l2 framework. Device can generate different audio sample rate such
as 44.1KHz, 48KHz and 96KHz.

VLC can render video and audio smoothly with 48KHz of sample rate, 2
channel and video with FHD(1920x1080).

When device is set with 44.1KHz and 96KHz then vlc audio is
breaking.I'm using vlc version as 2.2.8 and there is no way to inform
how to set the sample rate for audio device.

Below are queries:

1) When device is generating audio sample rate of 44.1KHz then how to
inform VLC that use 44.1KHz sample rate(same is for 96KHz)

2) what is command for vlc with video and audio device setting for
width=1920 height= 1080 colorspace = RV24, channel =2,sample rate
44.1KHz. Assume video device is (/dev/video0 and audio device is
hw:1.0)


-- 
Thanks and Regards
Chakravarthi Pradeep.K
Ph: 91 9980434900
