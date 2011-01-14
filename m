From: Philip Chu <Philip.Chu@logicpd.com>
Subject: ALSA driver fails to creat ControlC1 and others...
Date: Thu, 13 Jan 2011 18:17:24 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE03E397B635@EDPREX01.logicpd.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
	<20110113234135.GD13717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B418243FA
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 01:17:31 +0100 (CET)
Received: from EDPREX01.logicpd.com (edprex01.logicpd.com [10.1.18.134]) by
	barracuda.logicpd.com with ESMTP id 74vyDyuAboPxwpZh
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for
	<alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:17:25 -0600 (CST)
In-Reply-To: <20110113234135.GD13717@opensource.wolfsonmicro.com>
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

I am having problem creating 2nd ALSA sound card driver I developed:

I found snd_ctl_dev_register() in control.c is called successfully but I do not see the 2nd sound card entry below:

# ls /dev/snd
controlC0  pcmC0D0c   pcmC0D0p   pcmC0D1c   seq        timer

And I saw a suspicious message at the end of boot steps:

Unmuting sound device: [FAIL]
Starting dropbear sshd: OK


Well, this happens with one file system, and with another file system, the 2nd card entry is created correctly as below:

# ls /dev/snd
controlC0  pcmC0D0c   pcmC1D1c   seq
controlC1  pcmC0D0p   pcmC1D1p   timer

And I don't see that message.


Anybody has some suggestions?


Thanks a lot in advance.

Philip
