From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM files for tegra-wm8903 on seaboard
Date: Thu, 19 May 2011 14:22:22 -0500
Message-ID: <BANLkTi=3n1P7V_TOdOzGY0dX9jO5ri9cQA@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47B0F@HQMAIL01.nvidia.com>
	<4DD518D5.8030509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 857A51037F5
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 21:22:26 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1051815eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 12:22:22 -0700 (PDT)
In-Reply-To: <4DD518D5.8030509@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, "jiesun@chromium.org" <jiesun@chromium.org>
List-Id: alsa-devel@alsa-project.org

>> 2) In the ChromeOS kernel, there's a separate PCM for playback to WM8903
>> and playback to the SPDIF controller, and hence on to HDMI. Since these
>> use different values for PlaybackPCM, I defined separate use-cases for
>> analog and HDMI/SPDIF playback. Is this the typical way of splitting
>> things up, or would one typically have a unified use-case with the
>> PlaybackPCM Value being part of the SectionDevice?
>
> If the use case is the same, e.g. "Music", I would just add them as different Music devices and have a PlaybackPCM for each of them.

Looks like Stephen and I share the same questions.
If we have a single "Music" use case with multiple PCM playback
devices (in the ALSA sense hw:x,y) listed the same file, how would one
specify that for example the UCM headphone or speaker devices are
valid only for the WM8903 output?
I am struggling a bit to link Devices as defined by UCM (headset,
earpiece, etc) and Devices as defined by ALSA...for example I am not
sure what the cdev statement means in the device definition.
Confused...
-Pierre
