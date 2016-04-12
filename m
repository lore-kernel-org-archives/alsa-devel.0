From: "Li, Steve" <Steve.Li@imaginecommunications.com>
Subject: Multi-channel playback
Date: Tue, 12 Apr 2016 21:16:39 +0000
Message-ID: <3CD7D8096827214EA72BFDC6B95C7CC931B68E10@VEREXCH02.harrisbroadcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 133C02650CC
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 23:16:46 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to playback a multi-channel PCM stream, e.g. 5.1. Is there an API for configuring the channel positions?

I found this API:
int snd_pcm_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);

typedef struct snd_pcm_chmap {
        unsigned int channels;
        unsigned int pos[0];
} snd_pcm_chmap_t;

But when I call it, it returns -6. Also, calling snd_pcm_get_chmap() return NULL.

Your help is appreciated.

Thanks
Steve

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________
