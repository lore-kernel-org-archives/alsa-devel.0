From: David Henningsson <david.henningsson@canonical.com>
Subject: Radeon unconnected HDMI eats samples at 280 kHz
Date: Wed, 17 Sep 2014 15:40:08 +0200
Message-ID: <54198F38.30002@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D02326536F
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 15:40:10 +0200 (CEST)
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
Cc: anssi.hannula@iki.fi
List-Id: alsa-devel@alsa-project.org

Hi,

While investigating some interesting debug output from PulseAudio, I 
tried to figure out the cause.

 From what I can tell, my Radeon seems to ask for new samples at a very 
high rate, which I estimate to be around 280 kHz. My radeon card has 
DVI, HDMI and VGA connectors, and the only thing connected is my screen 
over DVI.

I'm currently running the 3.13 kernel with updated hda directory from 
Takashi's tree, but I think it's been this way for a long time.

Note that if a screen is connected to the HDMI card, the problem 
disappears and sample rates are normal.
In short, do you think this is a driver bug, or just something we have 
to live with as some sort of hw anomaly?
Since nothing is connected, it does not really hurt, except PulseAudio 
gets confused (in a way that could potentially cause problems for 
low-latency output, should something be connected later on).

For reference, here's lspci of the HDMI card:

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. 
[AMD/ATI] RV710 [Radeon HD 4550] [1002:9540] (prog-if 00 [VGA controller])
	Subsystem: PC Partner Limited / Sapphire Technology Device [174b:e106]
01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] 
RV710/730 HDMI Audio [Radeon HD 4000 series] [1002:aa38]
	Subsystem: PC Partner Limited / Sapphire Technology Device [174b:aa38]


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
