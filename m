From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: How to understand capabilities of a mixer control
 output by "amixer"?
Date: Wed, 2 Nov 2011 15:45:21 +0800
Message-ID: <749B9D3DBF0F054390025D9EAFF47F2212D5AEED20@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B7AA245E9
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 08:46:26 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm new to ALSA. Could anybody help explain the capabilities values of an ALSA mixer control?

-          What's the difference between pvolume and pvolume-joined? Only 'Master' control has pvolume-joined, but I cannot see any GUI difference between 'Master' and 'Headerphone' by alsamixer.


-          What does the penum and cenum mean? What are they designed for? I think "p" means playback and "c" means capture. But it's confusing to see control 'Capture' also has a capability "penum"?


Here is output of amixer on my destop:

Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 51 [80%] [-13.00dB] [on]

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 60 [94%] [-4.00dB] [on]
  Front Right: Playback 60 [94%] [-4.00dB] [on]
....

Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-13.50dB] [on]
  Front Right: Capture 0 [0%] [-13.50dB] [on]

Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 9 [29%] [0.00dB] [off]
  Front Right: Capture 9 [29%] [0.00dB] [off]

Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Line'
  Item0: 'Line'

Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Line'
  Item0: 'Line'

Thanks & Best Regards
Mengdong
