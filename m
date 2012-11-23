From: irfanks <irfan.shaikh@sasken.com>
Subject: SNDRV_PCM_TRIGGER_STOP not called
Date: Fri, 23 Nov 2012 17:14:50 +0530
Message-ID: <50AF61B2.5@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 72A272615ED
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 12:44:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello All,

                 We are facing issue when forceful disconnection of 
isochronous USB ALSA device (IPOD).

Problems as below :
1) SNDRV_PCM_TRIGGER_STOP in snd_usb_substream_capture_trigger() is not 
getting called.
2) We have tried calling snd_pcm_drain(), snd_pcm_drop() and 
snd_pcm_close() from application, which should STOP the PCM device as 
from API description.

But still SNDRV_PCM_TRIGGER_STOP is not getting called.

      Please can you suggest the possibilities of SNDRV_PCM_TRIGGER_STOP 
not called in usb alsa capture driver.
      Also please suggest how to achieve the above ?

Thanks in advance !! Response wil be appreciated !!!

Best Regards,
