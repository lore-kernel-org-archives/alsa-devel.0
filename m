From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Audio suspend/resume status on OMAP3 based
 platforms
Date: Wed, 13 Jan 2010 08:58:20 +0200
Message-ID: <20100113085820.6d8564d4.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id B6E501038D7
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 07:57:24 +0100 (CET)
Received: by ewy23 with SMTP id 23so303267ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 22:57:24 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Jan 2010 21:35:15 +0530
"Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:

> I want to check the status of suspend/resume functionality when audio
> subsystem is being used. Specifically, has some one tried the following 
> tests on their omap3 based platforms:
> 
> a) echo mem > /sys/power/state, when audio playback is running in 
> background
> b) same command, when audio capture is running in 
> background
> b) same command, when audio loopback is running in 
> background
> 
> I am facing some issues with (b) & (c) so wanted to confirm whether
> someone else has faced similar problem or not.
> 
Unfortunately the proper OMAP ASoC suspend/resume functionality is still
missing and the development progress has been slow. There are few
issues in low-level McBSP code like proper clock management,
context save/restore, how to deal with the FIFO, etc. and those should
be addressed first.

Fortunately Janusz Krzysztofik has been cleaning up and developing the
register cache support in McBSP and that work could help the PM work as
well. Clock management changes don't look complicated but just requires
that one develops it.

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/023119.html


-- 
Jarkko
