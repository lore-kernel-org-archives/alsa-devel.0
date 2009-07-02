From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Help required with debugging
Date: Thu, 2 Jul 2009 10:08:35 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0907020951500.6728@eeebox2.perex-int.cz>
References: <98769532B4BB14429434178695419EAE5BAEB764@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DBF324635
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 10:08:37 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE5BAEB764@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Jul 2009, Harsha, Priya wrote:

> Why is runtime->hw_ptr_jiffies updated in hw_ptr()? This should be only 
> updated in the interrupt context right?

The idea of hw_ptr_jiffies is to have a check if real-time clock in sync 
with the DMA buffer position. If your hardware does block transfers and is 
not able to return fine position in period set SNDRV_PCM_INFO_BATCH flag. 
But it's rather a workaround than a proper fix, because timestamps are 
updated but the ring buffer position is not moved (which brokes the idea 
to have a relation between the ring buffer position and the real-time 
clock).

I think that this sort of drivers might require to implement the 
SNDRV_PCM_POS_KEEP return value in case when position does not change from 
last read to notify midlevel PCM code that they're not able to handle fine 
pointer resolution.

Also, hardware with large FIFOs should update properly runtime->delay 
value now.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
