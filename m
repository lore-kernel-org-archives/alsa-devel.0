From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Fri, 28 Sep 2012 11:33:54 +0200
Message-ID: <50656F02.5030005@ladisch.de>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 123F3261693
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 11:33:56 +0200 (CEST)
In-Reply-To: <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> @@ -1712,6 +1777,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
>  				 /* SNDRV_PCM_INFO_RESUME |*/
>  				 SNDRV_PCM_INFO_PAUSE |
>  				 SNDRV_PCM_INFO_SYNC_START |
> +				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |

... but not if this device is connected to an S/PDIF input.


Regards,
Clemens
