From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Repost: OMAP3530 ALSA -- Only One Sound Card allowed
 for Power Suspension to RAM process?
Date: Thu, 26 May 2011 13:54:22 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE0427157A97@EDPREX01.logicpd.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE0426FD4CE2@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id B9E9610384A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 20:54:26 +0200 (CEST)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id jEGXEBwADZquWORi
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<alsa-devel@alsa-project.org>; Thu, 26 May 2011 13:54:24 -0500 (CDT)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE0426FD4CE2@EDPREX01.logicpd.com>
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

Hi all,

I have a crash with power suspend to RAM using following command:

echo mem > /sys/power/state

It shows following message and hangs up:

Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds)

And I found out the place to cause this trouble is, I have two sound cards registered in my two modules' init function through:

platform_device_alloc("soc-audio", -1); // Beagle board sound card
and platform_device_alloc("soc-audio", 0);  // my own sound card


Thus /sys/devices/platform will show soc-audio and soc-audio-0 two entries.


or

platform_device_alloc("soc-audio", 0);
and platform_device_alloc("soc-audio", 1);

Thus /sys/devices/platform will show soc-audio-0 and soc-audio-1 two entries.

And if I use both (-1) it won't work:
platform_device_alloc("soc-audio", -1);
and platform_device_alloc("soc-audio", -1);


If I don't register the 2nd card at all, or register the 2nd with another name, e.g., "soc-myaudio", it can pass power suspension, but it be registered, because it cannot be recognized by soc_driver in soc-core.c, which is using the name "soc-audio" .

Anybody knows how I can register two sound cards and still pass power suspension?


Thanks in advance,

Philip Chu


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
