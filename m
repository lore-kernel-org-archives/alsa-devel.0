From: Dan Swain <sp4md4n@gmail.com>
Subject: Possible option for driver development for
 Creamware/Sonic Core soon
Date: Sat, 9 Jun 2012 21:27:49 -0600
Message-ID: <20120609212749.c3ccbae670815b2c1d9b2c87@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 44D7F2438D
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Jun 2012 05:28:16 +0200 (CEST)
Received: by ghbg24 with SMTP id g24so1884924ghb.38
	for <alsa-devel@alsa-project.org>; Sat, 09 Jun 2012 20:28:14 -0700 (PDT)
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

Dear all,

I've recently acquired one of the less-recent Creamware Luna cards. After reading on Nabble that someone expressed an interest in ALSA drivers for these cards two years ago (and hearing from Paul Davis that he'd been unsuccessful in gaining enthusiasm from Creamware), I decided to get in touch with the community that supports these cards on forums.planetz.com

It appears that in 2006, Sonic Core bought Creamware, and began developing their own framework to program the DSPs on the original cards, plus some new creations by them. This platform is known as Scope, and the most current version is 5.1, which is compatible with Windows 32 and 64-bit operating systems.

However, they (Sonic Core) are working on Scope 6.0, which is intended to be a cross-platform system. From what I've been reading, they are using the JUCE framework as the basis of their development for this version, so they can target (primarily) Windows AND Mac OSX systems. Some interest has been noted for a Linux version too, after I started this thread: http://forums.planetz.com/viewtopic.php?f=5&t=31065

>From what I'm aware, the Sonic Core developers drop in to that forum now and again, so it may be possible to get informed responses.

The plug-in base for these cards is quite extensive, even with the free ones developed by community members, particularly synthesisers, so it would make a wonderful addition to the Linux audio world

I'm new to Sonic Core as well, and unfortunately I'm not a programmer, though I wouldn't be averse to trying to help in any way I can. My understanding here is that all that needs to be developed is a driver that connects to Sonic Core's framework.

Thanks for taking the time to read, and I hope this sparks some interest with the ALSA community!

Kind Regards,

Dan

-- 
Dan Swain <sp4md4n@gmail.com>
