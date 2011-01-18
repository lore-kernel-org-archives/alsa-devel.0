From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Re: ALSA driver fails to creat ControlC1 and others...
Date: Tue, 18 Jan 2011 10:37:46 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE03E3B9EA74@EDPREX01.logicpd.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
	<20110113234135.GD13717@opensource.wolfsonmicro.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE03E397B635@EDPREX01.logicpd.com>
	<s5h1v4fga2o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id CDB80103947
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 17:37:52 +0100 (CET)
In-Reply-To: <s5h1v4fga2o.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot Takashi, udev works.

Philip

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Friday, January 14, 2011 3:32 AM
To: Philip Chu
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ALSA driver fails to creat ControlC1 and others...

At Thu, 13 Jan 2011 18:17:24 -0600,
Philip Chu wrote:
> 
> I am having problem creating 2nd ALSA sound card driver I developed:
> 
> I found snd_ctl_dev_register() in control.c is called successfully but I do not see the 2nd sound card entry below:
> 
> # ls /dev/snd
> controlC0  pcmC0D0c   pcmC0D0p   pcmC0D1c   seq        timer
> 
> And I saw a suspicious message at the end of boot steps:
> 
> Unmuting sound device: [FAIL]
> Starting dropbear sshd: OK
> 
> 
> Well, this happens with one file system, and with another file system, the 2nd card entry is created correctly as below:
> 
> # ls /dev/snd
> controlC0  pcmC0D0c   pcmC1D1c   seq
> controlC1  pcmC0D0p   pcmC1D1p   timer
> 
> And I don't see that message.
> 
> 
> Anybody has some suggestions?

udev?


Takashi
