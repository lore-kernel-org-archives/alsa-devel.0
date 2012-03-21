From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/2] ARM: pxa: use commom IOMEM definiton
Date: Tue, 20 Mar 2012 22:33:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1203202231420.24151@xanadu.home>
References: <4F68CD9C.3090001@windriver.com>
 <1332296149-28110-1-git-send-email-robherring2@gmail.com>
 <1332296149-28110-2-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <1332296149-28110-2-git-send-email-robherring2@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-next@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@marvell.com>, Alessandro Zummo <a.zummo@towertech.it>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, rtc-linux@googlegroups.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> pxa was missed in the moving of IOMEM to a common defintion, so lots of
> IOMEM redefined warnings were introduced. So remove pxa IOMEM definition
> and fix all the fallout.

You've got at least 3 typos in the above, with 2 of them in the subject 
line alone.  ;-)


Nicolas
