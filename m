From: Philip Chu <Philip.Chu@logicpd.com>
Subject: OMAP3530 -- Only One Sound Card allowed for Power
 Suspension process?
Date: Tue, 24 May 2011 12:48:30 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE0426FD4CE2@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (smtp.logicpd.com [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 5045A103847
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 19:48:35 +0200 (CEST)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id EsB9YVPQqwO7k20R
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<alsa-devel@alsa-project.org>; Tue, 24 May 2011 12:48:33 -0500 (CDT)
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

And I found out the place to cause this trouble is, I have two sound cards registered in my module init function through:

platform_device_alloc("soc-audio", -1); // Beagle board sound card
and platform_device_alloc("soc-audio", 0);  // my own sound card

or

platform_device_alloc("soc-audio", 0);
and platform_device_alloc("soc-audio", 1);

If I don't register the 2nd card or register the 2nd with another name, e.g., "soc-myaudio", it can pass power suspension, but it cannot be recognized by soc_driver in soc-core.c, which is using the name "soc-audio" .

Anybody knows how I can register two sound cards and still pass power suspension?



Philip Chu

principal software engineer
LogicPD www.logicpd.com
5 Clock Tower Place, Suite 215
Maynard, MA 01754
Phone: 978-243-2450 Fax: 978-461-1598
