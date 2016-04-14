From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: Multi-channel playback
Date: Thu, 14 Apr 2016 13:58:01 +0530
Message-ID: <20160414082739.GE30953@subhransu-desktop>
References: <3CD7D8096827214EA72BFDC6B95C7CC931B68E10@VEREXCH02.harrisbroadcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C1B1C26641C
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 10:28:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3CD7D8096827214EA72BFDC6B95C7CC931B68E10@VEREXCH02.harrisbroadcast.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li, Steve" <Steve.Li@imaginecommunications.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 13, 2016 at 02:46:39AM +0530, Li, Steve wrote:
> Hi,
> 
> I am trying to playback a multi-channel PCM stream, e.g. 5.1. Is there an API for configuring the channel positions?
> 
> I found this API:
> int snd_pcm_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);
> 
> typedef struct snd_pcm_chmap {
>         unsigned int channels;
>         unsigned int pos[0];
> } snd_pcm_chmap_t;
> 
> But when I call it, it returns -6. Also, calling snd_pcm_get_chmap() return NULL.
> 
> Your help is appreciated.

Hi Steve,

You can use the chmap controls, only if the sound device has registerd
controls for chmap. So you have to check whether the chmap controls are
supported by the PCM device. I guess query_chmap can be used for this. 

Also you can refer test/chmap.c in alsa-lib on how to use those APIs.
Using a debug version of alsa library will help you as well to narrow down
what is missing.

Regards,
Subhransu

> 
> Thanks
> Steve
> 
> ______________________________________________________________________
> This email has been scanned by the Symantec Email Security.cloud service.
> For more information please visit http://www.symanteccloud.com
> ______________________________________________________________________
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
