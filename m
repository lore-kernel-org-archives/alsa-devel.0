From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 0/4] Internal PCM fixes / cleanups
Date: Fri, 20 Feb 2015 18:42:23 +0000
Message-ID: <1424457743.2679.74.camel@loki>
References: <1424449408-22376-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 554252605FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 19:42:28 +0100 (CET)
In-Reply-To: <1424449408-22376-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-02-20 at 17:23 +0100, Takashi Iwai wrote:
> Hi,
> 
> while reading the internal PCM (BE) handling code again, I noticed a
> few potential bugs.  Here are fix and cleanup patches.
> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (4):
>   ALSA: pcm: Minor refactoring in snd_pcm_attach_substream()
>   ALSA: pcm: Don't add internal PCMs to PCM device list
>   ALSA: pcm: Don't notify internal PCMs
>   ALSA: pcm: Don't ignore internal PCMs in snd_pcm_dev_disconnect()
> 
>  sound/core/pcm.c | 92 +++++++++++++++++++++++++-------------------------------
>  1 file changed, 41 insertions(+), 51 deletions(-)
> 

All

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
