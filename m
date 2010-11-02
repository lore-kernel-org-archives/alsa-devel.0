From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] add API to allow disabling period
 interrupt
Date: Tue, 2 Nov 2010 09:34:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011020927190.29422@eeebox2.perex-int.cz>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CD4FC2445B
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 09:34:03 +0100 (CET)
In-Reply-To: <4CCFCA6A.8010803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Pierre-Louis Bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Nov 2010, Clemens Ladisch wrote:

>> + * When period interrupts are disabled, the application must not use poll() or
>> + * any functions that could block on this device.
>
> We should also mention that the application must call some update
> function often enough.

Reading this - the poll() inside the driver may return POLLERR when no 
period updates are invoked in the driver. It does not make much sense to 
block the application when we know that the wake up function is not 
supported.

Also all wait functions in alsa-lib should be reviewed and changed to 
return an error. Also, the blocking behaviour should not be allowed - it 
means that apps must use SND_PCM_NONBLOCK or snd_pcm_nonblock(pcm, 1) for 
this mode.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
